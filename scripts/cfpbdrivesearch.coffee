# Description:
#   Finds names for Google Drive file/folder IDs/URLs
#
# Dependencies:
#   "underscore": "1.8.3"
#
# Configuration:
#   HUBOT_COLLAB_SEARCH_URL - the API endpoint
#
# Commands:
#   hubot gdrive <id_or_url> - Attempts to find the name and owner for the given Google Drive ID / URL

#
# Author:
#   marcesher

module.exports = (robot) ->
  _  = require("underscore")


  robot.respond /(collab|gdrive) (.*)$/i, (msg) ->
    postSearch(msg, msg.match[2])


  # the main search and reply function
  postSearch = (msg, query) ->

    msg.send "Searching #{process.env.HUBOT_COLLAB_SEARCH_URL} for #{query}"

    searchUrl = "#{process.env.HUBOT_COLLAB_SEARCH_URL}/api?q=#{query}"

    # msg.send "URL is #{searchUrl}"
    robot.http(searchUrl)
    .get() (err, res, body) ->
      console.log "Body is #{body}"
      # console.log "Result is #{res}"

      if err
        msg.send("Searching #{searchUrl}, Got error: #{err}")
        return

      result = null
      try
        result = JSON.parse body

        if result.id
          resp = """
          | | |
          |-|-|
          | **Path**  | #{result.path}  |
          | **Name**  | **#{result.name}**  |
          | **Owner** | #{result.owner} |
          | **Help**  | [Google-to-O365 Mapping](#{process.env.HUBOT_COLLAB_HELP_DOC}) |"""


          msg.send resp
        else
          msg.send "No results found"

      catch error
        msg.send "Ran into an error processing results :( Check the bot's log."
        robot.logger.error "Error processing search results."
        robot.logger.error body
        robot.logger.error error
        return
