Vue = require 'vue'
router = require './core/router'

app = {}

app.init = ->
    view = new Vue
        el: 'html'
        data:
            isAuthenticated: false
            title: ''
            segments: []

    app.context = view.$data

module.exports = app