all: run

build:
	sudo docker build -t dbrouwer/uwsgi-flask .

exec:
	sudo docker exec -t -i $(shell sudo docker ps | grep uwsgi-flask | awk '{print $$1}') bash -l

run: build
	sudo docker run -d -P dbrouwer/uwsgi-flask

stop:
	sudo docker stop $(shell sudo docker ps | grep uwsgi-flask | awk '{print $$1}')

remove:
	sudo docker rmi -f dbrouwer/uwsgi-flask

port:
	sudo docker port $(shell sudo docker ps | grep uwsgi-flask | awk '{print $$1}')
