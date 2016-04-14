# Description:
#   Get a meme from http://memecaptain.com/
#
# Dependencies:
#   None
#
# Commands:
#   hubot Y U NO <text> - Generates the Y U NO GUY with the bottom caption of <text>
#   hubot I don't always <something> but when i do <text> - Generates The Most Interesting man in the World
#   hubot successkid <text> | <text> - Success Kid
#   hubot <text> ALL the <things> - Generates ALL THE THINGS
#   hubot <text> TOO DAMN <high> - Generates THE RENT IS TOO DAMN HIGH guy
#   hubot Yo dawg <text> so <text> - Generates Yo Dawg
#   hubot All your <text> are belong to <text> - All your <text> are belong to <text>
#   hubot If <text>, <word that can start a question> <text>? - Generates Philosoraptor
#   hubot ONE DOES NOT SIMPLY <text> - Generates Boromir
#   hubot IF YOU <text> GONNA HAVE A BAD TIME - Super Cool Ski Instructor
#   hubot IF YOU <text> TROLLFACE <text> - Troll Face
#   hubot Aliens guy <text> - Aliens guy weighs in on something
#   hubot Brace yourself <text> - Ned Stark braces for <text>
#   hubot Iron Price <text> - To get <text>? Pay the iron price!
#   hubot Not sure if <something> or <something else> - Generates a Futurama Fry meme
#   hubot <text>, AND IT'S GONE - Bank Teller
#   hubot WHAT IF I TOLD YOU <text> - Morpheus What if I told you
#   hubot Good News Everyone! <text> - Futurama Good News
#   hubot WONKA <text> | <text> - Condescending Wonka.
#   hubot firstworldproblems <text> | <text> - First World Problems
#   hubot scumbagsteve <text> | <text> - Scumbag Steve
#   hubot grandma <text> | <text> - Grandma Internet n00b
#   hubot goodguygreg <text> | <text> - Good Guy Greg
#   hubot theysaid <text> | <text> - They Said AKA Laundry Room Viking
#   hubot badluckbrian <text> | <text> - Bad luck Brian
#   hubot angrywalter <text> | <text> - Angry Walter
#   hubot sociallyawesomeawkwardpenguin <text> | <text> - Socially Awesome/Awkward Penguin
#   hubot firstdayontheinternetkid <text> | <text> - First Day on the Internet Kid
#   hubot confessionbear <text> | <text> - Confession Bear
#   hubot lumberg <text> | <text> - Lumberg
#   hubot guaranteeit <text> - I Guarantee It
#   hubot boatcat <text> | <text> - I should buy a boat cat.
#   hubot oprah <text> | <text> - Oprah You get a car meme
#
# Author:
#   bobanj

