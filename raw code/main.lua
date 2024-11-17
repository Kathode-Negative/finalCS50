

camY = 0

require 'src/Dependencies'

function love.load()
    math.randomseed(os.time())

    love.mouse.setVisible(false)
    love.graphics.setDefaultFilter('nearest','nearest')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT,WINDOW_WIDTH, WINDOW_HEIGHT,
    {
        fullscreen = true;
        vsync = true;
        rezisable = true;
        pixelperfect = true;
        highdpi = true;
    })

    gStateStack = StateStack()

    --gStateStack:push(LogoState(CutSceneState({
      --  animation 


    --})))
    gStateStack:push(LogoState('Dub_logo'))
    gMusic['intro']:play()
    --gStateStack:push(WinState())
    
    --gStateStack:push(LogoState(PlayState(), 'Dub_logo'))



	love.keyboard.keysPressed = {}
   -- maybe love.mouse.input = {}
end

function love.resize(w, h)
	push:resize(w,h)
end



function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
   return love.keyboard.keysPressed[key] 
end

function love.update(dt)

    love.audio.setVolume(VOLUME)

	Timer.update(dt)
	gStateStack:update(dt)
	
	love.keyboard.keysPressed = {}
    --love.mouse.input = {}
end
	
function love.draw()
push:start()
gStateStack:render()
push:finish()
end    