resource = require '../core/resource'
session = require '../core/session'
randomString = require 'random-string'
notes = require '../service/notes'

refs = []

exports.data =
    notes   : null
    note    : null
    writing : false

exports.init = ->
    @notes = notes.notes
    
    @reset = =>
        @writing = false
        @note = title: '', text: ''

    @discard = =>
        @reset()

    @save = =>
        @note.user = session.user.id
        @note.id = randomString length: 20
        @note.created = new Date().getTime()

        notes.ref.push @note, (err, foo) =>
            if err then throw err

        @reset()

    @remove = (note) =>
        return if not window.confirm 'Sure?'

        notes.refs[note.id].remove (err) =>
            if err then throw err

            for n, i in @notes
                if n and n.id is note.id
                    @notes.splice i, 1

    @reset()