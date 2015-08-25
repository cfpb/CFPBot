# Description:
#   checks an acronym against a set of acronyms used at CFPB and provides its meaning
#
# Dependencies:
#   local json file "acro.json"
#
# Commands:
#   hubot define help - Get help on how to use the acrobot
#   hubot define <term> - returns an acronym's meaning if it's in the set
#
# Author:
#   higginsw

module.exports = (robot) ->
  
  fs = require 'fs'
  acroPath = process.cwd()+'/acro.json'
  acroList = JSON.parse(fs.readFileSync(acroPath, 'utf8'))
  
  robot.respond /define help$/i, (res) ->
    res.reply "
      Use define <acronym> to show the meaning of a bureau acronym\n
    "

  robot.respond /define (.*)$/i, (res) ->
    term = res.match[1].toUpperCase()
    if term of acroList
      res.reply buildAnswer(term) 
    else
      res.reply "Sorry, can't find #{term}"

  buildAnswer = (term) ->
    acroObj = acroList[term]
    answer = "#{acroObj.acro} stands for #{acroObj.name}"
    if acroObj.note
      answer = answer + " — " + acroObj.note
    if acroObj.link
      answer = answer + " #{acroObj.link}"
    return answer
