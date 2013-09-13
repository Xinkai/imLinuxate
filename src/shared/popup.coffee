"use strict"

formatSeconds = (seconds) ->
    m = "0" + (seconds / 60 | 0)
    s = "0" + (seconds % 60)
    return m.substr(m.length - 2) + ":" + s.substr(s.length - 2)

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
    $status = document.getElementById("status")
    $btnDisable = document.getElementById("btnDisable")
    $btnEnable = document.getElementById("btnEnable")

    chrome.runtime.sendMessage({
        type: "query"
    }, (res) ->
        if res.isFreeOS
            $status.innerHTML = "Running on free OS"
            $status.className = "working"
            return # TODO: for debugging
            $btnDisable.disabled = true
            $btnEnable.disabled = true

        echoCountdown(res.cd)
    )

    $btnDisable.addEventListener("click", ->
        chrome.runtime.sendMessage
            type: "disable"
    )

    $btnEnable.addEventListener("click", ->
        chrome.runtime.sendMessage
            type: "enable"
    )

    chrome.runtime.onMessage.addListener (msg, sender) ->
        if sender.id is "apodjlbkopihjeoimcofbeldegnbdmob"
            echoCountdown(msg.cd)

    echoCountdown = (cd) ->
        if cd > 0
            $status.innerHTML = "disabled for " + formatSeconds(cd)
            $status.className = "disabled"
        else if cd is 0
            $status.innerHTML = "working"
            $status.className = "working"

    console.log "popup DOM Loaded"
)