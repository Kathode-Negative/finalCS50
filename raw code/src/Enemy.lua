

Enemy = Class{__includes = Entity}


function Enemy:init(params)
    Entity.init(self,params)
end

function Enemy:update(dt)
    Entity.update(self,dt)
end

function Enemy:render()
    Entity.render(self)
end
