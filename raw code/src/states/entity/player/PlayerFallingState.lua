PlayerFallingState = Class{__includes = EntityFallingState}


function PlayerFallingState:init(player)
    self.entity = player
    self.grav = GRAV
end


function PlayerFallingState:update(dt)
    if self.entity.falling then 
        if not self.entity.dead then
        self.entity:changeAnimation('fall')
        end
    end

    if love.keyboard.isDown(ATK_LEFT) then 
        if not self.entity.dead then
        self.entity.direction = 'left'
        self.entity:changeState('attack')
        end
    end
    if love.keyboard.isDown(ATK_RIGHT)  then 
        if not self.entity.dead then
        self.entity.direction = 'right'
        self.entity:changeState('attack')
        end
    end
    if love.keyboard.isDown(ATK_UP)  then 
        if not self.entity.dead then
        self.entity.direction = 'up'
        self.entity:changeState('attack')
        end
    end
    if love.keyboard.isDown(ATK_DOWN)  then 
        if not self.entity.dead then
        self.entity.direction = 'down'
        self.entity:changeState('attack')
        end
    end

    if love.keyboard.isDown(WALK_LEFT) then 
        
        self.entity.x = self.entity.x - math.ceil(self.entity.vel * dt)
        if self.entity:collides() then 
            self.entity.x = self.entity.x + math.ceil(self.entity.vel * dt)
        end
        if not self.entity.dead then
        self.entity:changeAnimation('fall-side')
        self.entity.direction = 'left'
        end

    end

    if love.keyboard.isDown(WALK_RIGHT) then 
       
        self.entity.x = self.entity.x + math.ceil(self.entity.vel * dt)
        if self.entity:collides() then 
            self.entity.x = self.entity.x - math.ceil(self.entity.vel * dt)
        end
        if not self.entity.dead then
        self.entity:changeAnimation('fall-side')
        self.entity.direction = 'right'
        end
    end

    if not self.entity.dead then
    EntityFallingState.update(self,dt)
    end
end