FROM aboozar/nginx-php-base:7.1

LABEL Maintainer="Aboozar Ghaffari <aboozar.ghf@gmail.com>"
LABEL Name="SMSator container"
LABEL Version="20210921"
LABEL TargetImageName="aboozar/smsator"

ARG NONROOT_USER=scorpion

# add any customization you need
COPY deploy/app/php/modules.ini /etc/php/7.1/mods-available/modules.ini

# specify container's processes
COPY deploy/app/container/cron-px.conf /etc/supervisor/conf.d/cron-px.conf

RUN echo "* * * * * php /var/www/artisan schedule:run > /tmp/cron-log" >> /etc/cron.d/app-cron \
    # Give the necessary rights to the user to run the cron
    && crontab -u ${NONROOT_USER} /etc/cron.d/app-cron \
    && chmod u+s /usr/sbin/cron

EXPOSE 2222

WORKDIR /var/www/

# change container to non-root mode
USER $NONROOT_USER