# Description:
#   UP TOP.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot highfive
#
# Author:
#   dieseltravis
 
module.exports = (robot) ->
  robot.hear /highfive/i, (msg) ->
    images = [
      "http://i.imgur.com/5mq1bel.gif",
      "https://media.giphy.com/media/xcoc51ocraLok/giphy.gif",
      "https://45.media.tumblr.com/d3264231114466a359e0cd77fdf6fac1/tumblr_nfa486QyM91tq4of6o1_500.gif"
      ]
    msg.send msg.random images
