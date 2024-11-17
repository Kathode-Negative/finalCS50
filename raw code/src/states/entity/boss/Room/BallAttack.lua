BallAttack = Class{__includes = EntityWalkState}



function BallAttack:init(entity)

    self.entity = entity
    self.entity:changeAnimation('idle')
end

function BallAttack:enter()
    self.dy = false -- 1 or 0
    self.dx = false

    self.vel =  math.random(20,50)

    if math.random(2) == 1 then 
        self.dy = true
    end
    if math.random(2) == 1 then 
        self.dx = true
    end
end

function BallAttack:update(dt)

    

    if self.dy then 
        self.entity.y = self.entity.y + math.ceil(dt * self.vel)
    else
        self.entity.y = self.entity.y - math.ceil(dt * self.vel)
    end
    if self.entity:collides() then
        if self.dy  then 
            self.entity.y = self.entity.y - math.ceil(dt * self.vel)
        else
            self.entity.y = self.entity.y + math.ceil(dt * self.vel)
        end
        self.dy = not self.dy
    end

    if self.dx  then 
        self.entity.x = self.entity.x + math.ceil(dt * self.vel)
    else
        self.entity.x = self.entity.x - math.ceil(dt * self.vel)
    end

    if self.entity.x + 20 > VIRTUAL_WIDTH - 100 or self.entity.x < 100 then 
        if self.dx then 
            self.entity.x = self.entity.x - math.ceil(dt * self.vel)
        else
            self.entity.x = self.entity.x + math.ceil(dt * self.vel)
        end
        self.dx = not self.dx
    end

end
