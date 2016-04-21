# Description:
#   Generates help commands for Hubot.
#
# Commands:
#   hubot help - Displays all of the help commands that Hubot knows about.
#   hubot help <query> - Displays all help commands that match <query>.
#
# URLS:
#   /hubot/help
#
# Notes:
#   These commands are grabbed from comment blocks at the top of each file.

helpContents = (name, commands) ->

  """
<!DOCTYPE html>
<html>
  <head>
  <meta charset="utf-8">
  <title>#{name} Help</title>
  <style type="text/css">
    body {
      background: #d3d6d9;
      color: #636c75;
      text-shadow: 0 1px 1px rgba(255, 255, 255, .5);
      font-family: Helvetica, Arial, sans-serif;
    }
    h1 {
      margin: 8px 0;
      padding: 0;
    }
    .commands {
      font-size: 13px;
    }
    p {
      border-bottom: 1px solid #eee;
      margin: 6px 0 0 0;
      padding-bottom: 5px;
    }
    p:last-child {
      border: 0;
    }
  </style>
  </head>
  <body>
    <h1>#{name} Help</h1>
    <div class="commands">
      #{commands}
    </div>
  </body>
</html>
  """

gist = require('quick-gist')

module.exports = (robot) ->
  robot.respond /help(?:\s+(.*))?$/i, (msg) ->
    cache = ''
    url = ''
    cmds = renamedHelpCommands(robot)
    filter = msg.match[1]

    if filter
      cmds = cmds.filter (cmd) ->
        cmd.match new RegExp(filter, 'i')
      if cmds.length == 0
        msg.send "No available commands match #{filter}"
        return

    cmds = cmds.join "\n"

    if cache == cmds
      msg.send "Full list of commands: " + url
    else
      cache = cmds
      gist {content: cmds}, (err, resp, data) ->
        url = data.html_url
        msg.send "Full list of commands: " + url


renamedHelpCommands = (robot) ->
  robot_name = robot.alias or robot.name
  help_commands = robot.helpCommands().map (command) ->
    command.replace /^hubot/i, robot_name
  help_commands.sort()
