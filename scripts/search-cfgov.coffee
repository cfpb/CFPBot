# Description:
#   Searches cf.gov's crawled HTML. See https://github.com/cfpb/crawl-cfgov
#
# Dependencies:
#   "underscore": "1.8.3"
#
# Configuration:
#   HUBOT_CRAWL_SEARCH_URL - the API endpoint
#
# Commands:
#   hubot search-cfgov <search_string> - Attempts to find the string within cf.gov's HTML
#
# Author:
#   contolini
#   chosak

gist = require('quick-gist')

module.exports = (robot) ->
  _  = require("underscore")


  robot.respond /(crawl|crawl-search|searchcfgov|search-cfgov) (.*)$/i, (msg) ->
    postSearch(msg, msg.match[2])


  # the main search and reply function
  postSearch = (msg, query) ->

    msg.send "Searching consumerfinance.gov for #{query}"

    searchUrl = "#{process.env.HUBOT_CRAWL_SEARCH_URL}/?q=#{query}"

    # msg.send "URL is #{searchUrl}"
    robot.http(searchUrl)
         .get() (err, res, body) ->

      if err
        msg.send("Searching consumerfinance.gov, Got error: #{err}")
        return

      result = null
      try
        result = body
        today = new Date
        dd = today.getDate()
        mm = today.getMonth() + 1
        yyyy = today.getFullYear()
        today = mm + '/' + dd + '/' + yyyy
        desc = "Consumerfinance.gov search results for #{query} on #{today} by #{msg.envelope.user.name}"

        if result.length < 10
          msg.send "No results found :("
        else
          gist {content: result, description: desc, fileExtension: 'md'}, (err, resp, data) ->
            msg.send "Here's what I found: #{data.html_url}"

      catch error
        msg.send "Ran into an error processing results :( Check the bot's log."
        robot.logger.error "Error processing search results."
        robot.logger.error body
        robot.logger.error error
        return
