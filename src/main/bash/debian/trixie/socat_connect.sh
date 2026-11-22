#!/usr/local/bin/bash

SOCAT_ADDRESS="${SOCAT_ADDRESS:-127.0.0.1}"

SOCAT_PORT="${SOCAT_PORT:-2081}"

exec /usr/bin/socat "TCP4-LISTEN:${SOCAT_PORT},bind=${SOCAT_ADDRESS},reuseaddr,fork" "UNIX-CONNECT:${SOCAT_SOCKET}"
