#!/bin/sh

source ./.env
npm run load
if [ -z ${HUBOT_ACRO_PRIVATE_FILE} ];
    then echo "Hubot's private acronym json file location is not set as 'HUBOT_ACRO_PRIVATE_FILE'";
    else curl -o node_modules/hubot-acrogov/src/json/acro.priv.json $HUBOT_ACRO_PRIVATE_FILE;
fi
