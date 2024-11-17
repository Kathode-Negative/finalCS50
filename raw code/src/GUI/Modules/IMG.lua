IMG = Class{}


function IMG:init(def)
    self.x = -100
    self.y = -100

    self.xoff = def.x 
    self.yoff = def.y
    self.highlight = false

    self.animation = Animation(def.anim)
end


function IMG:update(dt,container)
    self.x = container.x + self.xoff
    self.y = container.y + self.yoff

    self.animation:update(dt)
end


function IMG:render()
local anim = self.animation 
if self.highlight then 
    love.graphics.setColor(1,0,0,1)
end
love.graphics.draw(gTextures[anim.graphic],gFrames[anim.graphic][anim:getFrame()],
    self.x , self.y)
    love.graphics.setColor(1,1,1,1)
end