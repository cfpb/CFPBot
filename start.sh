#!/bin/sh

ENV_FILE="./.env"
ENV_PRIVATE_FILE="./.env_private"
ENV_TEST_FILE="./.env_test"

if [ -f "$ENV_FILE" ]; then
   source $ENV_FILE
fi

if [ -n "$HUBOT_ENV_LOCATION" ]; then
  curl -O $HUBOT_ENV_LOCATION
  source $ENV_FILE
fi

if [ -f "$ENV_TEST_FILE" ]; then
  echo ">> Loading test variables from $ENV_TEST_FILE"
  source $ENV_TEST_FILE
fi

if [ "$HUBOT_PRODUCTION" = true ]; then
  # Remove all Hubot node modules, Hubot will install fresh copies on start up.
  rm -rf node_modules/hubot-*
  rm -rf node_modules/catops-*
  echo ">> HUBOT_PRODUCTION is set to true. Bot will connect to the live chat server."
  echo ">> This machine's local redis server will be used."
  ./bin/hubot --adapter matteruser
else

  echo ">> HUBOT_PRODUCTION is not set to true. Bot will not connect to the live chat server."
  echo ">> Feel free to fool around and run test commands."
  ./bin/hubot
fi
