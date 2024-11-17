BossIdleState = Class{__includes = EntityIdleState}



function BossIdleState:init(boss)
    self.entity = boss
    self.entity:changeAnimation('idle')
end

function BossIdleState:update(dt)
    if self.entity.dmgBox then 
        for i, dmg in pairs(self.entity.dmgBox) do 
            dmg:update(dt)
        end
    end
    EntityIdleState.update(self,dt)
end
