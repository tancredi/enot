session = require '../core/session'
resource = require '../core/resource'

ref = null
refs = {}
notes = []

load = ->
    notesRef = resource "notes/#{session.user.id}"

    notesRef.on 'child_added', (snapshot) =>
        note = snapshot.val()
        refs[note.id] = snapshot.ref()
        notes.splice 0, 0, note

    notesRef.on 'child_removed', (snapshot) =>
        note = snapshot.val()
        for n, i in notes
            if n and n.id is note.id
                notes.splice i, 1

    module.exports.ref = notesRef

module.exports = { load, notes, ref, refs }