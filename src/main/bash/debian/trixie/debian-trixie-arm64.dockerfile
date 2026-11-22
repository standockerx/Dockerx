from docker.io/arm64v8/debian:trixie-20261104-slim

#

run apt-get update && apt-get install --no-install-recommends -y ca-certificates

copy 'debian.sources' '/etc/apt/sources.list.d/debian.sources'

run apt-get update && apt-get upgrade -y && apt autoremove

#

run apt-get install --no-install-recommends -y curl && curl --version

env OPENSSL_CONF='/dev/null'
run apt-get install --no-install-recommends -y openssl && openssl version

run apt-get install --no-install-recommends -y zip unzip && zip --version

run apt-get install --no-install-recommends -y xz-utils && xz --version

run apt-get install --no-install-recommends -y git && git --version

run apt-get install --no-install-recommends -y xxd && xxd --version

run apt-get install --no-install-recommends -y file && file --version

#

run apt-get install --no-install-recommends -y gpg gpg-agent && gpg --version

copy 'gpg_loopback.sh' '/usr/local/bin/gpg_loopback.sh'

#

run apt-get install --no-install-recommends -y socat && socat -V

copy 'socat_connect.sh' '/usr/local/bin/socat_connect.sh'
copy 'socat_isolate.sh' '/usr/local/bin/socat_isolate.sh'

#

run ln -s /bin/bash '/usr/local/bin/bash' && /usr/local/bin/bash --version

shell ["/usr/local/bin/bash", "-c"]

#

env YQ_VERSION='4.54.3'
env PATH="${PATH}:/opt/yq-${YQ_VERSION}/bin"
run mkdir -p "/opt/yq-${YQ_VERSION}/bin" \
 && curl -m 16 -L --url "https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_arm64" -o "/opt/yq-${YQ_VERSION}/bin/yq" \
 && chmod +x "/opt/yq-${YQ_VERSION}/bin/yq" && yq --version

#

env RIPGREP_VERSION='15.2.0'
env RIPGREP_HOME="/opt/ripgrep-${RIPGREP_VERSION}"
env PATH="${PATH}:${RIPGREP_HOME}/bin"
run TMP_PATH="$(mktemp -d)" \
 && curl -m 16 -L --url "https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VERSION}/ripgrep-${RIPGREP_VERSION}-aarch64-unknown-linux-gnu.tar.gz" \
  -o "${TMP_PATH}/ripgrep-${RIPGREP_VERSION}.tar.gz" \
 && tar -xf "${TMP_PATH}/ripgrep-${RIPGREP_VERSION}.tar.gz" -C "${TMP_PATH}" \
 && mkdir -p "${RIPGREP_HOME}/bin/" && mv "${TMP_PATH}/ripgrep-${RIPGREP_VERSION}-aarch64-unknown-linux-gnu/rg" "${RIPGREP_HOME}/bin/rg" && rm -rf "${TMP_PATH}"

#

arg DOCKERX_IMAGE_FLAVOR

run printf '%s' "${DOCKERX_IMAGE_FLAVOR}" > /etc/flavor

#
