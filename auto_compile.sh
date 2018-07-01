#!/bin/bash
. profile

NGROK_DOMAIN=${DOMAIN}

echo "[`date +'%X'`] Read NGROK_DOMAIN as ${DOMAIN}"

rm -fr ${BASEDIR}/keys/
mkdir ${BASEDIR}/keys/
cd ${BASEDIR}/keys/

echo "[`date +'%X'`] Generate keys..."
openssl genrsa -out base.key 2048
openssl req -new -x509 -nodes -key base.key -days 10000 -subj "/CN=$NGROK_DOMAIN" -out base.pem
openssl genrsa -out server.key 2048
openssl req -new -key server.key -subj "/CN=$NGROK_DOMAIN" -out server.csr
openssl x509 -req -in server.csr -CA base.pem -CAkey base.key -CAcreateserial -days 10000 -out server.crt

echo "[`date +'%X'`] Distribute keys..."
cp base.pem ${BASEDIR}/assets/client/tls/ngrokroot.crt
cp base.* server.* ${SERVER_PATH}
cp base.* server.* ${CLIENT_PATH}

echo "[`date +'%X'`] Start compile..."
rm -fr ${BASEDIR}/bin
cd ${BASEDIR}
sudo make release-server release-client
[ $? -ne 0 ] && echo "Compile failed" && exit 1
cd ${BASEDIR}/keys/

echo "[`date +'%X'`] Distribute compiled programs..."
cp ${BASEDIR}/bin/ngrokd ${SERVER_PATH}
cp ${BASEDIR}/bin/ngrok ${CLIENT_PATH}

echo "[`date +'%X'`] Replace the client config file"
sed -i "s/server_addr.*/server_addr: ${DOMAIN}${TUNNEL_PORT}/g" ${CLIENT_PATH}/config_client.yml

echo "[`date +'%X'`] Zip the pack ready for you to distribute"
7za a -r ${RUN_PATH}/client.7z ${CLIENT_PATH}/client

echo "SERVER_PATH: ${SERVER_PATH}"
echo "CLIENT_PATH: ${CLIENT_PATH}"

