#!/bin/bash
. ../../profile

sudo ./ngrokd -log="./ngrokd.log" -tlsKey=server.key -tlsCrt=server.crt -domain="${DOMAIN}" -httpAddr="${HTTP_PORT}" -httpsAddr="${HTTPS_PORT}" -tunnelAddr="${TUNNEL_PORT}" &
