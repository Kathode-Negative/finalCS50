EntityFallingState = Class{__includes = DefaultState}

function EntityFallingState:init(entity)

    self.entity = entity
    if not self.entity.dead then 
    self.entity:changeAnimation('fall')
    end
end


function EntityFallingState:enter()
    if not self.entity.dead then 
    self.grav = GRAV
    self.entity:changeAnimation('fall')
    self.entity.dy = 0
    end
end


function EntityFallingState:update(dt)  
    if not self.entity.dead then 

    self.entity.falling = true 
    self.entity.collideddown = false

    self.entity.dy = self.entity.dy + self.grav
    self.entity.y = self.entity.y + math.ceil(self.entity.dy*dt) 

    self.entity:collides()

    if self.entity.collideddown then
        while self.entity:collides() do 
            self.entity.y = self.entity.y - 1
        end
        self.entity.falling = false
        self.entity.collideddown = true
      -- if self.entity.harmed then 
      --  self.entity:changeAnimation('hurt')
      --  self.entity:hurt()
       -- self.entity:changeState('idle')
      -- else 
        self.entity:changeState('idle')
      -- end
    end
    end
end


function EntityFallingState:render()
  local   anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.graphic],gFrames[anim.graphic][anim:getFrame()],
    self.entity.x + (self.entity.direction == 'left' and self.entity.width or 0),
    self.entity.y,0,(self.entity.direction == 'left' and -1 or 1),1)
    

    if self.entity.dmgBox then 
        for i,box in pairs(self.entity.dmgBox) do 
            box:render()
        end
    end
end