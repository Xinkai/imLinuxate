"use strict"

self = require('sdk/self')
events = require("sdk/system/events")
Ci = require("chrome").Ci

# bind http listener
listener = (event) ->
    channel = event.subject.QueryInterface(Ci.nsIHttpChannel)
    console.log channel.getRequestHeader("User-Agent")
events.on("http-on-modify-request", listener)

# content script inject
pageMod = require('sdk/page-mod')
pageMod.PageMod
    include: ["*", "file://*"]
    contentScriptFile: self.data.url('contentscript.js')
    contentScriptWhen: "start"

# UI setup
panel = require('sdk/panel').Panel
    width: 300
    height: 300
    contentURL: self.data.url('popup.html')

widget = require('sdk/widget').Widget
    label: "imLinuxate"
    id: "btn_imLinuxate"
    contentURL: self.data.url("icon16.png")
    panel: panel