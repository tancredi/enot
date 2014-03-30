auth = require '../core/auth'
router = require '../core/router'
session = require '../core/session'
app = require '../app'

module.exports = ->
    if session.user
        router.goTo router.defaultPath

    @signin = =>
        auth.login 'password',
            email: @email,
            password: @password
        , (err, user) ->
            session.user = user
            app.context.user = user
            router.goTo router.defaultPath