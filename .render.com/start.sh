#!/usr/bin/env bash

set -eu

gpg --decrypt config/env.gpg | source

_build/prod/rel/francis_render/bin/francis_render start