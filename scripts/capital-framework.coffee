# Description:
#   Capital Framework notifications
#
# Dependencies:
#   "npm-registry": "0.1.13"
#   "semver": "5.1.0"
#
# Configuration:
#   HUBOT_CF_ROOM: Room to broadcast CF notifications to
#
# Author:
#   contolini

module.exports = (robot) ->

  if !process.env.HUBOT_CF_ROOM
    return

  request = require 'request'
  semver = require 'semver'

  pingNpm = setInterval () ->
    request 'https://registry.npmjs.org/capital-framework/', (err, response, body) ->
      return if err or response.statusCode != 200
      old = robot.brain.get('latest-cf') or '999.999.999'
      knew = Object.keys(JSON.parse(body).versions).pop()
      if semver.gt(knew, old)
        msg = 'Version ' + knew + ' of Capital Framework was just released. ' +
              'https://github.com/cfpb/capital-framework/blob/master/CHANGELOG.md'
        robot.messageRoom process.env.HUBOT_CF_ROOM, msg
      robot.brain.set 'latest-cf', knew
  , 180000
