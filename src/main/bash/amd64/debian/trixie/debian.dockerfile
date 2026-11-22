from docker.io/amd64/debian:trixie-20261104-slim

run apt-get update && apt-get install --no-install-recommends -y ca-certificates

copy 'debian.sources' '/etc/apt/sources.list.d/debian.sources'

run apt-get update \
 && apt-get upgrade -y \
 && apt autoremove

run apt-get install --no-install-recommends -y curl \
 && curl --version

run apt-get install --no-install-recommends -y openssl \
 && openssl version

run echo 'Not implemented!' >&2; exit 1 # todo
