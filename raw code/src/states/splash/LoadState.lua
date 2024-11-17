LoadState = Class{__includes = DefaultState}

-- this class is totally use less and only there to make the experience better

function LoadState:init()

    self.animation = Animation{
        frames = (math.random(2) == 2 and {1,1,1,2,3,3,4,5,5,5,6,6,6,6,6} or {1,1,2,2,2,3,4,4,4,5,6,6}),
        frate = 0.3,
        loop = true,
        graphic = 'carrot'
    }
    self.x = VIRTUAL_WIDTH/2 - 89/2
    self.y = VIRTUAL_HEIGHT/2 - 56/2
end


function LoadState:update(dt)
    self.animation:update(dt)


    if self.animation.timesPlayed > math.random(3) then 
        gStateStack:push(PlayState())
        gStateStack:popL()
    end
end


function LoadState:render()

    love.graphics.setColor(0,0,0,1)
    love.graphics.rectangle('fill',0,0,600,320)
    love.graphics.setColor(1,1,1,1)

    local anim = self.animation
    love.graphics.draw(gTextures[anim.graphic],gFrames[anim.graphic][anim:getFrame()]
    , self.x,self.y)
end