"use strict"

SELF = require('sdk/self')
Ci = require("chrome").Ci



# content script inject
pageMod = require('sdk/page-mod')
pageMod.PageMod
    include: ["*", "file://*"]
    contentScriptFile: SELF.data.url('contentscript.js')
    contentScriptWhen: "start"

# UI setup
panel = require('sdk/panel').Panel
    width: 300
    height: 300
    contentURL: SELF.data.url('popup.html')
    contentScriptFile: SELF.data.url('popup.js')

widget = require('sdk/widget').Widget
    label: "imLinuxate"
    id: "btn_imLinuxate"
    contentURL: SELF.data.url("icon16.png")
    panel: panel

browser =
    type: "Firefox"
    on: panel.port.on
    emit: panel.port.emit

    _addRequestHeaderHook: ->
        events = require("sdk/system/events")
        listener = (event) ->
            channel = event.subject.QueryInterface(Ci.nsIHttpChannel)
            console.log channel.getRequestHeader("User-Agent")
        events.on("http-on-modify-request", listener)

    isFreeOS: null
    initialize: (onComplete) ->
        onComplete()

setInterval = require('sdk/timers').setInterval
clearInterval = require('sdk/timers').clearInterval