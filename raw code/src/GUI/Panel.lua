Panel = Class{}


function Panel:init(def)

    self.x = def.x
    self.y = def.y

    self.width = def.width
    self.height = def.height

    self.c = def.color

    self.graphic = def.graphic

    self.texts = def.texts

    if def.tween then 
        Timer.tween(def.tween.t,{
            [self] = def.tween.inst
        })     -- for animation of whole panel (falling swooshing, appearing etc.)
    end

    if def.modules then 
    self.selection = Selection({
                    x = self.x,
                    y = self.y,
                    modules = def.modules
                     },

                self
            )
    end
end


function Panel:update(dt)
    if self.selection then 
    self.selection:update(dt)
    end

end


function Panel:render()
    if self.graphic  then 
    love.graphics.draw(gTextures[self.graphic],gFrames[self.graphic][1],self.x, self.y)
    else
        love.graphics.setColor(self.c.r,self.c.g,self.c.b,self.c.o)
        love.graphics.rectangle('fill',self.x,self.y,self.width,self.height,5,5)
        love.graphics.setColor(self.c.r2,self.c.g2,self.c.b2,self.c.o2)
        love.graphics.rectangle('line',self.x,self.y,self.width,self.height,5,5)
        love.graphics.setColor(1,1,1,1)
    end
    
    if self.selection then 
    self.selection:render()
    end
end