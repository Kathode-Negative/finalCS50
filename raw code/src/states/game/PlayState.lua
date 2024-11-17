PlayState = Class{__include = DefaultState}


function PlayState:init()



    gMusic['test-music']:play()
    gMusic['test-music']:setLooping(true)

    self.actualize = true
    
    camY = 0
    self.opac = 0

    self.wallY = 0

    self.ground = 300

    self.player = Player{

        
        animations = ENTITY_DEF['player'].animations,
        vel = ENTITY_DEF['player'].vel,
        id = 'player',
        x = VIRTUAL_WIDTH/2 - 10,
        y = VIRTUAL_HEIGHT/2 - 10,
        width = 28,
        height = 30

    }

    self.player.stateMachine = StateMachine{
        ['walk'] = function() return PlayerWalkState(self.player)end ,
        ['fall'] = function() return PlayerFallingState(self.player)end,
        ['idle'] = function() return PlayerIdleState(self.player)end,
        ['attack'] = function() return PlayerAtackState(self.player)end,
        ['jump'] = function() return PlayerJumpState(self.player)end,
        ['crouch'] = function() return PlayerCrouchState(self.player)end
    }
    self.player:changeState('idle')

    cave = Cave(self.player)

    self.player.y = cave.entities[1].y - self.player.height -- starting y of player o the bottom of map

    self.hud = Hud{
        texts = {},
        imgs = {
            ['clock'] = {
                x = 10,
                y = 10 + camY,
                graphic = 'health',
                rot = 0,
                frame = 1,
                update = 
                function(params,img)
                    img.y = camY + 10
                    img.frame = self.player.health + 1
                end  ,
                render = 
                function(i)
                    love.graphics.draw(gTextures[i.graphic],gFrames[i.graphic][i.frame],i.x,i.y,math.floor(i.rot))
                end
            },
            ['arm'] = {
                x = 22,
                y = 45 + camY,
                graphic = 'arm',
                rot = 0,
                frame = 1,
                update = 
                function(params,img)            
                    img.rot = math.rad(math.ceil(180*(params.height/params.ultimHeight)+15,9453959))  

                    local x,y = rotateTransform(params.x,params.y,28,img.rot)

                    img.x = x
                    img.y = y
                end,
                render = 
                    function(i)
                        love.graphics.setColor(1,1,1,1)
                        love.graphics.draw(gTextures[i.graphic],i.x,i.y,i.rot-math.pi - math.rad(15,9453959))
                        love.graphics.setColor(1,1,1,1)
                    end
            }
        }}



    --#######################

    self.BossHealthBar = Slider{
        x = VIRTUAL_WIDTH/2 - 150,
        y = 294,
        widthO = 300,
        heightO = 10,
        widthI = 296,
        heightI = 6,
        xI = 2,
        yI = 2,
        fullVal = cave.bossRoom[1].health,
        minVal = 0,
        varVal = cave.bossRoom[1].health,
        valR = 0,
        var = function(val)
            if cave.bossRoom[1] then 
            return cave.bossRoom[1].health or cave.boss.health
            end
        end,
        color = {
            r = 45/255,
            g = 41/255,
            b = 48/255,
            o = 1,
            r1 = 106/255,
            g1 = 190/255,
            b1 = 48/255,
            o1 = 1,
            r2 = 251/255,
            g2 = 242/255,
            b2 = 54/255,
            o2 = 1,
            r3 = 1,
            g3 = 1,
            b3 = 1,
            o3 = 1
        }
    }


    
            
    
    
    
        --######################
