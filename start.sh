#!/bin/sh

ENV_FILE="./.env"
ENV_PRIVATE_FILE="./.env_private"

if [ -f "$ENV_FILE" ]; then
   source $ENV_FILE
fi

if [ -n "$HUBOT_ENV_LOCATION" ]; then
  curl -O $HUBOT_ENV_LOCATION
  source $ENV_FILE
fi

if [ -f "$ENV_PRIVATE_FILE" ]; then
   source $ENV_PRIVATE_FILE
fi

./bin/hubot --adapter matteruser --alias $MATTERMOST_HUBOT_USERNAME,.,please,bot,uhh,uhhh
