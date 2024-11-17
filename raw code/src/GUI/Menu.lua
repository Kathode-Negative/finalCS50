Menu = Class{}



function Menu:init(p)
    self.panel = Panel(p)
    self.modules = p.modules
end


function Menu:update(dt)
    self.panel:update(dt)
end


function Menu:render()
    self.panel:render()
end
