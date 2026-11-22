from docker.io/amd64/debian:trixie-20261104-slim

#

run apt-get update && apt-get install --no-install-recommends -y ca-certificates

copy 'debian.sources' '/etc/apt/sources.list.d/debian.sources'

run apt-get update && apt-get upgrade -y && apt autoremove

#

run apt-get install --no-install-recommends -y curl && curl --version

run apt-get install --no-install-recommends -y openssl && openssl version

run apt-get install --no-install-recommends -y gpg gpg-agent && gpg --version

run apt-get install --no-install-recommends -y zip unzip && zip --version

run apt-get install --no-install-recommends -y xz-utils && xz --version

run apt-get install --no-install-recommends -y git && git --version

run apt-get install --no-install-recommends -y xxd && xxd --version

run apt-get install --no-install-recommends -y file && file --version

#

run ln -s /bin/bash '/usr/local/bin/bash' && /usr/local/bin/bash --version

shell ["/usr/local/bin/bash", "-c"]

#

env YQ_VERSION='4.54.3'
env PATH="${PATH}:/opt/yq-${YQ_VERSION}/bin"
run mkdir -p "/opt/yq-${YQ_VERSION}/bin" \
 && curl -m 16 -L --url "https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_amd64" -o "/opt/yq-${YQ_VERSION}/bin/yq" \
 && chmod +x "/opt/yq-${YQ_VERSION}/bin/yq" && yq --version

#

env RIPGREP_VERSION='15.2.0'
run TMP_PATH="$(mktemp -d)/ripgrep-${RIPGREP_VERSION}.deb" \
 && curl -m 16 -L --url "https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VERSION}/ripgrep_${RIPGREP_VERSION}-1_amd64.deb" -o "${TMP_PATH}" \
 && apt-get install --no-install-recommends -y "${TMP_PATH}" && rm "${TMP_PATH}" && rg --version

#

copy 'gpg_loopback.sh' '/usr/local/bin/gpg_loopback.sh'

#

arg DOCKERX_IMAGE_FLAVOR

run printf '%s' "${DOCKERX_IMAGE_FLAVOR}" > /etc/flavor

#
