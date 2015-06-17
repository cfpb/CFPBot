# Description:
#   Return a list of open issues for the requesting user
#
# Dependencies:
#   "githubot": "~0.4.0"
#   "github-credentials"
#
# Configuration:
#   HUBOT_GITHUB_API: GitHub endpoint, https://api.github.com for GitHub.com or
#     http(s)://<hostname>/api/v3 for enterprise installations
#
# Commands:
#   hubot gh me url - Returns the GitHub issues endpoint
#   hubot gh me issues  - Returns a list of your open GitHub issues
#
# Author:
#   marc esher

module.exports = (robot) ->
  _  = require("underscore")


  robot.respond /gh me url/i, (msg) ->
    msg.send "Using GitHub url #{process.env.HUBOT_GITHUB_API}/issues"

  robot.respond /gh me issues/i, (msg) ->
    mUser = msg.message.user
    user = ghUser(msg)
    token = user.githubToken
    #msg.send "token is #{token}"
    if token
      auth = "token #{token}"
      url = "#{process.env.HUBOT_GITHUB_API}/issues"
      msg.send "Fetching your issues from #{url}"

      robot.http(url)
        .headers(Authorization: auth, Accept: 'application/vnd.github.raw', 'Content-Type': 'application/json')
        .get() (err, res, body) ->

          if err
            msg.send "Error fetching issues: #{err}"
          else
            issues = JSON.parse body

            if not _.isArray issues
              msg.send "Response not an array. Boo. Body is: #{body}"
            else
              sorted = _.sortBy issues, (d) -> d.html_url
              # force a PM
              msg.send mUser.name + ", sending PM"
              mUser.type = "chat"
              resp = ""
              (resp += "#{issue.repository.name} : #{issue.title} : #{issue.html_url} \n" for issue in sorted)
              msg.send resp
              mUser.type = "groupchat"

    else
      login = user.githubLogin || "<your github username>"
      msg.send """No authorization token sent. Use #{robot.name} my oauth is <token>.
               To associate your chat user with a github username, use #{robot.name} i am <your github username>
               To associate your chat user with a previously created oauth token, use #{robot.name} my oauth is <your oauth token
               To create a new oauth token, open a terminal and type:
               curl -i #{process.env.HUBOT_GITHUB_API}/authorizations -d '{"scopes":["repo","gist"], "note": "fetching my issues from within chat"}' -u "#{login}"
                 and then tell me about it using the 'my oauth is...' command above

               """

  ghUser = (msg) ->
    u = msg.robot.brain.data.gh ?= {}
    u[msg.message.user.id] ?= {}