#!/usr/bin/env bash

set -eu

export MIX_ENV=prod

mix deps.get
mix release --overwrite
