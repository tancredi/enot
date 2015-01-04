router = require './core/router'

router

.add '/notes',
    templateName  : 'notes'
    controller    : require './controller/notes'
    title         : 'Notes'
    loginRequired : true
    slug          : 'notes'

.add '/note/:id',
    templateName  : 'note'
    controller    : require './controller/note'
    title         : 'View note'
    loginRequired : true
    slug          : 'note'

.add '/edit/:id',
    templateName  : 'edit'
    controller    : require './controller/edit'
    title         : 'Edit note'
    loginRequired : true
    slug          : 'edit'

.add '/signin',
    templateName : 'signin'
    controller   : require './controller/signin'
    title        : 'Signin'
    slug         : 'signin'

.add '/signup',
    templateName : 'signup'
    controller   : require('./controller/signup')
    title        : 'Sign-up'
    slug         : 'signup'

.add '/signout',
    templateName : 'signout'
    controller   : require('./controller/signout')
    title        : 'Sign-out'
    slug         : 'signout'

.otherwise '/notes'