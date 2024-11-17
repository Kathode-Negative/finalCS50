

EntityWalkState = Class{__includes = DefaultState}


function EntityWalkState:init(entity)

    self.entity = entity 
end

function EntityWalkState:enter()


end



function EntityWalkState:update(dt)
    if not self.entity.dead then 
    local y = self.entity.y
    local x = self.entity.x
    if not self.entity.written then 
         self.entity.collideddown = false
    end
    

    self.entity.y = self.entity.y + math.ceil(self.entity.dy*dt)
    self.entity:collides()
    self.entity.y = y

    if self.entity.direction == 'left' then 
        self.entity.x = self.entity.x - math.ceil(self.entity.vel * dt)
        
        if self.entity:collides() then 
            self.entity.x = x
            
            self.entity:changeState('idle')
        elseif not self.entity.collideddown then 
            self.entity:changeState('fall')
        end

    elseif self.entity.direction == 'right' then 
        self.entity.x = self.entity.x + math.ceil(self.entity.vel * dt)

        if self.entity:collides() then 
            self.entity.x = x
            
            self.entity:changeState('idle')
        elseif not self.entity.collideddown then 
            self.entity:changeState('fall')
        end

    elseif self.entity.direction == 'down' then 
        self.entity.y = self.entity.y + math.ceil(self.entity.vel *dt)
    

        if self.entity:collides() then 
            self.entity.y = self.entity.y - math.ceil(self.entity.vel *dt)
        end
    elseif self.entity.direction == 'up' then 
        self.entity.y = self.entity.y - math.ceil(self.entity.vel *dt)
    
        if self.entity:collides() then
            self.entity.y = self.entity.y + math.ceil(self.entity.vel *dt)
        end
    end

end

end

function EntityWalkState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.graphic],gFrames[anim.graphic][anim:getFrame()],
    self.entity.x + (self.entity.direction == 'left' and self.entity.width or 0),
    self.entity.y,0,(self.entity.direction == 'left' and -1 or 1),1)
    

    if self.entity.dmgBox then 
        for i,box in pairs(self.entity.dmgBox) do 
            box:render()
        end
    end
end




function EntityWalkState:AI()
end
