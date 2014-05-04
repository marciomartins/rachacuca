---------------------------------------------------------------------------------
-- SCENE NAME
-- Scene notes go here
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- Clear previous scene
storyboard.removeAll()

-- local forward references should go here --


---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------


-- Called when the scene's view does not exist:
function scene:createScene( event )
  local group = self.view
  local level1 = display.newText( "Nivel 1", 0, 0, native.systemFont, 18 )
  level1.x = display.contentCenterX
  level1.y = display.contentCenterY - 10
 
  local function onTap1( event )
    storyboard.gotoScene( "scene_level1" )
  end
  level1:addEventListener( "tap", onTap1 )
 
  group:insert( level1 )

  local level2 = display.newText( "Nivel 2", 0, 0, native.systemFont, 18 )
  level2.x = display.contentCenterX
  level2.y = display.contentCenterY + 10
 
  local function onTap2( event )
    storyboard.gotoScene( "scene_level2" )
  end
  level2:addEventListener( "tap", onTap2 )
 
  group:insert( level2 )
end


-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
  local group = self.view

end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
  local group = self.view

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
  local group = self.view

end


-- Called AFTER scene has finished moving offscreen:
function scene:didExitScene( event )
  local group = self.view

end


-- Called prior to the removal of scene's "view" (display view)
function scene:destroyScene( event )
  local group = self.view

end


-- Called if/when overlay scene is displayed via storyboard.showOverlay()
function scene:overlayBegan( event )
  local group = self.view
  local overlay_name = event.sceneName  -- name of the overlay scene
  
end


-- Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
function scene:overlayEnded( event )
  local group = self.view
  local overlay_name = event.sceneName  -- name of the overlay scene

end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "willEnterScene" event is dispatched before scene transition begins
scene:addEventListener( "willEnterScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "didExitScene" event is dispatched after scene has finished transitioning out
scene:addEventListener( "didExitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-- "overlayBegan" event is dispatched when an overlay scene is shown
scene:addEventListener( "overlayBegan", scene )

-- "overlayEnded" event is dispatched when an overlay scene is hidden/removed
scene:addEventListener( "overlayEnded", scene )

---------------------------------------------------------------------------------

return scene
