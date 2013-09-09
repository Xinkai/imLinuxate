"use strict"

if chrome
    bgPage = chrome.extension.getBackgroundPage()
    console = bgPage.console

#if not self.port
#    # A simple self.port implementation, the idea is from Firefox Addon SDK
#    self.port = new Object(null)
#    port.on = (event, payload) ->
#
#    console.log "no self.port"
#else
#    console.log "self.port", self.port

document.addEventListener('DOMContentLoaded', () ->
    document.getElementById("status").className = "working"
    console.log bgPage, "<-- bgPage"

    console.log "popup DOM Loaded"
)