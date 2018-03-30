#!/bin/bash
set -e

echo $SMTP_HOST
echo $SMTP_PORT

if [ -z "$1" ]; then
  postconf -e 'relayhost = [$SMTP_HOST]:$SMTP_PORT'

  echo "[smtp.mailgun.org] ${SMTP_USER}:${SMTP_PASSWORD}" > /etc/postfix/sasl_passwd
  chmod 600 /etc/postfix/sasl_passwd
  postmap /etc/postfix/sasl_passwd
  echo "postfix EMAIL/PASS combo is setup."
  /etc/init.d/postfix start
  touch /var/log/mail
  tail -F /var/log/mail*
  # TODO: working logs
else
  exec "$@"
fi