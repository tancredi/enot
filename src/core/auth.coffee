firebase = require '../core/firebase'
session = require '../core/session'
router = require '../core/router'
app = require '../app'
notes = require '../service/notes'

module.exports = new FirebaseSimpleLogin firebase, (err, user) =>
    if err
        console.log err
        router.view.authError = err
        return

    app.context.authLoaded = true

    session.user = user
    app.context.user = user

    if user
        router.onLogin()
        notes.load()