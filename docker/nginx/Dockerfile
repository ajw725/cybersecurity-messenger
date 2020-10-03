FROM nginx:latest
RUN apt-get update -qq && apt-get -y install apache2-utils vim
COPY docker/nginx/nginx.conf /etc/nginx/conf.d/default.conf

ENV APP_HOME /var/www/application
RUN mkdir -p $APP_HOME/public
WORKDIR $APP_HOME
COPY public $APP_HOME/public/
RUN mkdir -p /var/log/nginx

EXPOSE 80
STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]
