#!/usr/local/bin/bash

unset DOCKERX_WORKDIR

while [[ $# -gt 0 ]]; do
 if [[ $# -lt 2 ]]; then echo 'Wrong flags!' >&2; exit 1; fi
 case "$1" in
  '--workdir')
   if [[ -v DOCKERX_WORKDIR ]]; then echo "\"$1\" already used!" >&2; exit 1; fi
   DOCKERX_WORKDIR="$2"; shift 2;;
  *) echo "\"$1\" is not supported!" >&2; exit 1;;
 esac
done

#

if [[ ! -v DOCKERX_WORKDIR ]]; then
 DOCKERX_WORKDIR="$(pwd)"
 if [[ $? != 0 ]]; then echo 'Get workdir error!' >&2; exit 1; fi
fi

if [[ -z "${DOCKERX_WORKDIR}" ]]; then
 echo 'No workdir!' >&2; exit 1
elif [[ -L "${DOCKERX_WORKDIR}" ]]; then
 echo "\"${DOCKERX_WORKDIR}\" is a symlink!" >&2; exit 1
fi

DOCKERX_WORKDIR="$(realpath -- "${DOCKERX_WORKDIR}")"
if [[ $? != 0 ]]; then
 echo 'Realpath workdir error!' >&2; exit 1
elif [[ ! -e "${DOCKERX_WORKDIR}" ]]; then
 echo "\"${DOCKERX_WORKDIR}\" does not exist!" >&2; exit 1
elif [[ ! -d "${DOCKERX_WORKDIR}" ]]; then
 echo "\"${DOCKERX_WORKDIR}\" is not a dir!" >&2; exit 1
fi

#

DOCKERX_ARCH='amd64'
DOCKERX_PLATFORM="linux/${DOCKERX_ARCH}"
DOCKERX_HOST='docker.io'
DOCKERX_NAMESPACE='kepocnhh'
DOCKERX_SUBJECT='debian'
DOCKERX_SUBJECT_VERSION='trixie'
DOCKERX_SUBJECT_PATH="${DOCKERX_ARCH}/${DOCKERX_SUBJECT}/${DOCKERX_SUBJECT_VERSION}"
DOCKERX_REPOSITORY="${DOCKERX_SUBJECT}-${DOCKERX_SUBJECT_VERSION}-${DOCKERX_ARCH}"
DOCKERX_IMAGE_VERSION_CODE=16
DOCKERX_IMAGE_FLAVOR='a'
DOCKERX_IMAGE_TAG="${DOCKERX_IMAGE_VERSION_CODE}-${DOCKERX_IMAGE_FLAVOR}"
DOCKERX_IMAGE="${DOCKERX_HOST}/${DOCKERX_NAMESPACE}/${DOCKERX_REPOSITORY}:${DOCKERX_IMAGE_TAG}"

docker build --no-cache --progress=plain \
 -f "${DOCKERX_WORKDIR}/src/main/bash/${DOCKERX_SUBJECT_PATH}/${DOCKERX_SUBJECT}.dockerfile" \
 --platform="${DOCKERX_PLATFORM}" -t "${DOCKERX_IMAGE}" "${DOCKERX_WORKDIR}/src/main/bash/${DOCKERX_SUBJECT_PATH}/"

if [[ $? -ne 0 ]]; then
 echo 'Docker build error!' >&2; exit 1; fi

#

echo 'Not implemented!' >&2; exit 1 # todo
