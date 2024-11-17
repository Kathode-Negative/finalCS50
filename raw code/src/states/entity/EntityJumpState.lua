EntityJumpState = Class{__includes = DefaultState}





function EntityJumpState:init(entity, grav)

    self.entity = entity
    
end

function EntityJumpState:enter(params)
    if self.entity.sounds['jump'] then 
    self.entity.sounds['jump']:stop()
    self.entity.sounds['jump']:play()
    end
end


function EntityJumpState:render()
   local  anim = self.entity.currentAnimation
    self.entity.collideddown = false
    love.graphics.draw(gTextures[anim.graphic],gFrames[anim.graphic][anim:getFrame()],
    self.entity.x + (self.entity.direction == 'left' and self.entity.width or 0),
    self.entity.y,0,(self.entity.direction == 'left' and -1 or 1),1)
    

    if self.entity.dmgBox then 
        for i,box in pairs(self.entity.dmgBox) do 
            box:render()
        end
    end
end
