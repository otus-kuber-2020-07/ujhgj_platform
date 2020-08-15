FROM nginx:alpine

RUN apk add --no-cache shadow \
    && usermod -u 1001 nginx \
    && groupmod -g 1001 nginx

COPY app.conf /etc/nginx/conf.d/app.conf
WORKDIR /app
