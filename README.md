# uwsgi-flask
Docker image with Nginx, uWSGI and a Hello World Flask app.

This image is based on my ubuntu-python 3.4 image (which in turn runs on top
of phusion/baseimage). The Hello World app is enabled and will start internally
on port 80, and a random external port is assigned on launch.

To pull this image: `docker pull dbrouwer/uwsgi-flask`   
Usage: `docker run -d -P dbrouwer/uwsgi-flask`
