"use strict"

#navigator = {
#    appVersion, platform , userAgent, oscpu
#}
#clientInformation = {
#
#}

class Faker
    constructor: (navigator) ->
        {@appVersion, @platform, @oscpu, @userAgent} = navigator

    getUserAgent: ->
        if not @userAgent
            return ""

        regex = /\(.+?\)/

        uaFragment = @userAgent.match(regex)[0]

        array = uaFragment.substring(1, uaFragment.length - 1) # strip ( and )
                          .split("; ")

        wow64Index = array.indexOf("WOW64")
        @is64bit = wow64Index isnt -1
        if @is64bit
            array.splice(wow64Index, 1) # remove WOW64
            array[0] = "X11; Linux x86_64"
        else
            array[0] = "X11; Linux i686"

        uaFragment = "(#{array.join('; ')})"

        return @userAgent.replace(regex, uaFragment)

    getOSCPU: ->
        if not @oscpu
            return undefined

        return @getPlatform()

    getPlatform: ->
        if @is64bit
            return "Linux x86_64"
        else
            return "Linux i686"

    getAppVersion: ->
        if @appVersion.indexOf(")") is @appVersion.length - 1 # '5.0 (Windows)' something like this
            return "5.0 (X11)" # Firefox style
        else
            return @getUserAgent().substr("Mozilla/".length)

    get: ->
        return {
            userAgent: @getUserAgent()
            platform: @getPlatform()
            oscpu: @getOSCPU()
            appVersion: @getAppVersion()
        }

if exports
    # when running test in a nodejs environment
    exports.Faker = Faker

else
    # when running inside a browser
    inject = ->
        Object.defineProperties(navigator, {
            appVersion:
                __proto__: null
                configurable: false
                get: -> "Overriden"
            platform:
                __proto__: null
                configurable: false
                get: -> "Overriden"
            oscpu:
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