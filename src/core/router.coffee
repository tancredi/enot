Router = (require 'routy').Router
Vue = require 'vue'
template = require './template'
app = require '../app'
session = require './session'
_ = require 'lodash'

router = new Router()
viewWrap = document.getElementById 'view'
templatePath = '/view/'

redirectBack = null

router.onLogin = ->
    @goTo redirectBack || @defaultPath

beforeChange = (req) ->
    if not redirectBack? then redirectBack = req.path

    if req.route.options.loginRequired and not session.user
        router.redirect = '/signin'

changeView = (req) ->
    if not req.route.template and req.route.options.templateName
        templateName = templatePath + req.route.options.templateName

        return template.load templateName, (template) ->
            req.route.template = template
            changeView req

    app.context.viewOptions = req.route.options

    viewWrap.innerHTML = req.route.template or ''

    controller = req.route.options.controller || {}

    options =
        inherit : true
        twoWay  : true
        el      : viewWrap
        data    : _.extend {}, controller.data || {}, app.context
        methods : {}

    view = new Vue options
    module.exports.view = view

    viewWrap.setAttribute 'class', "view-#{req.route.options.slug}"

    if controller.init
        controller.init.call view, view.$data, req

router.on 'beforeChange', beforeChange
router.on 'change', changeView

module.exports = router