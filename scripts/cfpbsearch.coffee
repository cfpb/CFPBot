# Description:
#   Searches a URL hosting a running instance of https://github.com/cfpb/github-wiki-search
#
# Dependencies:
#   "underscore": "1.8.3"
#
# Configuration:
#   HUBOT_SEARCH_URL - a URL that hosts a running instance of https://github.com/cfpb/github-wiki-search
#
# Commands:
#   hubot search help - Get help on how to use this search tool
#   hubot search <term> - Searches at a URL that hosts https://github.com/cfpb/github-wiki-search. Searches wiki, README, gh-pages, github and Jira issues
#   hubot search wiki <term> Same as hubot search, but limiting to just wiki sources
#   hubot search readme <term> Same as hubot search, but limiting to just README sources
#   hubot search ghpage <term> Same as hubot search, but limiting to just gh-pages sources
#   hubot search issue <term> Same as hubot search, but limiting to just GitHub and Jira issue sources
#
# Author:
#   marcesher

module.exports = (robot) ->
  _  = require("underscore")



  robot.respond /search help$/i, (msg) ->
    msg.reply "
      Use search <term> to search GitHub Wikis, READMEs, and gh-pages\n
      Use search wiki <term> to search GitHub Wikis\n
      Use search readme <term> to search GitHub READMEs\n
      Use search ghpage <term> to search GitHub gh-pages\n
      Use search issue <term> to search GitHub and Jira issues\n
    "

  robot.respond /search (wiki|readme|issue) (.*)$/i, (msg) ->
    postSearch(msg, msg.match[2], msg.match[1])

  robot.respond /search (ghpage|ghpages|gh-pages) (.*)$/i, (msg) ->
    postSearch(msg, msg.match[2], "gh_page")

  # hate using this negative lookahead, but couldn't figure out a better way to get it to NOT trip this search
  # without this, searching specific sources such as hubot search wiki <term> would also trigger this response
  robot.respond /search (?!(next|wiki|readme|issue|ghpage|ghpages|gh-pages|help))\s?(.*)$/i, (msg) ->
    postSearch(msg, msg.match[2], "wiki,readme,gh_page,issue")

  robot.respond /search next$/i, (msg) ->
    if !hasSearch(msg)
      msg.reply "No previous search existed. Use `#{robot.name} search help` to learn how to use this"
    else
      search = getSearch(msg)
      nextPage = search.page + 1
      postSearch(msg, search.term, search.sources, nextPage)

  # stores a user's search on the User object
  saveSearch = (msg, term, sources, page) ->
    msg.message.user.searchTerm = term
    msg.message.user.searchSources = sources
    msg.message.user.searchPage = page

  # fetch a stored search; returns an empty object if no previous search found
  getSearch = (msg) ->
    if !msg.message.user.searchPage
      return {}
    else
      return {term: msg.message.user.searchTerm, sources: msg.message.user.searchSources, page: msg.message.user.searchPage}

  # determine if a previous search exists
  hasSearch = (msg) ->
    return getSearch(msg).hasOwnProperty("term")

  # the main search and reply function
  postSearch = (msg, term, sources, page=1) ->
    saveSearch(msg, term, sources, page)

    if page == 1
      msg.send "Searching #{sources} for #{term}. Any results will be sent via PM."

    searchObj = {
      _source: true,
      stored_fields: ["url", "title", "source"],
      highlight: {},
      query: {
        bool: {
          filter: {"terms": {"_type": sources.split(",")}},
          must: {match: {_all: term}}
        }
      },
      stored_fields: ["url", "title",  "source"],
      highlight: {}
    }

    data = JSON.stringify(searchObj)

    pageSize = 20
    from = (pageSize*page) - pageSize
    searchUrl = "#{process.env.HUBOT_SEARCH_URL}/search/search/_search?size=#{pageSize}&from=#{from}"
    robot.http(searchUrl)
    .header('Content-Type', 'application/json')
    .post(data) (err, res, body) ->

      if err
        msg.send("Searching #{searchUrl}, Got error: #{err}")
        return

      result = null
      try
        result = JSON.parse body
        totalPages = Math.ceil(result.hits.total / pageSize)

        if result.hits.hits.length
          resp = "#{result.hits.total} Results. Returning page #{page} of #{totalPages} for search term [#{term}] using sources #{sources}\n\n"
          (resp += "#{hit._source.title} : #{hit._source.url} \n" for hit in result.hits.hits)

          if totalPages > page
            resp += "\n\nType `search next` for more results"

          robot.messageRoom msg.message.user.name, resp
        else
          msg.send "No results found"

      catch error
        msg.send "Ran into an error processing results :( Check the bot's log."
        robot.logger.error "Error processing search results."
        robot.logger.error body
        robot.logger.error error
        return
