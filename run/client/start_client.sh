#!/bin/bash
. ../../profile

./ngrok -config=config_client.yml start webpage
# ./ngrok -config=config_client.yml start start-all