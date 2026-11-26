from docker.io/kepocnhh/debian-trixie-amd64:16-a

#

env JAVA_VERSION='21.0.13'
env JAVA_HOME="/opt/java-${JAVA_VERSION}"
env PATH="${PATH}:${JAVA_HOME}/bin"

run TMP_PATH="$(mktemp -d)" \
 && curl -L "https://github.com/adoptium/temurin21-binaries/releases/download/jdk-${JAVA_VERSION}.1%2B2/OpenJDK21U-jdk_x64_linux_hotspot_${JAVA_VERSION}.1_2.tar.gz" \
  -o "${TMP_PATH}/java-${JAVA_VERSION}.tar.gz" \
 && tar -xf "${TMP_PATH}/java-${JAVA_VERSION}.tar.gz" -C "${TMP_PATH}" \
 && mv "${TMP_PATH}/jdk-${JAVA_VERSION}.1+2" "${JAVA_HOME}" && rm -rf "${TMP_PATH}" \
 && java --version

#
