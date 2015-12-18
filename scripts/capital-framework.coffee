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

  Registry = require('npm-registry')
  npm = new Registry
  semver = require('semver')

  pingNpm = setInterval () ->
    npm.packages.details 'capital-framework', (err, data) ->
      old = robot.brain.get('latest-cf') or '999.999.999'
      knew = data[0].latest.version
      if semver.gt(knew, old)
        msg = 'Version ' + knew + ' of Capital Framework was just released. ' +
              'https://github.com/cfpb/capital-framework/blob/canary/CHANGELOG.md'
        console.log 'Capital Framework has changed: ', knew
        robot.messageRoom process.env.HUBOT_CF_ROOM, msg
      else
        msg = 'Version ' + knew + ' of Capital Framework was just released. ' +
              'https://github.com/cfpb/capital-framework/blob/canary/CHANGELOG.md'
        console.log 'Capital Framework has not changed. ', old
      robot.brain.set 'latest-cf', knew
      return
  , 60000
