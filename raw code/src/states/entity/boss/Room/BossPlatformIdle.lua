BossPlatformIdle = Class{__includes = EntityIdleState}


function BossPlatformIdle:init(entity)

    self.entity = entity
    self.entity.vel = 0 
end


function BossPlatformIdle:update(dt)
    if cave.bossFight and self.entity.vel == 0 then 
        self.entity:changeState('dash')
    end
end

