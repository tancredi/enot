Vue = require 'vue'

Vue.directive 'auto-focus',
    bind: ->
        this.el.focus()