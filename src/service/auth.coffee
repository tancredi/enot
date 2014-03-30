firebase = require '../core/firebase'
session = require '../core/session'
router = require '../core/router'
app = require '../app'

module.exports = new FirebaseSimpleLogin firebase, (err, user) =>
    if err then throw err

    session.user = user
    app.context.user = user

    if user
        router.goTo router.defaultPath