module.exports = (robot) ->
  robot.respond /Y U NO (.+)/i, (msg) ->
    memeGenerator msg, 'NryNmg', 'Y U NO', msg.match[1], (url) ->
      msg.send url

  robot.respond /boatcat (.*)\s* \|\s*(.*)/i, (msg) ->
    memeGenerator msg, 'LPTw8A', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.respond /oprah (.*)\s* \|\s*(.*)/i, (msg) ->
    memeGenerator msg, '1706zQ', msg.match[1], msg.match[2], (url) ->
      msg.send url
      
  robot.respond /wonka (.*)\s* \|\s*(.*)/i, (msg) ->
    memeGenerator msg, 'Mp3Hwg', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.respond /iron price (.+)/i, (msg) ->
    memeGenerator msg, 'nqVZQel.jpg', msg.match[1], 'Pay the iron price', (url) ->
      msg.send url

  robot.respond /aliens guy (.+)/i, (msg) ->
    memeGenerator msg, 'sO-Hng', msg.match[1], '', (url) ->
      msg.send url

  robot.respond /brace yourself (.+)/i, (msg) ->
    memeGenerator msg, 'cOnPlV7.jpg', 'Brace Yourself', msg.match[1], (url) ->
      msg.send url

  robot.respond /(.*) (ALL the .*)/i, (msg) ->
    memeGenerator msg, 'Dv99KQ', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.respond /(I DON'?T ALWAYS .*) (BUT WHEN I DO,? .*)/i, (msg) ->
    memeGenerator msg, 'V8QnRQ', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.respond /successkid (.*)\s* \|\s*(.*)/i, (msg) ->
    memeGenerator msg, 'AbNPRQ', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.respond /(.*) (\w+\sTOO DAMN .*)/i, (msg) ->
    memeGenerator msg, 'RCkv6Q', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.respond /Good News Everyone! (.*)/i, (msg) ->
    memeGenerator msg, '7SthVg', 'Good News Everyone!', msg.match[1], (url) ->
      msg.send url    

  robot.respond /(NOT SURE IF .*) (OR .*)/i, (msg) ->
    memeGenerator msg, 'CsNF8w', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.respond /(YO DAWG .*) (SO .*)/i, (msg) ->
    memeGenerator msg, 'Yqk_kg', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.respond /(All your .*) (are belong to .*)/i, (msg) ->
    memeGenerator msg, 'zjodlg', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.respond /ONE DOES NOT SIMPLY (.*)/i, (msg) ->
    memeGenerator msg, 'da2i4A', 'ONE DOES NOT SIMPLY', msg.match[1], (url) ->
      msg.send url

  robot.respond /(IF YOU .*\s)(.* GONNA HAVE A BAD TIME)/i, (msg) ->
    memeGenerator msg, 'lfSVJw', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.respond /(.*)TROLLFACE(.*)/i, (msg) ->
    memeGenerator msg, 'dGAIFw', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.respond /(IF .*), ((ARE|CAN|DO|DOES|HOW|IS|MAY|MIGHT|SHOULD|THEN|WHAT|WHEN|WHERE|WHICH|WHO|WHY|WILL|WON\'T|WOULD)[ \'N].*)/i, (msg) ->
    memeGenerator msg, '-kFVmQ', msg.match[1], msg.match[2] + (if msg.match[2].search(/\?$/)==(-1) then '?' else ''), (url) ->
      msg.send url

  robot.respond /(.*)(AND IT\'S GONE.*)/i, (msg) ->
    memeGenerator msg, 'uIZe3Q', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.respond /WHAT IF I TOLD YOU (.*)/i, (msg) ->
    memeGenerator msg, 'fWle1w', 'WHAT IF I TOLD YOU', msg.match[1], (url) ->
      msg.send url

  robot.respond /scumbagsteve (.*)\s* \|\s*(.*)/i, (msg) ->
    memeGenerator msg, 'RieD4g', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.respond /angrywalter (.*)\s* \|\s*(.*)/i, (msg) ->
    memeGenerator msg, 'fWKxmQ', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.respond /badluckbrian (.*)\s* \|\s*(.*)/i, (msg) ->
    memeGenerator msg, 'zl3tgg', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.respond /theysaid (.*)\s* \|\s*(.*)/i, (msg) ->
    memeGenerator msg, 'xpQZsA', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.respond /goodguygreg (.*)\s* \|\s*(.*)/i, (msg) ->
    memeGenerator msg, '2sOGvw', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.respond /grandma (.*)\s* \|\s*(.*)/i, (msg) ->
    memeGenerator msg, 'Dz_gXw', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.respond /firstworldproblems (.*)\s* \|\s*(.*)/i, (msg) ->
    memeGenerator msg, 'QZZvlg', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.respond /firstdayontheinternetkid (.*)\s* \|\s*(.*)/i, (msg) ->
    memeGenerator msg, 'AnIdjQ', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.respond /sociallyawesomeawkwardpenguin (.*)\s* \|\s*(.*)/i, (msg) ->
    memeGenerator msg, 'LrC-gQ', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.respond /lumberg (.*)\s* \|\s*(.*)/i, (msg) ->
    memeGenerator msg, 'q1cQXg', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.respond /confessionbear (.*)\s* \|\s*(.*)/i, (msg) ->
    memeGenerator msg, 'hJpgDA', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.respond /guaranteeit (.*)/i, (msg) ->
    memeGenerator msg, 'Qgq7bg', msg.match[1], 'I GUARANTEE IT', (url) ->
      msg.send url


memeGeneratorUrl = 'http://memecaptain.com/gend_images'

getDataPayload = (imageName, topText, botText) ->
  data = getDataPayloadAdv(imageName, topText, botText, 0.05, 0, 0.9, 0.25, 0.05, 0.75, 0.9, 0.25)
  return data


getDataPayloadAdv = (imageName, topText, botText, topX, topY, topW, topH, botX, botY, botW, botH) ->
  data = {
    src_image_id: imageName,
    private: true,
    captions_attributes: [
      {
        text: topText,
        top_left_x_pct: topX,
        top_left_y_pct: topY,
        width_pct: topW,
        height_pct: topH
      },
      {
        text: botText,
        top_left_x_pct: botX,
        top_left_y_pct: botY,
        width_pct: botW,
        height_pct: botH
      }
    ]
  }
  return JSON.stringify(data)


memeGenerator = (msg, imageName, topText, botText, callback) ->
  processResult = (err, res, body) ->
    return msg.send err if err
    if res.statusCode == 303
      callback res.headers.location
    if res.statusCode == 202
      timer = setInterval(->
        msg.http(res.headers.location).get() (err, res, body) ->
          if res.statusCode == 303
            callback res.headers.location
            clearInterval(timer)
      , 2000)
    if res.statusCode > 300
      msg.reply "Sorry, I couldn't generate that meme. Unexpected status from memecaptain.com: #{res.statusCode}"
      return

  msg.http(memeGeneratorUrl)
  .header("Content-Type", "application/json")
  .header("Accept", "application/json")
  .post(getDataPayload(imageName, topText, botText)) processResult


memeGeneratorAdv = (msg, imageName, topText, botText, topX, topY, topW, topH, botX, botY, botW, botH, callback) ->
  processResult = (err, res, body) ->
    return msg.send err if err
    if res.statusCode == 303
      callback res.headers.location
    if res.statusCode == 202
      timer = setInterval(->
        msg.http(res.headers.location).get() (err, res, body) ->
          if res.statusCode == 303
            callback res.headers.location
            clearInterval(timer)
      , 2000)
    if res.statusCode > 300
      msg.reply "Sorry, I couldn't generate that meme. Unexpected status from memecaptain.com: #{res.statusCode}"
      return

  msg.http(memeGeneratorUrl)
  .header("Content-Type", "application/json")
  .header("Accept", "application/json")
  .post(getDataPayloadAdv(imageName, topText, botText, topX, topY, topW, topH, botX, botY, botW, botH)) processResult