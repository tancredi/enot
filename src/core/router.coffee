Router = (require 'routy').Router
Vue = require 'vue'
template = require './template'
app = require '../app'
session = require './session'

router = new Router()
viewWrap = document.getElementById 'view'
templatePath = '/view/'

beforeChange = (req) ->
    if req.route.options.loginRequired and not session.user
        router.redirect = '/signin'

changeView = (req) ->
    if not req.route.template and req.route.options.templateName
        templateName = templatePath + req.route.options.templateName

        return template.load templateName, (template) ->
            req.route.template = template
            changeView req

    app.context.viewOptions = req.route.options
    app.context.segments = req.path.split('/').slice 1

    viewWrap.innerHTML = req.route.template or ''

    view = new Vue el: viewWrap, data: {}, methods: {}

    viewWrap.setAttribute 'class', "view-#{req.route.options.slug}"

    if req.route.options.controller
        req.route.options.controller.call view, view.$data, req

router.on 'beforeChange', beforeChange
router.on 'change', changeView

module.exports = router