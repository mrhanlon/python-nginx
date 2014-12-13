FROM python:2.7.8

MAINTAINER Matthew R Hanlon <mrhanlon@gmail.com>

# install nginx, supervisor, and ruby
# install rubygems for sass, compass
# install uwsgi

RUN apt-get update && \
    apt-get install -y nginx supervisor ruby ruby-dev && \
    gem install sass compass && \
    pip install uwsgi
