EntityAttackState = Class{__includes = DefaultState}




function EntityAttackState:init(entity)

    self.entity = entity
    
end

function EntityAttackState:enter(params)
     
end

function EntityAttackState:update(dt)

    if self.entity.dmgBox then 
    for i,box in pairs(self.entity.dmgBox) do 
        box:update(dt)
    end
    end

end

function EntityAttackState:render()
   local  anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.graphic],gFrames[anim.graphic][anim:getFrame()],
    self.entity.x + (self.entity.direction == 'left' and self.entity.width or 0),
    self.entity.y,0,(self.entity.direction == 'left' and -1 or 1),1)
    

    if self.entity.dmgBox then 
        for i,box in pairs(self.entity.dmgBox) do 
            box:render()
        end
    end
end

