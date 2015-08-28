# Description:
#   checks an acronym against a set of acronyms used at CFPB and provides its meaning
#
# Dependencies:
#   local json file "acro.json"
#
# Commands:
#   hubot define <term> - returns an acronym's meaning if it's in acro.json
#
# Author:
#   higginsw

module.exports = (robot) ->
  
  fs = require 'fs'
  acroPath = process.cwd()+'/acro.json'
  acroList = JSON.parse(fs.readFileSync(acroPath, 'utf8'))

  robot.respond /define (.*)$/i, (res) ->
    term = res.match[1].toUpperCase()
    if term of acroList
      res.send buildAnswer(term) 
    else
      res.send "Sorry, can't find #{term}"

  buildAnswer = (term) ->
    acroObj = acroList[term]
    answer = "#{acroObj.acro} stands for #{acroObj.name}"
    if acroObj.note
      answer = answer + " — " + acroObj.note
    if acroObj.link
      answer = answer + " – " + acroObj.link
    return answer
