# Description:
#   TREAT
#   YO
#   SELF
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot treat yo self - TREAT YO SELF
#
# Author:
#   dieseltravis
 
module.exports = (robot) ->
  robot.hear /treat\s*yo\s*self/i, (msg) ->
    images = [
      "http://i.imgur.com/2gVlI1a.gif",
      "http://i.imgur.com/9zn1u7t.jpg",
      "http://i.imgur.com/qJ6eWFe.png",
      "http://i.imgur.com/kG0M4Of.jpg",
      "http://i.imgur.com/9QBoMrU.gif",
      "http://i.imgur.com/rrht9KR.png",
      "http://i.imgur.com/7y4w2yU.gif",
      "http://i.imgur.com/vrEljm3.gif",
      "http://i.imgur.com/nXOxW8i.jpg",
      "http://i.imgur.com/n8AWoUV.jpg",
      "http://i.imgur.com/lzHRGBy.gif",
      "http://i.imgur.com/lZ7e8ob.jpg",
      "http://i.imgur.com/giaBuj7.jpg",
      "http://i.imgur.com/gS1n6pP.jpg",
      "http://i.imgur.com/D4zk3PV.png",
      "http://i.imgur.com/Z11AaxI.jpg",
      "http://i.imgur.com/aZPrDcV.gif"]
    msg.send msg.random images
