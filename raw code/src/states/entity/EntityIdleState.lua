
EntityIdleState = Class{__includes = DefaultState}


function EntityIdleState:init(entity)
    self.entity = entity
    
    self.entity:changeAnimation('idle')
    
end

function EntityIdleState:enter()
    if not self.entity.dead then 
    self.entity:changeAnimation('idle')
    end
end

function EntityIdleState:update(dt)
    if not self.entity.dead then 
        if self.entity.active then 
            self.entity.y = self.entity.y + math.ceil(self.entity.dy*dt)
            if not self.entity:collides() then 
                self.entity.y = self.entity.y - math.ceil(self.entity.dy *dt)
                self.entity:changeState('fall')
            end
            self.entity.y = self.entity.y - math.ceil(self.entity.dy *dt)
        end
    end
end

function EntityIdleState:render() 
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



