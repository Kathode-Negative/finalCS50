Selection = Class{}



function Selection:init(params,container)
    
    self.index = 1
    self.modules = params.modules

    self.container = container

    self.blocked = false-- for slider behaiviour
end




function Selection:update(dt)

    self.x = self.container.x
    self.y = self.container.y


    for x, modules in pairs(self.modules) do 
        modules:update(dt,self)
    end


    if not self.blocked then 
    -- navigation in a X, Y grid, mininm size each = 1

    if love.keyboard.wasPressed(ATK_RIGHT) or love.keyboard.wasPressed(ATK_DOWN) then        
            self.index = (self.index == #self.modules and 1 or self.index + 1)
            gSounds['switch']:stop()
            gSounds['switch']:play()
            
    elseif love.keyboard.wasPressed(ATK_LEFT) or love.keyboard.wasPressed(ATK_UP) then 
        self.index = (self.index == 1 and #self.modules or self.index - 1)
        gSounds['switch']:stop()
        gSounds['switch']:play()
    end
     -- module array (done)
    --- indexing (done)
    -- buttons in constants (done / ACCEPT button / attack used as navigator) 

    for i, mod in pairs(self.modules) do
        mod.highlight = false
    end

    for i = self.index, #self.modules do 
        if   not self.modules[self.index].activate then 
        self.index = (self.index == #self.modules and 1 or self.index + 1)
        else
           
            self.modules[self.index].highlight = true 
   
            break
        end
    end
    end

    if love.keyboard.wasPressed(ACCEPT) then 
        if self.modules[self.index].activate then  
            gSounds['select']:stop()
        gSounds['select']:play()  
        self.modules[self.index]:activate(dt,self)
        end                                         ---  selection actiivation logic 
    end
end



function Selection:render()

    -- iterating over module array and rendering

        for x, modules in pairs(self.modules) do 
           modules:render()
        end
    
end

