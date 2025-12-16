NAME=inception

$(NAME): up

up:
	mkdir -p ~/data/database
	mkdir -p ~/data/wordpress
	sudo docker compose -f srcs/docker-compose.yml up

down:
	sudo docker compose -f srcs/docker-compose.yml down

build:
	sudo docker compose -f srcs/docker-compose.yml build --no-cache

clean: down
	sudo rm -rf ~/data/

re: down build

.PHONY: build up down clean re
