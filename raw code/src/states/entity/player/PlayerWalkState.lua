

PlayerWalkState= Class{__includes = EntityWalkState}




function PlayerWalkState:init(player)

    self.entity = player
end


function PlayerWalkState:update(dt)
    if love.keyboard.isDown(ATK_LEFT) then 
        self.entity.direction = 'left'
        self.entity:changeState('attack')
    
    elseif love.keyboard.isDown(ATK_RIGHT)  then 
        self.entity.direction = 'right'
        self.entity:changeState('attack')
    
    elseif love.keyboard.isDown(ATK_UP)  then 
        self.entity.direction = 'up'
        self.entity:changeState('attack')
    
    elseif love.keyboard.isDown(ATK_DOWN)  then 
        self.entity.direction = 'down'
        self.entity:changeState('attack')
    
    
    elseif love.keyboard.isDown(WALK_LEFT) and not self.entity.falling then 
        self.entity:changeAnimation('walk')
        self.entity.direction = 'left'
    elseif love.keyboard.isDown(WALK_RIGHT) and not self.entity.falling then 
        self.entity:changeAnimation('walk')
        self.entity.direction = 'right'
    elseif not self.entity.falling then 
        self.entity:changeState('idle')
    else 
        self.entity:changeState('fall')
    end

    if love.keyboard.isDown(JUMP) then 
        self.entity:changeState('jump')
    end

    EntityWalkState.update(self,dt)
end