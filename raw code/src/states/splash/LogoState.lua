LogoState = Class{__includes = DefaultState}


function LogoState:init( logo)

    self.logo = gTextures[logo]
    self.x = VIRTUAL_WIDTH/2 -100
    self.y = VIRTUAL_HEIGHT/2 -100
    self.opacity = 0
    self.next = next -- next state

    Timer.tween(1.5, {
        [self] = {opacity = 1}
    })
    
    :finish(function()

        Timer.after(3,function()
            gStateStack:push(TitleState())
            gStateStack:popL()
        end)

    end)

end

function LogoState:enter()
end

function LogoState:update()

end

function LogoState:exit()
    
end

function LogoState:render()
    love.graphics.setColor(1,1,1,self.opacity)
    love.graphics.draw(self.logo,self.x,self.y)
end
