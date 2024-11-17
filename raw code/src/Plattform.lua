Plattform = Class{__includes = Entity}



function Plattform:init(params)
    Entity.init(self,params)
    self.scale = params.scale
end


function Plattform:update(dt)
    Entity.update(self,dt)
end


function Plattform:render()
    Entity.render(self)
end