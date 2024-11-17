Cave = Class{}



function Cave:init(player)

    self.player = player
    
    self.entities = {}

    self.length, self.platforms, self.emmit = Generator.generate()

    inscribeTable(self.platforms,self.entities)

    self.bossRoom = Generator.BossRoom()
    -- Collision updates
    self:createEntities()
end

function Cave:createEntities()

    local int = Entity{
        id = ENTITY_DEF['enemy'].id,
        animations = ENTITY_DEF['enemy'].animations,
        x = VIRTUAL_WIDTH/2,
        y = 0,
        vel = 10,
        width = 20,
        height = 20
    }
    int.stateMachine = StateMachine{
        ['idle'] = function() return EntityIdleState(int) end,
        ['walk'] = function() return EnemyWalkState(int)end
    }
    int:changeState('walk')

    table.insert(self.entities, int)
end


function Cave:update(dt,player)



    if self.bossRoom[1].dead then 

        self.bossRoom[1]:changeAnimation('death')

    end



    self.player = player

    if self.player.y < 150  and not self.bossFight then 
        self.bossFight = true 
        self.player:goInv(1)
        gMusic['test-music']:stop()
        gMusic['boss']:play()
    end
    
    if self.bossFight then 
        for i,int in pairs(self.bossRoom) do
            if not int.dead then 
            int:update(dt)
            end
        end
        local med = self.entities[1]
        self.entities = {}
        table.insert(self.entities,med)
    end

    if not self.bossFight then 
        for k, em in pairs(self.emmit) do 
            em:update(dt)
        end
    end

    for k, ent in pairs(self.entities) do
         ent:update(dt)
    end

    for l, plat in pairs(self.platforms) do 
        plat:update(dt)
    end

    for k, ent in pairs(self.entities) do 
        if ent.dead and ent.currentAnimation.timesPlayed > 0 then 
            table.remove(self.entities,k)
            self.player.score = self.player.score + 1
        end
    end


    if self.bossRoom[1].dead then 
        self.boss = self.bossRoom[1]
        self.bossRoom = {}
    end



    for k, ent in pairs(self.bossRoom) do 
        if ent.dead  and not self.bossRoom[1].dead then 
            table.remove(self.bossRoom,k)
            self.player.score = self.player.score + 1
        end
    end

    for l, ent in pairs(self.bossRoom) do 
        if nil then 
            table.remove(self.bossRoom,l)
        end
    end


end



function Cave:render()

   
    
    for l, plat in pairs(self.platforms) do 
        plat:render()
    end
    for l, ent in pairs(self.entities) do 
        if ent.render then 
        ent:render()
        end
    end
    for i, ent in pairs(self.bossRoom) do 
        if not ent.dead then
        ent:render()
        end
    end

    if self.BossHealthBar then 
        self.BossHealthBar:render()
    end
end