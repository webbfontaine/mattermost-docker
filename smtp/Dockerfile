FROM centos:7


RUN yum update -y
#>> Postfix setup
RUN yum install postfix cyrus-sasl-plain cyrus-sasl-md5 -y



# main.cf
RUN postconf -e smtp_tls_security_level=encrypt
RUN postconf -e smtp_sasl_auth_enable=yes
RUN postconf -e smtp_sasl_password_maps=hash:/etc/postfix/sasl_passwd
RUN postconf -e smtp_sasl_security_options=noanonymous


# Add and setup entrypoint
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 25