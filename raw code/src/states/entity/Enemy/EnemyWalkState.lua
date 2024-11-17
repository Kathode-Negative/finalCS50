EnemyWalkState = Class{__includes = EntityWalkState}


function EnemyWalkState:init(entity)

    self.entity = entity
    self.entity:changeAnimation('idle')
    self.entity.direction = 'down'
    self.timer = 0
end

function EnemyWalkState:update(dt)



    self.timer = self.timer + dt
    if self.timer > 0.009 then 
        self.timer = 0
    self:move(dt,self.entity)
    end
end


---function EnemyWalkState:AI(dt,params)


-- To Do :
-- different enemy behaiviours 
-- 
--  homing AI
--  falling AI
--  dashing maybe??
--  Boss AI extra
--local targetX = cave.player.x 
--local targetY = cave.player.y
    --find(self.entity.x,self.entity.y, targetX,targetY,self.entity)

--end


function EnemyWalkState:move(dt,tab)
    if tab.directionY == 'up' then 
	
		tab.y = tab.y - math.ceil(dt *  1)
	end
	if tab.direction == 'left' then
	
		tab.x = tab.x - math.ceil(dt * 1)
	end
	if  tab.directionY == 'down' then
	
		tab.y = tab.y + math.ceil(dt * 1)
		end
	
	if tab.direction == 'right' then
	
		tab.x = tab.x + math.ceil(dt * 1)
	end
	
	local targetX = cave.player.x 
    local targetY = cave.player.y
    find(self.entity.x,self.entity.y, targetX,targetY,self.entity)
    self.entity.vel = 1
end