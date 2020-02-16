FROM nginx:1.16.0

USER root

ENV BUILD_PACKAGES curl
RUN apt-get update -qq && apt-get install -y $BUILD_PACKAGES

RUN rm /usr/share/nginx/html/*

COPY configs/nginx.conf /etc/nginx/nginx.conf
COPY configs/default.conf /etc/nginx/conf.d/default.conf

RUN touch /var/run/nginx.pid && \
    chown -R www-data:www-data /var/run/nginx.pid && \
    chown -R www-data:www-data /var/cache/nginx && \
    chown -R www-data:www-data /etc/nginx && \
    chown -R www-data:www-data /var/log

USER www-data

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
