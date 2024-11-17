

Emmitter = Class{}


-- to DO :
--  difficulty -> player score
--  Boss toggle -> Boss 
-- 
--
function Emmitter:init(params)
    self.x = 0
    self.y = 0

    self.boundX = params.boundX
    self.boundY = params.boundY
    
    self.direction = params.direction 

    self.enemyType = params.enemyType

    self.frequency = params.frequency
    self.time = 0
end


function Emmitter:update(dt)

    self.frequency = self.frequency --* (cave.player:getScore()/10)

    self.time = self.time + dt

    if self.time > self.frequency then 
        self.time = self.time % self.frequency
        
        self:emmit()
    end
end

function Emmitter:emmit()

    x = math.random(self.boundX[1],self.boundX[2])
    y = math.random(self.boundY[1],self.boundY[2]) + camY - ENTITY_DEF[self.enemyType].height

    local int = Entity{
        x= x,
        y= y,
        id = self.enemyType,
        written = ENTITY_DEF[self.enemyType].written,
        animations = ENTITY_DEF[self.enemyType].animations,
        vel = ENTITY_DEF[self.enemyType].vel[self.direction],
        width = ENTITY_DEF[self.enemyType].width,
        height = ENTITY_DEF[self.enemyType].height
    }
    int.stateMachine = StateMachine{
        ['walk'] = function() return EnemyWalkState(int)end
    }
    int:changeState('walk')

    table.insert(cave.entities, int)
end