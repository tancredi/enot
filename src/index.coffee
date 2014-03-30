async = require 'async'
router = require './core/router'
app = require './app'

# Routes
require './routes'

# Directives
require './directive/auto-focus'

# Filters
require './filter/markdown'

# Components
components = []

init = ->
    async.each components, (component, callback) ->
        component.init callback
    , ->
        start()

start = ->
    app.init()
    router.run()

init()