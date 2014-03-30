config = require './config'

module.exports = new Firebase "https://#{config.firebaseId}.firebaseio.com"