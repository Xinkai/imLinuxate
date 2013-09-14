####################
# Utility
####################

min2 = (a, b) ->
    if a < b
        return a
    else
        return b

####################
# Initialization
####################

disabledSeconds = 0 # in seconds
tickId = null # for setInterval
platformString = null

####################
# Things happen here
####################

sendCountdown = ->
    # send countdown to popup
    browser.emit("countdown",
        cd: disabledSeconds
    )

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


browser.initialize ->
    browser.on "query", ->
        browser.emit "queryresult",
            isFreeOS: browser.isFreeOS
            cd: disabledSeconds

    browser.on "disable", ->
        setCountDown(disabledSeconds + 60 * 3)

    browser.on "enable", ->
        setCountDown(0)

    browser._addRequestHeaderHook()

