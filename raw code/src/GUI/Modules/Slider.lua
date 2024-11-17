Slider = Class{}



function Slider:init(def)

    self.displayValue = def.dVal or false

    self.highlight = false

    self.xoff = def.x
    self.yoff = def.y

    self.x = -100 
    self.y = -100

    self.widthO = def.widthO
    self.heightO = def.heightO

    self.widthI = def.widthI
    self.heightI = def.heightI

    self.xI = def.xI
    self.yI = def.yI


    self.c = def.color

    self.MaxValue = def.fullVal
    self.MinValue = def.minVal

    self.value = def.varVal

    self.varVal = def.varVal

    self.valueRate = def.valR -- rate at wich value increases or decreases

    self.varWidth = self.widthI * (self.value/self.MaxValue)

    self.change = false

    self.text = love.graphics.newText(def.font or gFonts['default'], tostring(self.value))

    self.var = def.var or function()end -- function predetermined, to change a certain variable
                                        -- takes self.value as input
end

function Slider:activate(dt,container)

    if not self.change then 
        container.blocked = true
        self.change = true 
    else 
        container.blocked = false
        self.change = false
    end
end


function Slider:update(dt,container)

    self.text:set(tostring(self.value))

    self.x = self.xoff + container.x
    self.y = self.yoff + container.y

    if self.change then 

        if love.keyboard.wasPressed(ATK_LEFT) then 
            self.value = self.value - self.valueRate
            gSounds['switch']:stop()
            gSounds['switch']:play()
        elseif love.keyboard.wasPressed(ATK_RIGHT) then 
            self.value = self.value + self.valueRate
            gSounds['switch']:stop()
            gSounds['switch']:play()
        end

        
             

        
    end

    if self.value < self.MinValue then 
        self.value = self.MinValue
    end

    if self.value > self.MaxValue then 
        self.value = self.MaxValue
    end
    self.value = self.var(self.value)
    if self.value < self.MinValue then 
        self.value = self.MinValue
    end

    if self.value > self.MaxValue then 
        self.value = self.MaxValue
    end
    
    self.varWidth = self.widthI * (self.value/self.MaxValue)
end


function Slider:render()

    if self.highlight then 
        love.graphics.setColor(0,0,0,1)
        love.graphics.rectangle('fill',self.x,self.y,self.widthO,self.heightO,10,10)
        love.graphics.setColor(self.c.r1,self.c.g1,self.c.b1,self.c.o1)
        love.graphics.rectangle('fill',self.x+2,self.y+2,self.varWidth,self.heightI)

        love.graphics.setLineWidth(4)
        love.graphics.setColor(1,0,1,1)
        love.graphics.rectangle('line',self.x,self.y,self.widthO,self.heightO,10,10)
        love.graphics.setColor(1,1,1,1)
        love.graphics.setLineWidth(1)
    elseif not self.change then 
        love.graphics.setColor(0,0,0,1)
        love.graphics.rectangle('fill',self.x,self.y,self.widthO,self.heightO,10,10)
        love.graphics.setColor(self.c.r1,self.c.g1,self.c.b1,self.c.o1)
        love.graphics.rectangle('fill',self.x+2,self.y+2,self.varWidth,self.heightI)

        love.graphics.setLineWidth(4)
        
        love.graphics.setColor(self.c.r,self.c.g,self.c.b,self.c.o)
        love.graphics.rectangle('line',self.x,self.y,self.widthO,self.heightO,10,10)
        love.graphics.setColor(1,1,1,1)
        love.graphics.setLineWidth(1)
    else 
        love.graphics.setColor(0,0,0,1)
        love.graphics.rectangle('fill',self.x,self.y,self.widthO,self.heightO,10,10)
        love.graphics.setColor(self.c.r3,self.c.g3,self.c.b3,self.c.o3)
        love.graphics.rectangle('fill',self.x+2,self.y+2,self.varWidth,self.heightI)

        love.graphics.setLineWidth(4)
      
        love.graphics.setColor(self.c.r2,self.c.g2,self.c.b2,self.c.o2)
        love.graphics.rectangle('line',self.x,self.y,self.widthO,self.heightO,10,10)
        love.graphics.setColor(1,1,1,1)
        love.graphics.setLineWidth(1)
    end

    if self.displayValue then 
        love.graphics.setFont(gFonts['default'])
        love.graphics.draw(self.text,self.x + self.widthO/2 - self.text:getWidth()/2,self.y + self.heightO + 5)
    end
end