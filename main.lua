---------------------------------------------------------------------------------
-- Racha cuca 1.0
-- Copyright (C) M�rcio Martins - 2014 All Rights Reserved.
---------------------------------------------------------------------------------
io.output():setvbuf("no") -- N�o usar buffer para as mensagens de console
display.setStatusBar(display.HiddenStatusBar)

local storyboard = require( "storyboard" )
storyboard.gotoScene( "scene_splash" )