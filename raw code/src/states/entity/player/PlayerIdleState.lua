

--[[PlayerIdleState = Class{__includes = EntityIdleState}



function PlayerIdleState:init(params)
end]]
PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:enter(params)
    
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 5
    self.entity.offsetX = 0
    
end


function PlayerIdleState:update(dt)

    if love.keyboard.isDown(WALK_RIGHT) then
        self.entity.direction = 'right'
        self.entity:changeState('walk')
    end

    if love.keyboard.isDown(WALK_LEFT) then 
        self.entity.direction = 'left'
        self.entity:changeState('walk')
    end
    

    if love.keyboard.isDown(JUMP) then 
        self.entity:changeState('jump')
    end
    if love.keyboard.isDown(CROUCH) then 
        self.entity:changeState('crouch')
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

    EntityIdleState.update(self,dt)
end