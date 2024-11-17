

Generator = Class{}



function Generator:generate()

  -- amount of platforms
    local length = 50

    local difficulty = math.ceil((PLEVEL * length) / 100)

    local platforms = {}

    local emmitters = {}

  --  self.boss = self:createBoss()    -- to do 

    

    local y = 0
    local x = 0
    local px = 0
    local pl = 96



    -- creates start platform 
    plat = Plattform{
      id = ENTITY_DEF['start-platform'].id,
        animations = ENTITY_DEF['start-platform'].animations,
        x = 0,
        y = (length) * 88 + 30,
        width = 600,
        height = 10,
        scale = 6
    }
    plat.stateMachine = StateMachine{
      ['idle'] = function() return EntityIdleState(plat) end
    }
    plat:changeState('idle')
    table.insert(platforms,plat)

    -- creates random platforms 

    for n = 1,length - 3  do 
      y = (length - n)  * math.random(90,88) 
      px = x
      x = math.random(100,400)
      while math.abs(x-px) > 230 or math.abs(x-px) < 50 do
        x = math.random(100,400)
      end
      
      local plat = Plattform{
        id = ENTITY_DEF['plattform'].id,
        animations = ENTITY_DEF['plattform'].animations,
        x = x,
        y = y,
        width = 96,
        height = 16,
        scale = 1
      }
      plat.stateMachine = StateMachine{
        ['idle'] = function() return EntityIdleState(plat) end
      }
      plat:changeState('idle')

      table.insert(platforms,plat)
    end


    -- creates start enemy emmitters
      local em = Emmitter{
        direction = down,
        boundX = {
          [1] = 100,
          [2] = 500,
        },
        boundY = {
          [1] = 0,
          [2] = 0,
        },
        enemyType = 'enemy',
        frequency = 3
      }
      table.insert(emmitters,em)

    
    return length, platforms, emmitters

end


function Generator:BossRoom()

  local bossRoom = {}

  local boss = Boss{
    x = VIRTUAL_WIDTH/2 - ENTITY_DEF['boss'].width/2,
    y = 10,


    id = ENTITY_DEF['boss'].id,
    animations = ENTITY_DEF['boss'].animations,
    atk = ENTITY_DEF['boss'].atk,
    height = ENTITY_DEF['boss'].height,
    width = ENTITY_DEF['boss'].width,
    health = ENTITY_DEF['boss'].health,
    written = ENTITY_DEF['boss'].written
  }
  boss.stateMachine = StateMachine{
    ['idle'] = function() return BossIdleState(boss) end,
    ['move'] = function() return BossMoveState(boss) end
  }

  boss:changeState('idle')

  table.insert(bossRoom,boss)

  local barrier1 = Entity{
    x = -200,
    y= 267,
    width = 300,
    height = 60,
    id = ENTITY_DEF['boss-platform'].id,
        animations = ENTITY_DEF['boss-platform'].animations
  }

  barrier1.stateMachine = StateMachine{
    ['idle'] = function() return BossPlatformIdle(barrier1) end,
    ['dash'] = function() return BossPlatformDash(barrier1,0) end

  }
  barrier1:changeState('idle')

  table.insert(bossRoom,barrier1)

  local barrier2 = Entity{
    x = 500,
    y= 267,
    width = 300,
    height = 60,
    id = ENTITY_DEF['boss-platform'].id,
        animations = ENTITY_DEF['boss-platform'].animations
  }

  barrier2.stateMachine = StateMachine{
    ['idle'] = function() return BossPlatformIdle(barrier2)end,
    ['dash'] = function() return BossPlatformDash(barrier2,300)end

  }
  barrier2:changeState('idle')

  table.insert(bossRoom,barrier2)

  local barrier3 = Entity{
      x = 0,
      y = 0,
      width = 600,
      height = 0,
      id = 'null',
      animations = ENTITY_DEF['null'].animations
  }
  barrier3.stateMachine = StateMachine{
    ['idle'] = function() return EntityIdleState(barrier3) end
  }
  barrier3:changeAnimation('idle')
  barrier3:changeState('idle')
  table.insert(bossRoom,barrier3)

  return bossRoom

end






    