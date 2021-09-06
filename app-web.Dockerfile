# You can use version 7.1, 7.2, 7.3, 7.4
ARG PHP_VERSION

FROM aboozar/nginx-php:$PHP_VERSION

LABEL Maintainer="Aboozar Ghaffari <aboozar.ghf@gmail.com>"
LABEL Name="My Sample app container"
LABEL Version="20210921"
LABEL TargetImageName="aboozar/my-sample-app"


# Configure custom things

COPY app/ssh/sshd_config /etc/ssh/sshd_config
COPY app/nginx/nginx.conf /etc/nginx/nginx.conf
COPY app/nginx/vhost.conf /etc/nginx/sites-enabled/default
COPY app/php/pool.conf /etc/php/7.1/fpm/pool.d/www.conf
COPY app/container/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY app/container/web-px.conf /etc/supervisor/conf.d/container-px.conf

EXPOSE 2222 8080

WORKDIR /var/www/

# change container to non-root mode
USER nazgul

CMD ["/usr/local/bin/entrypoint.sh"]
