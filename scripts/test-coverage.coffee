# Description:
#   Create test report for the specified repo
#
# Commands:
#   hubot show test report ( repo )
#   hubot show test repos

jsdom = require "jsdom"
markdownTable = require "markdown-table"

COVERALLS_URL = "https://coveralls.io/"
CFPB_COVERALLS_URL = COVERALLS_URL + "github/cfpb/"
CFPB_COVERALLS_BUILD_URL = COVERALLS_URL + "builds/"

ERRORS =
    PARSE: "Error parsing data."
    CREATE: "Error creating report."
    RETREIVE: "Error retrieving data."

# Create coverage report based on passed json object
# and return report markdown.
class coverageReport
    TABLE_HEADER: ["COVERAGE", "FILE", "LINES", "RELEVANT", "COVERED", "MISSED", "HITS/LINE"]

    REGEXES =
        NUMBER_IN_TAGS: /(?:\>)\s?(\d+\.?\d)/i
        TEXT_IN_TAGS: /\>(.*)\</i

    template: (context)-> ["### #{context.repo} \n"
                           " ** Total Coverage **: #{context.coveredPercent} \n",
                           " ** Relevant Lines **: #{context.relevantLines} \n",
                           " ** Relevant Lines Covered **: #{context.coveredLines} \n",
                           " \n",
                           " #{context.table} \n",
                           " #### Updated: #{context.date}"].join('')

    constructor: (msg, commitSHA, date, data)->
        @commitSHA = commitSHA
        @coveredLines = 0
        @coveredPercent = 0
        @data || =  {}
        @date = date || data.date
        @msg = msg
        @relevantLines = 0
        @repo = msg.match[1]
        @tableData = []
        @parseData(data) if data

    getData: =>
        new Promise (resolve, reject)=>
            url = "#{CFPB_COVERALLS_BUILD_URL}#{@commitSHA}/source_files.json?sSearch=&iDisplayLength=1000"
            @msg.http(url).get() (err, res, body) =>
                try
                    resolve JSON.parse body
                catch error
                    @msg.send ERRORS.RETREIVE

    parseData: (data) ->
        unless typeof data is "object" && data.hasOwnProperty "aaData"
            @msg.send ERRORS.PARSE
            return

        # Explore using jsdom / innerHTML insead of regexes.
        for row in data.aaData
            rowData = []
            rowData.push @_searchString row[0], REGEXES.NUMBER_IN_TAGS
            rowData.push @_searchString row[2], REGEXES.TEXT_IN_TAGS
            rowData.push row[i] for i in [3...8]

            @tableData.push rowData
            @totalLines += parseInt row[3]
            @relevantLines += parseInt row[4]
            @coveredLines += parseInt row[5]

        @coveredPercent = ((@coveredLines/@relevantLines) * 100).toFixed(2) + '%'
        @tableData

    render: ->
        new Promise (resolve, reject)=>
            renderMarkdown = ()=>
                markdown = @template
                    repo: @repo
                    coveredPercent: @coveredPercent
                    relevantLines: @relevantLines
                    coveredLines: @coveredLines
                    table: markdownTable [].concat [@TABLE_HEADER], @tableData
                    date: @date
                resolve markdown

            if @tableData.length
                renderMarkdown()
            else
                @getData().then (data)=>
                    @parseData data
                    renderMarkdown()

    _searchString: (str, regex) ->
        matches = str.match regex
        matches.length && matches[1] || ""

module.exports = (robot) ->
    robot.respond /show test report (.*)/i, (msg)->
        repo = msg.match[1]
        url = "#{CFPB_COVERALLS_URL}#{repo}.json"
        msg.http(url).get() (err, res, body)->
            try
                data = JSON.parse(body)
                report = new coverageReport msg, data.commit_sha, data.created_at
                report.render().then (table)->
                    msg.send table
            catch error
                msg.send ERRORS.CREATE

    robot.respond /show test repos/i, (msg)->
        msg.http(CFPB_COVERALLS_URL).get() (err, res, body)->
            jsdom.env body,(err, window) ->
                doc = window.document
                elements = doc.querySelectorAll "[href^='#{CFPB_COVERALLS_URL}']"
                markup = []
                for element in elements
                    markup.push element.innerHTML + " \n"
                msg.send markup.join("")
