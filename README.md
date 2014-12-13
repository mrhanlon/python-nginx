# python + nginx + uwsgi

A base docker image for running python webapps using uwsgi and nginx.

## Example Usage

To use this image you will want to extend this image and include your
application code and customize the nginx, uwsgi, and supervisord configuration
according to your application's needs. See
[sample_docker_config](sample_docker_config) for a configuration example.

### Dockerfile

Below is an example `Dockerfile` using this base image. This assumes that you
place the `Dockerfile` in the root of your project directory and put your
container configuration in a directory called `docker_config` in your project
directory.

```
FROM mrhanlon/python-nginx:latest

MAINTAINER Matthew R Hanlon <mrhanlon@gmail.com>

# setup project code
COPY . /project
WORKDIR /project

# install any dependencies
RUN pip install -r requirements.txt

# configure nginx, uwsgi, supervisord
# sets nginx to run interactively for supervisord, removes the default nginx
# site, and moves your nginx and supervisord configuration in place
RUN \
  echo "daemon off;" >> /etc/nginx/nginx.conf \
  && rm /etc/nginx/sites-enabled/default \
  && ln -s /project/docker_config/nginx_app.conf /etc/nginx/sites-enabled/ \
  && ln -s /project/docker_config/supervisor_app.conf /etc/supervisor/conf.d/

EXPOSE 80 443
CMD ["supervisord", "-n"]

```

See [mrhanlon/python-nginx-example-app](https://github.com/mrhanlon/python-nginx-example-app) for example usage in action.
