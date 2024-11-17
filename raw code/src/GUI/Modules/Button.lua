Button = Class{}



function Button:init(def)

    self.xoff = def.x
    self.yoff = def.y

    self.x = -100
    self.y = -100

    self.width = 72
    self.height = 23

    self.text = love.graphics.newText(def.font or gFonts['default'], def.string)

    self.animations = {}

    table.insert(self.animations,Animation(def.normal))
    table.insert(self.animations,Animation(def.high))

    self.highlight = false

    self.activate = def.activate or function() end
end


function Button:update(dt,container)

    self.x = self.xoff + container.x
    self.y = self.yoff + container.y

    if self.highlight then 
        self.animations[2]:update(dt)
    else
        self.animations[1]:update(dt)
    end
end

function Button:render()
    local anim = self.animations[1]
    if self.highlight then 
        anim = self.animations[2]
    end
    love.graphics.draw(gTextures[anim.graphic],gFrames[anim.graphic][anim:getFrame()]
    , self.x,self.y)

    love.graphics.setColor(0,0,0,1)
    love.graphics.draw(self.text,math.floor(self.x + self.width/2 - self.text:getWidth()/2),
                                 math.floor(self.y + self.height/2 - self.text:getHeight()/2))
    love.graphics.setColor(1,1,1,1)
end