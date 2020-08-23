## base image - image that Docker starts with -- in order to create application
##
##
## not the popular, not run as priviledge user - a user that is not root
## https://github.com/nginxinc/docker-nginx-unprivileged
##
## Alpine 
## - most light-weight version of the NGINX image.
## - Linux operating system designed for Docker containers.
## - No unncessary packages, allows you to add things specific to your aplication
FROM nginxinc/nginx-unprivileged:1-alpine
LABEL maintainer="roylee0704@gmail.com"


# copy the file in our project to the file path in container
COPY ./default.conf.tpl /etc/nginx/default.conf.tpl
COPY ./uwsgi_params /etc/nginx/uwsgi_params


# default values for envsubst to fill-up values on default.conf.tpl
# allow user to override it
ENV LISTEN_PORT=8000
ENV APP_HOST=app
ENV APP_PORT=9000


# switch to root user, changing something in filesystem that needs to be root
USER root 

# create a new dir
RUN mkdir -p /vol/static 
# https://chmod-calculator.com/
RUN chmod 755 /vol/static


# create an empty file
RUN touch /etc/nginx/conf.d/default.conf 

# change ownership of this file to nginx (user:group)
#
# why? because we need to run envsubst that take our template file,
# replace env vars and output it to location. (everything in entrypoint.sh)
#
# why? because it is nginx that is gonna run the entrypoint.sh,
# need to give him enough permission to update content in file
RUN chown nginx:nginx /etc/nginx/conf.d/default.conf


# here comes the entrypoint
COPY ./entrypoint.sh /entrypoint.sh
# explicitely mention this is an executable file
RUN chmod +x /entrypoint.sh



#### done everything in docker container that requires a root permissions above,
#### now can switch back to nginx user below.
#
#
# so when the build is finished, user is set to nginx!
USER nginx


# default command to run Dockerfile that can run your application
# inside your container
CMD  ["/entrypoint.sh"]