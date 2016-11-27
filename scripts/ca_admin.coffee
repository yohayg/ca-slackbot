fs = require('fs');
Utils = require('../scripts/utils.coffee')
request = require 'request'

class CA_Admin



  status: ->

    header_values= {
      'User-Agent':'Customer.io Web Hooks 1.0'
    }
    utils = new Utils()
    utils.requestp({url: 'http://www.cloudadvice.dev:3000/api/bot', headers: header_values, method: 'GET'}).then ((res) ->
      return res.body
    ), (err) ->
      console.error '%s', err.message
      console.log '%j', err.res.statusCode
      return

module.exports = CA_Admin

