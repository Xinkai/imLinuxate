"use strict"

min2 = (a, b) ->
    if a < b
        return a
    else
        return b

disabledSeconds = 0 # in seconds
tickId = null # for setnterval
platformString = null
isFreeOS = false

chrome.runtime.getPlatformInfo (info) ->
    if info.os in ["linux", "openbsd"]
        isFreeOS = true

    switch info.arch
        when "x86-32"
            platformString = "i686"
        when "x86-64"
            platformString = "x86_64"
        when "arm"
            platformString = "ARM" # TODO: check
        else

listener = (details) ->
    if disabled_seconds >= 0
        for h in details.requestHeaders
            if h.name is 'User-Agent'
                h.value = "Overriden"
                break

        return {
            requestHeaders: details.requestHeaders
        }

chrome.webRequest.onBeforeSendHeaders.addListener(listener, {
    urls: ['<all_urls>']
}, ['blocking', "requestHeaders"])

sendCountdown = ->
    # send countdown to popup
    chrome.runtime.sendMessage
        type: "countdown"
        cd: disabledSeconds

setCountDown = (cd) ->
    disabledSeconds = min2(cd, 99 * 60 + 59) # max countdown: 99minutes 59 secounds

    # instant response
    sendCountdown()

    if tickId
        # if already ticking, no need to re-setInterval
        return

    tickId = setInterval( ->
        if disabledSeconds <= 0
            clearInterval(tickId)
            tickId = null
        else
            disabledSeconds -= 1

        sendCountdown()
    , 1000)

chrome.runtime.onMessage.addListener (msg, sender, sendResponse) ->
    if msg.type is "query"
        sendResponse
            isFreeOS: isFreeOS
            cd: disabledSeconds

    else if msg.type is "disable"
        setCountDown(disabledSeconds + 60 * 3)

    else if msg.type is "enable"
        setCountDown(0)

