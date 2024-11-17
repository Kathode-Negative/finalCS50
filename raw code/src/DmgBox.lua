
DmgBox = Class{}



function DmgBox:init(params,entity)
    self.low  = params.low 
    self.entity = entity


    self.xd = params.xo + self.entity.x
    self.yd = params.yo + self.entity.y	


    self.KPlayer = params.KPlayer or false
    self.KBoss = params.KBoss or false
    
    self.rot = params.rot

    self.atk = entity.atk

    self.r = 100

    self.polygons = params.poly or false
    
    
    if not self.polygons then 
        self.animation = Animation(params.animation)
    else 
        self.vertex = params.vertexes.list
        self.verticies = params.vertexes
        self.c = params.color
    end

    self.width = math.abs(params.width*(math.cos(self.rot))-params.height*(math.sin(self.rot)))
    self.height = math.abs(params.width*(math.sin(self.rot)) + params.height*(math.cos(self.rot)))


    local direction = self.entity.direction

    self.move = params.move 

    if not self.move then 
        if direction == 'left' then 
            self.x = self.entity.x - self.width 
            self.y = self.entity.y
        elseif direction == 'right' then 
            self.x = self.entity.x + self.width 
            self.y = self.entity.y
        elseif direction == 'up' then 
            self.x = self.entity.x 
            self.y = self.entity.y - self.height
        elseif direction == 'down' then 
            self.x = self.entity.x 
            self.y = self.entity.y + self.entity.height
        end
    end

    self.onCollide = params.onCollide
end


function DmgBox:update(dt)
    if self.move then 
        self.move(self,dt)
    end

    if self.verticies then 
    self.verticies.update(dt,self.verticies,self.entity)
    self.rot = self.verticies.rot
    self.vertex = self.verticies.list
    end
    
    if not self.move then 
    self.width = math.abs(self.width*(math.cos(self.rot))-self.height*(math.sin(self.rot)))
    self.height = math.abs(self.width*(math.sin(self.rot)) + self.height*(math.cos(self.rot)))
    end

    if not self.move then 
        if direction == 'left' then 
            self.x = self.entity.x - self.width 
            self.y = self.entity.y
        elseif direction == 'right' then 
            self.x = self.entity.x + self.width 
            self.y = self.entity.y
        elseif direction == 'up' then 
            self.x = self.entity.x 
            self.y = self.entity.y - self.height
        elseif direction == 'down' then 
            self.x = self.entity.x 
            self.y = self.entity.y + self.entity.height
        end

    end


    if not self.polygons then 
         self.animation:update(dt) 
    end

    for l, ent in pairs(cave.entities) do 
        if  colliding(self,ent) and self.onCollide then 
            self.onCollide(self,ent)
        end
    end
    

    if self.KPlayer then 
        if colliding(self,cave.player) and self.onCollide then 
            self.onCollide(self,cave.player)
        end
    end

    if self.KBoss then 
        for l, ent in pairs(cave.bossRoom) do 
        if  colliding(self,ent) and self.onCollide then 
            self.onCollide(self,ent)
        end
    end
    end
end

function DmgBox:render()
    if not self.polygons then
        local anim = self.animation
        love.graphics.draw(gTextures[anim.graphic],gFrames[anim.graphic][anim:getFrame()],
        self.xd,self.yd,(self.move and 0 or self.rot),1,1)
    else
        love.graphics.setColor(self.c.r,self.c.g,self.c.b,self.c.o)
        love.graphics.polygon('fill',self.vertex)
        love.graphics.setColor(1,1,1,1)
    end
    if DEBUG then 
        love.graphics.setColor(1,0,0,1)
        love.graphics.rectangle('line',self.x or self.vertex[1],self.y or self.vertex[2] ,self.width,self.height)
        love.graphics.setColor(1,1,1,1)
    end
end

