config = require '../core/config'

module.exports = (path) ->
    new Firebase "https://#{config.firebaseId}.firebaseio.com/#{path}"