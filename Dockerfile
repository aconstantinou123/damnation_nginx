FROM alpine:latest

LABEL MAINTAINER="Alex Constantinou"

RUN apk --update add gettext nginx && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    mkdir /etc/nginx/sites-enabled/ && \
    mkdir -p /run/nginx && \
    rm -rf /etc/nginx/conf.d/default.conf && \
    rm -rf /var/cache/apk/* && \
    rm -rf /etc/nginx/http.d/default.conf

COPY conf.d/app.conf.template /app.conf.template

EXPOSE 80 443
CMD ["/bin/sh" , "-c" , "envsubst '$PRERENDER_TOKEN' < /app.conf.template > /etc/nginx/http.d/app.conf && exec nginx -g 'daemon off;'"]
