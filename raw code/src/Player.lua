Player = Class{__includes = Entity}



function Player:init(params)
   Entity.init(self, params) 
   self.level = PLEVEL
   self.score = 0

   self.psystem = love.graphics.newParticleSystem(gTextures['heal-particles'],3)
   self.psystem:start()
   self.psystem:setEmissionRate(0)
   self.psystem:setParticleLifetime(1)
   self.psystem:setEmissionArea('normal',5,0)
   self.psystem:setLinearAcceleration(0,-50,0,-80)
   self.psystem:setColors(1,1,1,1)
end

function Player:getScore()
    return self.score
end

function Player:update(dt)
    if love.keyboard.wasPressed('lshift') then 
        self:heal()
    end
    self.psystem:moveTo(self.x + self.width/2,self.y + self.height)
    self.psystem:update(dt)
    
    Entity.update(self,dt)
end

function Player:render()
    Entity.render(self)
    love.graphics.draw(self.psystem)
end

function Player:heal()
    if self.score > 3 then

        if self.health < 3 then 
        self.health = self.health + 1
        self.sounds['heal']:stop()
        self.sounds['heal']:play()
        Timer.tween(1,{
            [self] = {score = 0}
        })
        self.psystem:emit(10)
        end
        
    end
    
end

