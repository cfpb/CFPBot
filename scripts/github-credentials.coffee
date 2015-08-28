# Description:
#   Github Credentials allows you to map your user against your GitHub user.
#   This is specifically in order to work with apps that have GitHub Oauth users.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot who do you know - List all the users with github logins tracked by Hubot
#   hubot i am `maddox` - map your user to the github login `maddox`
#   hubot who am i - reveal your mapped github login
#   hubot forget me - de-map your user to your github login
#   hubot oauth me - Sends a PM with your currently stored GitHub oauth token
#   hubot my oauth is <token> - Stores your GitHub oauth token created with curl. You can create it with:  $ curl -i <endpoint>/authorizations -d '{"scopes":["repo","gist"]}' -u "<username>"
#
# Author:
#   maddox

module.exports = (robot) ->

#  robot.respond /dumpall/, (msg) ->
#    console.log(robot.brain.users())
#    console.log(robot.brain.data.gh)


  robot.respond /who(m)? do you know(\?)?$/i, (msg) ->
    theReply = "Here is who I know:\n"
    for own key, user of robot.brain.data.gh
      if(user.githubLogin)
        theReply += key + " is " + user.githubLogin + "\n"

    msg.send theReply

  robot.respond /i am ([a-z0-9-]+)\s*$/i, (msg) ->
    githubLogin = msg.match[1]
    ghUser(msg).githubLogin = githubLogin
    msg.send "Ok, you are " + githubLogin + " on GitHub"

  robot.respond /who am i\s*$/i, (msg) ->
    user = ghUser(msg)
    if user.githubLogin
      msg.reply "You are known as " + user.githubLogin + " on GitHub"
    else
      msg.reply "I don't know who you are. You should probably identify yourself with your GitHub login"

  robot.respond /forget me/i, (msg) ->
    user = ghUser(msg)
    user.githubLogin = null
    user.githubToken = null

    msg.reply("Ok, I have no idea who you are anymore.")

  robot.respond /my oauth is ([a-z0-9]+)\s*$/i, (msg) ->
    token = msg.match[1]
    ghUser(msg).githubToken = token
    msg.send "Ok, token saved"

  robot.respond /oauth me$/i, (msg) ->
    console.log(msg.message)

    user = msg.message.user
    user.type = "chat"

    ghu = ghUser(msg)
    if ghu.githubToken
      t = ghu.githubToken
      msg.send "Your token starts with #{t.substr(0,4)} and ends with #{t.substr(t.length-5)}"
    else
      msg.send "I don't know the oauth token for user #{user.name}"

  # It appears that when certain (all?) chat clients exit, custom data stored on the user object is wiped out, so here
  # we store it in a separate space
  ghUser = (msg) ->
    u = msg.robot.brain.data.gh ?= {}
    u[msg.message.user.id] ?= {}