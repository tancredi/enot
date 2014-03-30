auth = require '../core/auth'
session = require '../core/session'
router = require '../core/router'
app = require '../app'

module.exports = ->

    @signup = =>
        if @password is @passwordRep
            auth.createUser @email, @password, (err, user) =>
                if err then throw err

                auth.login 'password',
                    email: @email,
                    password: @password
                , (err, user) =>
                    session.user = user
                    app.context.user = user
                    router.goTo '/signin'