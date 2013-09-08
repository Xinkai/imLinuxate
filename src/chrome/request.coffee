"use strict"

listener = (details) ->
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
