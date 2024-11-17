BossMoveState = Class{__includes = EntityWalkState}




function BossMoveState:init(entity)

    self.entity = entity
    self.rot = 0
end


function BossMoveState:enter()
end

function BossMoveState:update(dt)
    if self.entity.dmgBox then 
        for i, dmg in pairs(self.entity.dmgBox) do 
            dmg:update(dt)
        end
    end
    self.entity:AI(dt)
end