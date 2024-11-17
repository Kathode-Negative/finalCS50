
PlayerAtackState = Class{__includes = EntityAttackState}


function PlayerAtackState:init(player)

    self.entity = player
    self.stop = false
    self.entity.dmgBox = {DmgBox(ENTITY_DEF[self.entity.id].dmgBoxes[self.entity.direction],self.entity)}
end

function PlayerAtackState:enter()

end


function PlayerAtackState:update(dt)
    if not self.entity.dead then 

    if love.keyboard.isDown(ATK_LEFT) and self.stop == false then 
        self.entity.sounds['atk']:stop()
        self.entity.sounds['atk']:play()
        self.entity.direction = 'left'
        if self.stop == false then 
        self.entity.dmgBox = {DmgBox(ENTITY_DEF[self.entity.id].dmgBoxes[self.entity.direction],self.entity)}
        self.entity:changeAnimation('attack-side')
        end
        self.stop = true 
    elseif love.keyboard.isDown(ATK_RIGHT) and self.stop == false then 
        self.entity.sounds['atk']:stop()
        self.entity.sounds['atk']:play()
        
        self.entity.direction = 'right'
        if self.stop == false then 
        self.entity.dmgBox = {DmgBox(ENTITY_DEF[self.entity.id].dmgBoxes[self.entity.direction],self.entity)}
        self.entity:changeAnimation('attack-side')
        end
        self.stop = true 
    elseif  love.keyboard.isDown(ATK_UP) and self.stop == false then 
        self.entity.sounds['atk']:stop()
        self.entity.sounds['atk']:play()
        self.entity.direction = 'up'
        if self.stop == false then 
        self.entity.dmgBox = {DmgBox(ENTITY_DEF[self.entity.id].dmgBoxes[self.entity.direction],self.entity)}
        self.entity:changeAnimation('attack-up')
        end
        
        self.stop = true
    elseif  love.keyboard.isDown(ATK_DOWN) and self.stop == false then 
        self.entity.sounds['atk']:stop()
        self.entity.sounds['atk']:play()
        self.entity.direction = 'down'
        if self.stop == false then 
        self.entity.dmgBox = {DmgBox(ENTITY_DEF[self.entity.id].dmgBoxes[self.entity.direction],self.entity)}
        self.entity:changeAnimation('attack-down')
        end
        self.stop = true
    end
    end

    local played = false
    if self.entity.dmgBox then 
    for i, h in pairs(self.entity.dmgBox) do 

        if h.animation.timesPlayed > 0 then 
            played = true 
        else 
            played = false
        end
    end
    end
    EntityAttackState.update(self,dt)
    
    if played then
        self.stop  = false
        self.entity.dmgBox = nil
        
        local y = self.entity.y
        self.entity.y = self.entity.y + math.ceil(self.entity.dy * dt)
        if self.entity:collides()then 
            self.entity.y = y
        end 

        if not self.entity.dead then 
        if not self.entity.collideddown then 
            self.entity:changeState('fall')
        elseif love.keyboard.isDown(WALK_RIGHT) or love.keyboard.isDown(WALK_LEFT)then
            self.entity:changeState('walk')
        elseif love.keyboard.isDown(JUMP) and self.entity.collideddown then 
            self.entity:changeState('jump')
        elseif not love.keyboard.isDown(ATK_DOWN) and not love.keyboard.isDown(ATK_UP) and not love.keyboard.isDown(ATK_RIGHT)
        and not love.keyboard.isDown(ATK_LEFT) then 
            self.entity:changeState('idle')
        end
        end
    end
    
end


