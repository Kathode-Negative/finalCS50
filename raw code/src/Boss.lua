Boss = Class{__includes = Entity}



function Boss:init(params)
    Entity.init(self,params)
    self.timer = 0
    self.sleepTime = 0
end

function Boss:update(dt)
    self:AI(dt)
    Entity.update(self,dt)
end

function Boss:AI(dt)
    local attacks = ENTITY_DEF[self.id].AI.attacks

    self.timer = self.timer + dt

    if self.timer > self.sleepTime then

        self:changeAnimation('laugh')
        self.sounds['laugh']:play()

        if self.currentAnimation.timesPlayed > 2 then 
            if math.random(3) == 1 then 
            attacks['balls'](self,5,150)
            end
            if math.random(2) == 1 then 
                attacks['bones'](self,math.random(100,200),math.random(200,350))
            end
            if math.random(2) == 1 then 
                attacks['summon'](self, math.random(5,10)) 
            end

            self:changeAnimation('idle')
        end
        self.timer = 0
       self.sleepTime = 3
    end  
end

function Boss:render()
    Entity.render(self,dt)
end

--[[



            if flag then
                Timer.tween(1,{
                    [self] = {y = 10}
                })
                :finish(function()
                    sleepTime = 10
                    flag = false
                end)
                self.timer = 0
            else
                Timer.tween(1,{
                    [self] = {y = 102}
                })
                :finish(function()
                    sleepTime = 4
                    flag = true 
                end)
                self.timer = 0 
            end
]]