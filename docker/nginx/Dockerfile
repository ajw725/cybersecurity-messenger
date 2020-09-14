FROM nginx:latest
RUN apt-get update -qq && apt-get -y install apache2-utils
COPY docker/nginx/reverse-proxy.conf /etc/nginx/conf.d/reverse-proxy.conf
RUN mkdir -p /var/log/nginx

EXPOSE 8080
STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]
