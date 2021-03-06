#!/bin/sh

JANUS_CFG="/opt/janus/etc/janus/janus.cfg"
JANUS_TRANSPORT_HTTP_CFG="/opt/janus/etc/janus/janus.transport.http.cfg"
JANUS_TRANSPORT_WS_CFG="/opt/janus/etc/janus/janus.transport.websockets.cfg"

# Use this to set the new config value, needs 2 parameters.
# You could check that $1 and $1 is set, but I am lazy
set_config(){
    REPLACE=`echo $2 | sed 's/\//\\\\\//g'`
    echo "$3 : Using : $1=$2"
    sed -i "s/^;\?\(\s*$1\s*=\s*\).*\$/\1$REPLACE/" $3
}

if [ "$ADMIN_SECRET" != "" ]
then
    set_config admin_secret $ADMIN_SECRET $JANUS_CFG
fi

if [ "$CERT_PEM" != "" ]
then
    set_config cert_pem $CERT_PEM $JANUS_CFG
    set_config cert_pem $CERT_PEM $JANUS_TRANSPORT_HTTP_CFG
    set_config cert_pem $CERT_PEM $JANUS_TRANSPORT_WS_CFG
fi
if [ "$CERT_KEY" != "" ]
then
    set_config cert_key $CERT_KEY $JANUS_CFG
    set_config cert_key $CERT_KEY $JANUS_TRANSPORT_HTTP_CFG
    set_config cert_key $CERT_KEY $JANUS_TRANSPORT_WS_CFG
fi

if [ "$DEBUG_LEVEL" != "" ]
then
    set_config debug_level $DEBUG_LEVEL $JANUS_CFG
    set_config nice_debug true $JANUS_CFG
    set_config ws_logging $DEBUG_LEVEL $JANUS_TRANSPORT_WS_CFG
fi



/opt/janus/bin/janus