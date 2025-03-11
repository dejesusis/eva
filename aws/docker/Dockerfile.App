# syntax=docker/dockerfile:1-labs
ARG BASE_IMAGE=eva/base:latest
FROM $BASE_IMAGE 

# patch
RUN sudo apt-get update && sudo apt-get upgrade -y

# Environment variables
ARG APP_ENV
ENV APP_ENV=$APP_ENV

WORKDIR /srv/shiny-server/eva

# Copy config
COPY ./aws/config/shiny-$APP_ENV.conf /etc/shiny-server/shiny-server.conf 

# Copy project directory (if applicable)
COPY --exclude=renv . /srv/shiny-server/eva

# Set permissions
RUN chown -R shiny:shiny /srv/shiny-server/eva

USER shiny

EXPOSE 3838

CMD ["/usr/bin/shiny-server"]