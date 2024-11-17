Text = Class{}



function Text:init(def)

    self.font = def.font or gFonts['default']
    self.text = love.graphics.newText(self.font, def.string, 200, 'center')
    
    self.color = def.color

    self.arrangement = def.arrang


    self.xoff = def.x 
    self.yoff = def.y

    if def.tween then 
        Timer.tween(tween.t,{
            [self] = tween.inst
        })
    end
    
end

function Text:update(dt,container)
    self.highlight = false
    self.x = container.x + self.xoff
    self.y = container.y + self.yoff
end

function Text:render()
    love.graphics.setFont(self.font)
    love.graphics.setColor(self.color)

    love.graphics.draw(self.text, self.x,self.y) 

    love.graphics.setColor(1,1,1,1)
    love.graphics.setFont(gFonts['default'])
end