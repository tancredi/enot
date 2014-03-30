session = require '../core/session'
router = require '../core/router'
auth = require '../core/auth'
app = require '../app'

module.exports = ->
    auth.logout()
    session.user = null
    app.context.user = null
    router.goTo router.defaultPath