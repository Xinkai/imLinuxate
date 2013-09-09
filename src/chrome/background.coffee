"use strict"

disabled_seconds = 0 # in seconds
countdown_id = null # save return value of setInterval

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