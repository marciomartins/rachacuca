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
--
  local w       = display.contentWidth		
  local h       = display.contentHeight
  local centerX = display.contentWidth/2 
  local centerY = display.contentHeight/2

  local tamanhoPecas = 90
  local maxLinhas = 2
  local maxColunas = 2

  local minX  = centerX - (maxColunas * tamanhoPecas)/2 + tamanhoPecas/2
  local minY  = centerY - (maxLinhas * tamanhoPecas)/2 + tamanhoPecas/2 - 15

  local tabelaPecas = {}
  local tabelaNumeros = {}
  local gameEstaRodando  = true

  local solucaoString1 = ""
  local solucaoString2 = ""

  -- Labels & Buttons
  local gameMensagemStatus

  -- Declaração das funções 
  local prepData

  local drawBoard

  local checkSeResolvido

  local shuffle

  -- Listener Declarations
  local onTouchPeca

  prepData = function()
	solucaoString1 = ""
	solucaoString2 = ""
	tabelaNumeros = {}

	local count = 1  
	for row = 1, maxLinhas do
		for col = 1, maxColunas do
			if not (row == 1 and col == 1) then
				solucaoString1 = solucaoString1 .. count
				tabelaNumeros[count] = count
				--Adiciona ao grupo para ser removido
				--group:insert( tabelaNumeros[count] )
				count = count + 1
			end
		end
	end
	solucaoString2 = solucaoString1 .. " "
	solucaoString1 = " " .. solucaoString1
	shuffle( tabelaNumeros , 10 )
  end

  drawBoard = function()

	local count = 1 

	for row = 1, maxLinhas do
		local y = minY + (row - 1) * tamanhoPecas

		for col = 1, maxColunas do
			local x = minX + (col - 1) * tamanhoPecas

			if not (row == 1 and col == 1) then
				local boardPiece =  display.newRect( 0, 0, tamanhoPecas, tamanhoPecas )

				boardPiece.x = x
				boardPiece.y = y
				boardPiece:setFillColor( 0.125,0.125,0.125,1 )
				boardPiece:setStrokeColor( 0.5,0.5,0.5,1 )
				boardPiece.strokeWidth = 2

				local gridMarker =  display.newText( tabelaNumeros[count], 0, 0, native.systemFont, 20 ) -- Tip: Uncomment the shuffle code in prepData() for a fully sorted board.
				gridMarker.x = x
				gridMarker.y = y

				gridMarker:setFillColor( 0.5,0.5,0.5,1 )

				boardPiece.myMarker = gridMarker

				boardPiece.row = row
				boardPiece.col = col

				boardPiece:addEventListener( "touch", onTouchPeca )

				if(not tabelaPecas[col]) then
					-- Adicionando uma sub-tabela (matiz)
					tabelaPecas[col] = {}
				end

				tabelaPecas[col][row] = boardPiece
				--Adiciona ao grupo para poder ser removido
				group:insert( tabelaPecas[col][row] )
				group:insert( tabelaPecas[col][row].myMarker )
				count = count + 1

			end

		end
	end		
	
	gameMensagemStatus = display.newText( "Ainda não resolvido." , 0, 0, native.systemFont, 24 )
	gameMensagemStatus.x = centerX
	gameMensagemStatus.y = h - 20
  end

  checkSeResolvido = function()

	local puzzleString = "" 
	
	for row = 1, maxLinhas do
		for col = 1, maxColunas do
			if( tabelaPecas[col][row] == nil ) then
				puzzleString = puzzleString .. " "
			else
				puzzleString = puzzleString .. tabelaPecas[col][row].myMarker.text
			end
		end
	end

	print( "|" .. puzzleString .. "|" )
	print( "|" .. solucaoString1 .. "|" )
	print( "|" .. solucaoString2 .. "|" )

	if( puzzleString == solucaoString1 ) then
		return true
	end
	if( puzzleString == solucaoString2 ) then
		return true
	end

	return false
  end

  shuffle = function( t, passes )
	local passes = passes or 1
	for i = 1, passes do
		local n = #t 
		while n >= 2 do
			-- n is now the last pertinent index
			local k = math.random(n) -- 1 <= k <= n
			-- Quick swap
			t[n], t[k] = t[k], t[n]
			n = n - 1
		end
	end 
	return t
  end

  function isEmpty(row,col)
	return tabelaPecas[col][row] == nil
  end

  onTouchPeca = function( event )
	
	local phase  = event.phase  
	local target = event.target

	local row    = target.row
	local col    = target.col

	-- Se o jogo terminou ignorar o top
	if( not gameEstaRodando ) then
		return true
	end

	if( phase == "ended" ) then

		-- Tenta mover a peça que acabou de ser tocada...		
		if( (col-1) > 0 and isEmpty( row, col-1 ) ) then  -- Para esquerda
			print("Is empty to the left")
			target.x = target.x - tamanhoPecas
			target.myMarker.x = target.x
			tabelaPecas[target.col][target.row] = nil
			target.col = target.col - 1
			tabelaPecas[target.col][target.row] = target

		elseif( (col+1) <= maxColunas and isEmpty( row, col+1 ) ) then -- Para direita
			print("Is empty to the right")
			target.x = target.x + tamanhoPecas
			target.myMarker.x = target.x
			tabelaPecas[target.col][target.row] = nil
			target.col = target.col + 1
			tabelaPecas[target.col][target.row] = target

		elseif( (row-1) > 0 and isEmpty( row-1, col ) ) then  -- Para cima 
			print("Is empty above")
			target.y = target.y - tamanhoPecas
			target.myMarker.y = target.y
			tabelaPecas[target.col][target.row] = nil
			target.row = target.row - 1
			tabelaPecas[target.col][target.row] = target

		elseif( (row+1) <= maxLinhas and isEmpty( row+1, col ) ) then -- Para baixo
			print("Is empty below")
			target.y = target.y + tamanhoPecas
			target.myMarker.y = target.y
			tabelaPecas[target.col][target.row] = nil
			target.row = target.row + 1
			tabelaPecas[target.col][target.row] = target
		else
			-- Não foi possível mover a peça
			return true
		end 

		-- Verifica se a ordem foi alcançada.
		if( checkSeResolvido( ) ) then
			gameMensagemStatus.text = "Parabéns!"
			storyboard.gotoScene( "scene_results" )
			gameEstaRodando = false
		end
	end

	return true
  end  
 --
  
  prepData()
  drawBoard()
  group:insert( gameMensagemStatus )
  --if tabelaPecas[1][1]== nil then
  --  print("Tabela")
  --  tabelaPecas[1][1]:removeSelf()
  --self.view:insert( tabelaPecas[1][1] )
  --group:insert( tabelaPecas )
  --group:insert( tabelaNumeros )
	  
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
