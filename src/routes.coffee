router = require './core/router'

router

.add '/dashboard',
    templateName: 'dashboard'
    controller: require './controller/dashboard'
    title: 'Dashboard'
    loginRequired: true
    slug: 'dashboard'

.add '/signin',
    templateName: 'signin'
    controller: require './controller/signin'
    title: 'Signin'
    slug: 'signin'

.add '/signup',
    templateName: 'signup'
    controller: require('./controller/signup')
    title: 'Sign-up'
    slug: 'signup'

.add '/signout',
    templateName: 'signout'
    controller: require('./controller/signout')
    title: 'Sign-out'
    slug: 'signout'

.otherwise '/dashboard'