end
counter = 0
function PlayState:update(dt)



    if cave.boss then 
        self.actualize = false
        cave.boss:update(dt)
        cave.boss:changeAnimation('death')
        Timer.tween(2,{
            [self] = {opac = 1}
        })
        :finish(
        function()
            gMusic['boss']:stop()
            gStateStack:push(WinState())
        end)
    end


    

    if love.keyboard.wasPressed('escape') then 
        love.audio.pause()

        gSounds['pause']:stop()
        gSounds['pause']:play()
        gStateStack:push(OptionState())

    end

    if love.keyboard.wasPressed('h') then 
        pingPong({
            x = 300,
            y = camY + 160,
            width = 0,
            height = 0
        }, 20)
    end


    if self.actualize then 

        if love.keyboard.wasPressed('b') then 

            --cave.bossFight = not cave.bossFight

            self.player.health = 1 
            self.player:dmg(1)

            local     up = laserWheel(
                    {x  = 100,
                    y = 100,
                    width = 10,
                    height = 10 
                    })
        end 
        if up then 
            for i, int in pairs(up) do 
                int: update(up)
            end
        end

        if not cave.bossFight then 
            camY = math.max(0,math.min(self.player.y - VIRTUAL_HEIGHT/2 + self.player.height/2 + VIRTUAL_HEIGHT, cave.platforms[1].y+ 10 ) - VIRTUAL_HEIGHT)
        
            self.wallY = (camY) % 320
            else 
            camY = 0
        end

        
        self.player:update(dt)

        if self.player.x + 20 > VIRTUAL_WIDTH - 100 then 
        self.player.x = self.player.x - math.ceil(self.player.vel *dt)
        elseif self.player.x < 100 then
            self.player.x = self.player.x + math.ceil(self.player.vel *dt)
        end

        cave:update(dt,self.player)

        local def = {
            texts ={},
            hp = self.player.health,
            height = self.player.y+ self.player.height,
            ultimHeight = cave.entities[1].y,
            x = 49.5,
            y = 58.5 + camY
        }
        self.hud:update(dt,def)
        if cave.bossFight and cave.bossRoom[1] then 
            self.BossHealthBar:update(dt,{x = 0,y = 0})
        end

    end



    if self.player.dead then 

        self.actualize = false

        Timer.tween(1,{
            [self] = {opac = 1}
        })

        :finish(
        function()
                gStateStack:push(LoseState(self.player))
                gStateStack:popL()
        end)

        self.player:update(dt) 
    end

    --[[ TO DO :


        make Boss AI 

        make boss room 

        make win state 

        do intro cutscene
      ]]

end

function PlayState:enter()
end

function PlayState:render()

    if DEBUG then 
        self.player.invincible = true 
    else 
        self.player.invincible = false
    end


    local pass = 1 
    -- render backgrounds
    local bgs = {
        ['bac'] = love.graphics.newImage('graphics/world/bac.png'),
        ['top'] = love.graphics.newImage('graphics/world/back-top.png'),
        ['walls'] = love.graphics.newImage('graphics/world/wall.png')
    }

    love.graphics.translate(0,-camY)
    love.graphics.draw(bgs['bac'],0,camY)
    love.graphics.translate(0,camY)

    love.graphics.draw(bgs['walls'],0,-self.wallY)
    love.graphics.draw(bgs['walls'],0,-self.wallY + 320)
    

    love.graphics.draw(bgs['walls'],VIRTUAL_WIDTH,-self.wallY + 320,0,-1)
    love.graphics.draw(bgs['walls'],VIRTUAL_WIDTH,-self.wallY + 640,0,-1)

    -- render rest

    love.graphics.translate(0,-camY)
   
    
    
    cave:render()
        if cave.bossFight then 
        self.BossHealthBar:render()
    end
    self.hud:render(camY)
    if cave.boss then 
    love.graphics.setColor(1,1,1,self.opac)
    else
    love.graphics.setColor(0,0,0,self.opac)
    end
    love.graphics.rectangle('fill',0,camY,VIRTUAL_WIDTH,VIRTUAL_HEIGHT)
    love.graphics.setColor(1,1,1,1)

    self.player:render()    
    
    -- debug +##################################################
    if DEBUG then 
    love.graphics.print(tostring(self.player.health),10,110 + camY)

    love.graphics.print(tostring(self.player.falling), 10 ,120+ camY )


    love.graphics.print(tostring(self.player.y),10,100 + camY)
    end
    --*++++++###################################################

end

function PlayState:exit()
    gMusic['test-music']:stop()
    love.graphics.translate(0,camY)
end


