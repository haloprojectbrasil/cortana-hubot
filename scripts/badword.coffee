# Description
#   Toda vez que um palavrão é dito, o bot irá responder de alguma forma
#
# Dependencies:
#   none
#
# Configuration:
#   none
#
# Commands:
#   <trigger> - Respond with something
#
# Notes:
#   none
#
# Author:
#   Germano Corrêa <germanobruscato@gmail.com>

module.exports = (robot) ->
    palavroes=['porra','merda','caralho','buceta','fdp','filho da puta','fuder','fudeu','fuck']
    replies=['Your mother did not give you education?','Master Chief wouldn\'t be proud of you','Living with this Neanderthals, how they expect me to not come into rampancy?']
    for badword in palavroes
      robot.hear badword, (res) ->
          res.send res.random replies
