http = require 'superagent'

loaded = {}

load = (name, callback) ->
    path = name + '.html'

    if loaded[name]
        return callback loaded[name]

    http.get path, (data) ->
        template = data.text

        loaded[name] = template

        callback template

module.exports = { load }