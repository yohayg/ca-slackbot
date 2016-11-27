request = require 'request'

class Utils

  progressCallback: ()->
    RegistrationHandler = ()->
      @registeredListeners = {}
      @register = (robot, exp, callback) ->
        if (@registeredListeners[exp])
          return
        else
          @registeredListeners[exp] = 1
        robot.respond exp, callback
    return
  requestp: (params) ->
    url = params.url
    headers = params.headers or {}
    method = params.method or 'GET'
    jar = params.jar or {}
    form = params.form or {}
    progressCallback = @progressCallback or () ->
    new Promise((resolve, reject) ->
      reqData = {
        uri: url
        headers: headers
        method: method
      }
      if jar
        reqData.jar = jar
      if form
        reqData.form = form
#      console.log reqData

      request reqData, (err, res, body) ->
        progressCallback(err, res, body)
        if err
          console.log err
          return reject(err)
        else if res.statusCode == 200 || res.statusCode == 302 || res.statusCode == 400
#          console.log body
          resolve res, body
        else
          err = new Error('Unexpected status code: ' + res.statusCode)
          err.res = res
          console.log err
          return reject(err)
        resolve res, body
        return
      return
    )



module.exports = Utils
