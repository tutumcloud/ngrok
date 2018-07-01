#!/bin/bash
export DOMAIN=ngrok.example.com

export BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Compile parameter
export SERVER_PATH=${BASEDIR}/run/server
export CLIENT_PATH=${BASEDIR}/run/client


# Run parameter
export HTTP_PORT=":202"
export HTTPS_PORT=":203"
export TUNNEL_PORT=":204"

