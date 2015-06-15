# Description:
#   Listens for "#standup" and copies the contents to another room
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_STANDUP_COPY_ROOM - room in which to copy #standup messages. Be sure to have Hubot join that room, as well

# Author:
#   Marc Esher

module.exports = (robot) ->
  robot.hear /^\#standup/i, (msg) ->
    text = msg.message.text

    robot.messageRoom process.env.HUBOT_STANDUP_COPY_ROOM, msg.message.user.name + "'s standup: " + text.substr(text.indexOf(' ')+1, text.length)