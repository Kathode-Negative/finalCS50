BossPlatformDash = Class{__includes = EntityWalkState}



function BossPlatformDash:init(entity,xs)
    self.entity = entity
    self.entity.vel = 1
    Timer.tween(0.1, 
        {
            [self.entity] = {x = xs}
        }
    )
    :finish(function()
        
        self.entity:changeState('idle')
    end)
end
