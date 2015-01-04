auth = require '../core/auth'
router = require '../core/router'
session = require '../core/session'
app = require '../app'

exports.data =
    authError : null

exports.init = ->
    if session.user
        router.goTo router.defaultPath

    @signin = =>
        auth.login 'password',
            email    : @email,
            password : @password