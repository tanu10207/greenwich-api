# Base Image
FROM ubuntu:18.04

# Config timezone
ENV TZ=Asia/Ho_Chi_Minh
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update Package List
RUN apt update
RUN apt install -y software-properties-common

# Install PHP
RUN add-apt-repository ppa:ondrej/php
RUN apt update
RUN apt install -y php7.2 php7.2-cli php7.2-common php7.2-fpm php7.2-bcmath php7.2-redis \
		       		   php7.2-curl php7.2-gd php7.2-json php7.2-mbstring php7.2-intl php7.2-mysql \
		       		   php7.2-xml php7.2-zip php7.2-sqlite3 php7.2-pgsql composer nginx

# Install dependencies 
COPY ./.docker/site.conf /etc/nginx/conf.d/default.conf
COPY ./code /var/www/html
WORKDIR /var/www/html
