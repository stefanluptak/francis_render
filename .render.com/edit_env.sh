#!/usr/bin/env bash

if [ -z "$EDITOR" ]; then
    echo "EDITOR env var is not set. Set it to \"code --wait\" for example."
    exit 1
fi

if [ -z "$ENV_FILE" ]; then
    echo "ENV_FILE env var is not set. Use \"config/staging.env.gpg\" for example."
    exit 1
fi

if [ -z "$ENV_FILE_PASSPHRASE" ]; then
    echo "ENV_FILE_PASSPHRASE env var is not set."
    exit 1
fi

tmp_env_file=$(mktemp)

gpg --quiet  --batch --passphrase "$ENV_FILE_PASSPHRASE" --decrypt "$ENV_FILE" > $tmp_env_file

$EDITOR "$tmp_env_file"

gpg --quiet --batch --yes --passphrase "$ENV_FILE_PASSPHRASE" -c -o "$ENV_FILE" "$tmp_env_file"

rm "$tmp_env_file"
