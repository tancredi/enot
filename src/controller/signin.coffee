auth = require '../core/auth'
router = require '../core/router'
session = require '../core/session'
app = require '../app'

module.exports = ->

    @signin = =>
        auth.login 'password',
            email: @email,
            password: @password
        , (err, user) ->
            session.user = user
            app.context.user = user
            router.goTo router.defaultPath