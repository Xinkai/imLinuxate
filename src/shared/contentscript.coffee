"use strict"

#navigator = {
#    platform, appVersion, userAgent
#}
#clientInformation = {
#
#}

inject = ->
    Object.defineProperties(navigator, {
        platform:
            __proto__: null
            configurable: false
            get: -> "Overriden"
        appVersion:
            __proto__: null
            configurable: false
            get: -> "Overriden"
        userAgent:
            __proto__: null
            configurable: false
            get: -> "Overriden"
    })
    console.log "imLinuxate injected."

script = document.createElement("script")
text = document.createTextNode("(#{inject.toString()})()")
script.appendChild(text)
document.documentElement.appendChild(script)