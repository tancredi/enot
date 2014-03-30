notes = require '../service/notes'
session = require '../core/session'
resource = require '../core/resource'

module.exports = (data, req) ->
    notesRef = resource "notes/#{session.user.id}"
    id = req.namedParams.id
    ref = null

    notesRef.on 'child_added', (snapshot) =>
        note = snapshot.val()

        if note.id is id
            ref = snapshot.ref()
            @note = note

    @delete = =>
        ref.remove()
        router.goTo router.defaultPath