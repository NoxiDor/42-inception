NAME=inception

$(NAME): up

up:
	sudo docker-compose -f srcs/docker-compose.yml up --build

down:
	sudo docker-compose -f srcs/docker-compose.yml down

fclean: down
	sudo rm -rf ~/data/

re: down up

.PHONY: up down re
