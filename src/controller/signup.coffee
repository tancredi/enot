auth = require '../service/auth'

module.exports = ->

    @signup = =>
        if @password is @passwordRep
            auth.createUser @email, @password, (err, user) ->
                if err then throw err