#!/usr/local/bin/bash

GPG_ARGS=()

if [[ -v GPG_HOMEDIR ]]; then
 GPG_ARGS+=(--homedir "${GPG_HOMEDIR}"); fi

if [[ -v GPG_PASSWORD ]]; then
 GPG_ARGS+=(--pinentry-mode loopback --passphrase "${GPG_PASSWORD}"); fi

GPG_ARGS+=("$@")

gpg "${GPG_ARGS[@]}"
