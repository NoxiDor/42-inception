#!/bin/sh

echo "Starting nginx..."

mkdir -p /etc/ssl/certs /etc/ssl/private

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=FR/ST=Ile-de-France/L=Paris/O=42/CN=jazema.42.fr"

nginx
