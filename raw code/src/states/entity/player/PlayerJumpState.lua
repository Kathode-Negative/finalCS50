

PlayerJumpState = Class{__includes = EntityJumpState}


function PlayerJumpState:init(player)

    self.entity = player
    self.dy = -350
    self.entity:changeAnimation('jump')
end



function PlayerJumpState:update(dt)
    if not self.entity.dead then 
    self.dy = self.dy + GRAV
    self.entity.y = self.entity.y + math.ceil(self.dy *dt)

    
    if self.entity:collides() then 
        if not self.entity.dead then 
        self.entity.y = self.entity.y - math.ceil(self.dy *dt)
        self.entity:changeState('fall')
        end
    end
    if self.dy > 0 then
        if not self.entity.dead then 
        self.entity.dy = self.dy
        self.entity:changeState('fall')
        end
    end 

    if love.keyboard.isDown(ATK_LEFT) then 
        self.entity.direction = 'left'
        self.entity:changeState('attack')
    end
    if love.keyboard.isDown(ATK_RIGHT)  then 
        self.entity.direction = 'right'
        self.entity:changeState('attack')
    end
    if love.keyboard.isDown(ATK_UP)  then 
        self.entity.direction = 'up'
        self.entity:changeState('attack')
    end
    if love.keyboard.isDown(ATK_DOWN)  then 
        self.entity.direction = 'down'
        self.entity:changeState('attack')
    end

    if love.keyboard.isDown(WALK_LEFT) then
        if not self.entity.dead then
        self.entity:changeAnimation('jump-side')
        self.entity.direction = 'left'
        self.entity.x = self.entity.x - math.ceil(self.entity.vel * dt)

        if self.entity:collides() then 
            self.entity.x = self.entity.x + math.ceil(self.entity.vel * dt)
        end
    end
    elseif love.keyboard.isDown(WALK_RIGHT) then 
        if not self.entity.dead then
        self.entity:changeAnimation('jump-side')
        self.entity.direction = 'right'
        self.entity.x = self.entity.x + math.ceil(self.entity.vel * dt)

        if self.entity:collides() then 
            self.entity.x = self.entity.x - math.ceil(self.entity.vel * dt)
        end
    end
    
    else
        if not self.entity.dead then 
        self.entity:changeAnimation('jump')
        end
    end
    end

end

    

