#!/bin/sh

source ./.env
./bin/hubot --adapter xmpp --name $MATTERMOST_HUBOT_USERNAME --alias /
