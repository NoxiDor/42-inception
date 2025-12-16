NAME=inception

$(NAME): up

up:
	sudo docker-compose -f srcs/docker-compose.yml up

down:
	sudo docker-compose -f srcs/docker-compose.yml down

build:
	sudo docker-compose -f srcs/docker-compose.yml build

clean: down
	sudo rm -rf ~/data/

re: down build

.PHONY: build up down clean re
