"use strict"

# Implement browser-dependent functions for Google Chrome

browser =
    type: "Chrome"
    on: (type, callback) ->
        chrome.runtime.onMessage.addListener (payload) ->
            if payload.type is type
                callback(payload.msg)

    emit: (type, msg) ->
        payload =
            type: type
            msg: msg
        chrome.runtime.sendMessage payload

    _addRequestHeaderHook: ->
        listener = (details) ->
            if disabledSeconds is 0
                for h in details.requestHeaders
                    if h.name is 'User-Agent'
        #                h.value = "Overriden"
                        break

                return {
                    requestHeaders: details.requestHeaders
                }

        chrome.webRequest.onBeforeSendHeaders.addListener(listener, {
            urls: ['<all_urls>']
        }, ['blocking', "requestHeaders"])
    isFreeOS: null

    initialize: (onComplete) ->
        chrome.runtime.getPlatformInfo (info) ->
            if info.os in ["linux", "openbsd"]
                browser.isFreeOS = true
            else
                browser.isFreeOS = false
            onComplete()






