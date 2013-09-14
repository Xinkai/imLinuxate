"use strict"

formatSeconds = (seconds) ->
    m = "0" + (seconds / 60 | 0)
    s = "0" + (seconds % 60)
    return m.substr(m.length - 2) + ":" + s.substr(s.length - 2)

if typeof chrome isnt "undefined"
    bgPage = chrome.extension.getBackgroundPage()
    console = bgPage.console

    try
        popup =
            on: (type, callback) ->
                chrome.runtime.onMessage.addListener (payload) ->
                    if payload.type is type
                        callback(payload.msg)
            emit: (type, msg) ->
                payload =
                    type: type
                    msg: msg
                chrome.runtime.sendMessage payload

            onload: (callback) ->
                document.addEventListener('DOMContentLoaded', callback)

    catch error
        console.error error
else
    popup =
        emit: self.port.emit
        on: self.port.on

        onload: (callback) ->
            # In Firefox, DOM is already ready.
            callback()



popup.onload ->
    $status = document.getElementById("status")
    $btnDisable = document.getElementById("btnDisable")
    $btnEnable = document.getElementById("btnEnable")

    popup.on "queryresult", (result) ->
        if result.isFreeOS
            $status.innerHTML = "Running on free OS"
            $status.className = "working"
            return # TODO: for debugging
            $btnDisable.disabled = true
            $btnEnable.disabled = true
        echoCountdown(result.cd)

    popup.on "countdown", (payload) ->
        echoCountdown(payload.cd)

    popup.emit("query")

    $btnDisable.addEventListener("click", ->
        popup.emit("disable")
    )

    $btnEnable.addEventListener("click", ->
        popup.emit("enable")
    )

    echoCountdown = (cd) ->
        if cd > 0
            $status.innerHTML = "disabled for " + formatSeconds(cd)
            $status.className = "disabled"
        else if cd is 0
            $status.innerHTML = "working"
            $status.className = "working"

    console.log "popup DOM Loaded"
