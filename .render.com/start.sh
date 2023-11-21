#!/usr/bin/env bash

if [ -z "$ENV_FILE" ]; then
    echo "ENV_FILE env var is not set. Use \"config/staging.env.gpg\" for example."
    exit 1
fi

if [ -z "$ENV_FILE_PASSPHRASE" ]; then
    echo "ENV_FILE_PASSPHRASE env var is not set."
    exit 1
fi

# populates the ENV
while IFS= read -r line || [ -n "$line" ]; do
    if [[ $line =~ ^# ]]; then
        echo "Comment: $line"
    else
        IFS='=' read -r key value <<< "$line"
        # echo "Key: $key"
        # echo "Value: $value"
        # echo "KEYALUE: ${!key}"
        
        if [ -z "${!key}" ]; then
            echo "$key env var set"
            export "$key"="$value"
        else
            echo "$key env var already set to \"${!key}\", skipping..."
        fi
    fi
done < <(gpg --quiet --batch --passphrase "$ENV_FILE_PASSPHRASE" --decrypt "$ENV_FILE")

# runs the release
_build/prod/rel/francis_render/bin/francis_render start