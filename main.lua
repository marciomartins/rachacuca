---------------------------------------------------------------------------------
-- Racha cuca 1.0
-- Copyright (C) Márcio Martins - 2014 All Rights Reserved.
---------------------------------------------------------------------------------
io.output():setvbuf("no") -- Não usar buffer para as mensagens de console
display.setStatusBar(display.HiddenStatusBar)

local storyboard = require( "storyboard" )
storyboard.gotoScene( "scene_splash" )