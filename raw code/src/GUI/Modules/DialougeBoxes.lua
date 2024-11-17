DialougeBoxes = Class{}



function DialougeBoxes:init()

    self.x = def.x
    self.y = def.y

    self.width = def.width 
    self.height = def.height

    self.panel = Panel(self.x,self.y, self.width, self.height,def.graphic)

    self.text = def.text

    self.font = gFonts[def.font] or gFonts['default']

    self.read = def.read or false -- determines if text is animated 

    self.lines = self.font:getWrap(self.text, self.width - self.font:getWidth()*2) -- gets lines/ text chunks and cuts them down,
                                          --so they don't pertrude out of the pane
    self.currentChunk = {}         
    self.lineNumb = 1                             
    self.endoftext = false
    self.close = false

    self:step()
end



function DialougeBoxes:nextLine()
    local newLine = {}

    for i = self.lineNumb, self.lineNumb + math.floor((self.height - self.font:getHeight()*2) / self.font:getHeight()) do 
        table.insert(self.currentChunk, self.lines[i])

        if i == #self.lines then 
            self.endoftext = true 
            return newLine
        end
    end

    self.lineNumb = self.lineNumb + 1 + math.floor((self.height - self.font:getHeight() * 2)/ self.font:getHeight())

    return newLine
end

function DialougeBoxes:step()
    if self.endoftext then 
        self.currentChunk = {}
        self.close = true 
    else 
       self.currentChunk =  self:nextLine()
    end
end


function DialougeBoxes:update(dt)

    if love.keyboard.wasPressed(ACCEPT) then 
        self:step()
    end
end



function DialougeBoxes:render()
    self.panel:render()

    love.graphics.setFont(self.font)

    for i = 1, #self.currentChunk do 
        love.graphics.print(self.currentChunk[i],self.x + self.font:getWidth(),
        self.y + self.font:getHeight() * i + math.floor(self.font:getHeight()/3))
    end 
end
