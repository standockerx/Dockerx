from docker.io/amd64/debian:trixie-20261104-slim

copy 'debian.sources' '/etc/apt/sources.list.d/debian.sources'

run apt-get update \
 && apt-get upgrade -y \
 && apt autoremove

run echo 'Not implemented!' >&2; exit 1 # todo
