Vue = require 'vue'
router = require './core/router'

app = {}

app.init = ->
    view = new Vue
        el   : 'html'
        data :
            user            : null
            isAuthenticated : false
            title           : ''
            segments        : []
            authLoaded      : false

    app.context = view.$data

module.exports = app