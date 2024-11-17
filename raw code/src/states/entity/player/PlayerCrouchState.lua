PlayerCrouchState = Class{__includes = DefaultState}




function PlayerCrouchState:init(entity)

    self.entity = entity

end



function PlayerCrouchState:enter()
end

function PlayerCrouchState:update(dt)

    self.entity:changeAnimation('crouch')
    self.entity.invincible = true 

    if love.keyboard.isDown(WALK_RIGHT) then
        self.entity.invincible = false
        self.entity.direction = 'right'
        self.entity:changeState('walk')
    end

    if love.keyboard.isDown(WALK_LEFT) then 
        self.entity.invincible = false
        self.entity.direction = 'left'
        self.entity:changeState('walk')
    end
    

    if love.keyboard.isDown(JUMP) then 
        self.entity.invincible = false
        self.entity:changeState('jump')
    end

    if love.keyboard.isDown(ATK_LEFT) then 
        self.entity.invincible = false
        self.entity.direction = 'left'
        self.entity:changeState('attack')
    end
    if love.keyboard.isDown(ATK_RIGHT)  then 
        self.entity.invincible = false
        self.entity.direction = 'right'
        self.entity:changeState('attack')
    end
    if love.keyboard.isDown(ATK_UP)  then 
        self.entity.invincible = false
        self.entity.direction = 'up'
        self.entity:changeState('attack')
    end
    if love.keyboard.isDown(ATK_DOWN)  then 
        self.entity.invincible = false
        self.entity.direction = 'down'
        self.entity:changeState('attack')
    end

    if not love.keyboard.isDown(CROUCH) then 
        self.entity.invincible = false
        self.entity:changeState('idle')
    end
end


function PlayerCrouchState:render()
    anim = self.entity.currentAnimation
    love.graphics.setColor(1,1,1,0.5)
    love.graphics.draw(gTextures[anim.graphic],gFrames[anim.graphic][anim:getFrame()],
    self.entity.x + (self.entity.direction == 'left' and self.entity.width or 0),
    self.entity.y,0,(self.entity.direction == 'left' and -1 or 1),1)
    love.graphics.setColor(1,1,1,1)

    if self.entity.dmgBox then 
        for i,box in pairs(self.entity.dmgBox) do 
            box:render()
        end
    end
end
