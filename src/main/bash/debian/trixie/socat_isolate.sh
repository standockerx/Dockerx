#!/usr/local/bin/bash

SOCAT_ADDRESS="${SOCAT_ADDRESS:-host.docker.internal}"

SOCAT_PORT="${SOCAT_PORT:-2081}"

exec /usr/bin/socat "UNIX-LISTEN:${SOCAT_SOCKET},fork,mode=0600,unlink-early" "TCP4:${SOCAT_ADDRESS}:${SOCAT_PORT}"
