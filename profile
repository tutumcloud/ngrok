#!/bin/bash
export DOMAIN=ngrok.example.com

export BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Compile parameter
export RUN_PATH=${BASEDIR}/run
export SERVER_PATH=${RUN_PATH}/server
export CLIENT_PATH=${RUN_PATH}/client


# Run parameter
export HTTP_PORT=":202"
export HTTPS_PORT=":203"
export TUNNEL_PORT=":204"

