Vue = require 'vue'
marked = require 'marked'

Vue.filter 'markdown', (value) -> marked value or ''