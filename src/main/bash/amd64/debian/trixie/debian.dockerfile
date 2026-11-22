from docker.io/amd64/debian:trixie-20261104-slim

run rm '/etc/apt/sources.list.d/debian.sources'

run echo 'deb https://deb.debian.org/debian trixie main' > /etc/apt/sources.list; \
 echo 'deb https://deb.debian.org/debian trixie-updates main' >> /etc/apt/sources.list; \
 echo 'deb https://security.debian.org/debian-security trixie-security main' >> /etc/apt/sources.list

run apt-get update \
 && apt-get upgrade -y \
 && apt autoremove

run echo 'Not implemented!'; exit 1 # todo
