resource = require '../core/resource'
session = require '../core/session'

module.exports = ->
    notesRef = resource "notes/#{session.user.id}"
    @notes = []

    notesRef.on 'child_added', (note) =>
        @notes.push note.val()

    @reset = =>
        @writing = false
        @note = title: '', text: ''

    @discard = =>
        @reset()

    @save = =>
        @note.user = session.user.id

        notesRef.push @note, (err, foo) =>
            if err then throw err

        @reset()

    @reset()