local appmetrica = require "plugin.appmetrica"
local notifications = require( "plugin.notifications.v2" )
local appKey= "96aa03c5-2062-492a-aa96-391153d00ad3"
appmetrica.init(appKey)
local bg = display.newRect( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
bg:setFillColor( .5 )
local title = display.newText( "Appmetrica", display.contentCenterX, display.contentCenterY-150, native.systemFontBold, 25 )

local logButton= display.newText( "Log Event", display.contentCenterX, display.contentCenterY , native.systemFont, 15 )

logButton:addEventListener( "tap", function (  )
    logButton.alpha = .3
    appmetrica.reportEvent("test", {hello = "world"})
    timer.performWithDelay(2000, function ()
        logButton.alpha = 1
    end)
end )

local registerNot= display.newText( "Register Notification", display.contentCenterX, display.contentCenterY-100 , native.systemFont, 15 )

registerNot:addEventListener( "tap", function (  )
    registerNot.alpha = .3
    appmetrica.reportEvent("test", {hello = "world"})
    notifications.registerForPushNotifications()
    timer.performWithDelay(2000, function ()
        registerNot.alpha = 1
    end)
end )

local function notificationListener( event )

    if ( event.type == "remoteRegistration" ) then
        appmetrica.setupPush( event.token)
    end
end

Runtime:addEventListener( "notification", notificationListener )
