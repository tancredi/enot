notes = require '../service/notes'
session = require '../core/session'
resource = require '../core/resource'
router = require '../core/router'

exports.data =
    note : null

exports.init = (data, req) ->
    notesRef = resource "notes/#{session.user.id}"
    id = req.namedParams.id
    ref = null

    notesRef.on 'child_added', (snapshot) =>
        note = snapshot.val()

        if note.id is id
            ref = snapshot.ref()
            @note = note

    @save = =>
        ref.update @note, (err) =>
            if err then throw err

            router.goTo '/note/' +  id

    @delete = =>
        return if not window.confirm 'Sure?'

        ref.remove()
        router.goTo router.defaultPath