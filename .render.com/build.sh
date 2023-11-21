#!/usr/bin/env bash

set -eu

mix deps.get
mix release --overwrite
