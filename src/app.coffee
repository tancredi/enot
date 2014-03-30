Vue = require 'vue'

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