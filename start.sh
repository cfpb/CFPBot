#!/bin/sh

source ./.env
./bin/hubot --adapter xmpp --name $HUBOT_NAME --alias /
