FROM dbrouwer/ubuntu-python3.4
MAINTAINER Dick Brouwer <dick@dickbrouwer.com>>

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# apt get dependencies
RUN apt-get update && apt-get install -y \
  nginx

# setup nginx and uwsgi
COPY conf/runit/ /etc/service/
COPY conf/nginx/sites-available/uwsgi.conf /etc/nginx/sites-available/uwsgi.conf
RUN cd /tmp && curl http://projects.unbit.it/downloads/uwsgi-2.0.9.tar.gz | tar -xz && cd /tmp/uwsgi-2.0.9 && python3.4 setup.py install
RUN adduser --system --home /home/app --disabled-password --ingroup www-data app \
    && echo "daemon off;" >> /etc/nginx/nginx.conf && nginx -t \
    && touch /etc/service/nginx/down /etc/service/uwsgi/down \
    && rm /etc/nginx/sites-enabled/default \
    && ln -s /etc/nginx/sites-available/uwsgi.conf /etc/nginx/sites-enabled/uwsgi.conf \
    && rm -Rf /tmp/*

# Add Flask and Hello World app
RUN python3 -m pip install flask
COPY app/webapp.py /home/app/

# Enable uWSGI and nginx
RUN rm -f /etc/service/uwsgi/down /etc/service/nginx/down

EXPOSE 80
