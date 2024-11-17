

function bonecircle(boss)

        local n = 5
        local r = 100
        local bullets = {}

        for rot = 0, math.pi*2-(math.pi*2/n),math.pi*2/(n) do 
            local x,y = rotateTransform(boss.x + boss.width/2,boss.y + boss.height/2,r,rot)
            local nab = DmgBox(ENTITY_DEF[boss.id].dmgBoxes['circles'],boss)
            nab.rot = rot 
            nab.x = x
            nab.y = y

            nab.move = function(dmg,dt)
                dmg.rot = dmg.rot + dt * 0.5
                if dmg.rot > math.pi*2 then 
                    dmg.rot = 0
                end
                
                dmg.x,dmg.y = rotateTransform(dmg.entity.x + dmg.entity.width/2,
                dmg.entity.y + dmg.entity.height/2,dmg.r,dmg.rot)

                dmg.xd, dmg.yd = rotateTransform(dmg.entity.x + dmg.entity.width/2,
                dmg.entity.y + dmg.entity.height/2,dmg.r,dmg.rot)
            end
            table.insert(bullets,nab)
        end
        return bullets
end

function boneDash(boss,x1,x2)
    local bone1 = Entity{
        x = x1,
        y = -645,
        id = 'bigBone',
        animations = ENTITY_DEF['bigBone'].animations,
        vel = 10,
        direction = 'up',
        width = 80,
        height = 645,
        trDMG = cave.bossRoom[1]
    }
    bone1.stateMachine = StateMachine{
        ['idle'] = function() return EntityIdleState(bone1) end,
        ['fall'] = function() return EntityFallingState(bone1) end
    }
    bone1:changeState('idle')
    bone1.collidesWith = ENTITY_DEF['bigBone'].collides
    table.insert(cave.bossRoom,bone1)

    local bone2 = Entity{
        x = x2,
        y = -645,
        id = 'bigBone',
        animations = ENTITY_DEF['bigBone'].animations,
        vel = 10,
        direction = 'up',
        width = 80,
        height = 645,
        active = true,
        trDMG = cave.bossRoom[1]
    }
    bone2.stateMachine = StateMachine{
        ['idle'] = function() return EntityIdleState(bone2) end,
        ['fall'] = function() return EntityFallingState(bone2) end
    }
    bone2:changeState('idle')
    bone2.collidesWith = ENTITY_DEF['bigBone'].collides
    table.insert(cave.bossRoom,bone2)

    
        Timer.tween(2,{
            [cave.bossRoom[#cave.bossRoom]] = {y = -635}
        })
        Timer.tween(2,{
            [cave.bossRoom[#cave.bossRoom-1]] = {y = -635}
        })

    :finish(function()
        Timer.after(2,function()
            Timer.tween(2,{
                [cave.bossRoom[#cave.bossRoom]] = {y = -645}
            })
            Timer.tween(2,{
                [cave.bossRoom[#cave.bossRoom-1]] = {y = -645}
            })
            :finish(function()
                clearId('bigBone',cave.bossRoom)
                clearId('bigBone',cave.bossRoom)
            end)
        end)
    end)
end

function pingPong(boss,n,xs)

    for i = 0.25, n/2, 0.25 do 
        Timer.after(i,
        function()
            local ball = Entity{
                x = xs,
                y = boss.y + boss.height/2,
                direction = 'left',
                width = 20,
                height = 20,
                invincible = true,
                id = 'small-bone',
                animations =  ENTITY_DEF['small-bone'].animations,
                trDMG = cave.bossRoom[1]
            }
            ball.stateMachine = StateMachine{
                ['move'] = function() return BallAttack(ball) end 
            }
            ball:changeState('move')
            table.insert(cave.bossRoom,ball)
        end)
    end

end

function enemySummon(boss,n)

    for x = 150, 350, 200/n do  
        local enem = Enemy{
            x = x,
            y = math.random(boss.y, boss.y + 100),
            id = 'enemy',
            written = ENTITY_DEF['enemy'].written,
            animations = ENTITY_DEF['enemy'].animations,
            vel = ENTITY_DEF['enemy'].vel['down'],
            width = ENTITY_DEF['enemy'].width,
            height = ENTITY_DEF['enemy'].height
        }
        enem.stateMachine = StateMachine{
            ['walk'] = function() return EnemyWalkState(enem)end
        }
        enem:changeState('walk')
        table.insert(cave.bossRoom,enem)
    end
end


