#!/bin/sh

source ./.env
./bin/hubot --adapter mattermost --name $MATTERMOST_HUBOT_USERNAME --alias /
