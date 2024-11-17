

Entity = Class{}

function Entity:init(params)

    self.id = params.id

    self.width = params.width
    self.height = params.height
    
    self.x = params.x
    self.y = params.y

    self.dy = 0

    self.vel = params.vel

    
    -- texture 
    self.direction = params.direction

    self.animations = createAnimations(params.animations)

    

    self.directionY = nil

    -- motion

    self.atk = ENTITY_DEF[self.id].atk

    self.passes = ENTITY_DEF[self.id].passes
    
    self.written = params.written or false


    -- health
    self.health = ENTITY_DEF[self.id].health
    self.invincible = ENTITY_DEF[self.id].invincible or false

    self.invulnerable = false
    self.invTime = 0
    self.invDur = 0

    self.transDMG = params.trDMG -- used for multy entities (e.g. the boss)


    self.flashTime = 0

    -- collision
    self.active = ENTITY_DEF[self.id].active or false
    
    self.collideddown = false
    self.onCollide = ENTITY_DEF[self.id].onCollide
    self.falling = false
    self.level = nil

    self.collidesWith = ENTITY_DEF[self.id].collides

    self.dmgBox = nil
    self.dead = false

    -- sounds 
    self.sounds = ENTITY_DEF[self.id].sounds or {}

    self.stateMachine = nil
    
    self.hurtAnim = self.animations['hurt'] 
end

function Entity:goInv(dur)
    self.invulnerable = true 
    self.invDur = dur
end


function Entity:dmg(atk)

    
    if not self.invulnerable and not self.invincible then 
        if self.transDMG then 

            self.transDMG:dmg(atk)
        end
        self.invulnerable = true 
        self.health = self.health - 1
        if self.sounds['hurt'] then 
            self.sounds['hurt']:stop()
            self.sounds['hurt']:play()
        end
        if self.health == 0  then 
            self.dead = true
            if self.sounds['death'] then 
                self.sounds['death']:stop()
                self.sounds['death']:play()
            end
            self:changeAnimation('death')
        end
    end 

    if self.hurtAnim then 
        self:changeAnimation('hurt')
    end
end


function Entity:changeState(name)
    self.stateMachine:change(name)
end

function Entity:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end

function Entity:update(dt)
    if not self.dead then 
        if self.invulnerable and not self.invincible then 
            self.flashTime = self.flashTime + dt
            self.invTime = self.invTime + dt

            if self.invTime > self.invDur then 
                self:changeAnimation('idle')
                self.invulnerable = false
                self.invTime = 0
                self.invDur = 0
                self.flashTime = 0
            end
        end

    
        if not self.dead then 
        self.stateMachine:update(dt)
        end

    else
        if not self.currentAnimation == self.animations['death'] then 
            self:changeAnimation('death')
        end

        self.dmgBox = nil 

    end

  
    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end


    if self.dead and self.currentAnimation == self.animations['death'] and self.currentAnimation.timesPlayed > 0 then 
         self:changeAnimation('idle')
    end
end

function Entity:collides()
    if self.active  then 
    local flag = false
    local resetx = 0
    local resety = 0

    for i, ent in pairs(cave.entities) do
        if colliding(self, ent) then 
            if findSimilar(self.collidesWith,ent.id) and not ent.dead then 
                self.onCollide[ent.id](self,ent)
                if not findSimilar(self.passes,ent.id) then 
                    flag =  true 
                end
            end
        end
    end
    for i, ent in pairs(cave.bossRoom) do
        if colliding(self, ent) then 
            if findSimilar(self.collidesWith,ent.id) then 
                self.onCollide[ent.id](self,ent)
                if not findSimilar(self.passes,ent.id) then 
                    flag =  true 
                end
            end
        end
    end
    return flag
    end
end

function Entity:AI(params, dt)
    self.stateMachine:AI(params, dt)
end

function Entity:render()

        if self.invulnerable and self.flashTime > 0.07 and not self.hurtAnim then
            self.flashTime = 0
            love.graphics.setColor(0,0,0,0)
        end

        if not self.dead  then 
        self.stateMachine:render()
        end

        if self.currentAnimation == self.animations['death'] then 
            self.stateMachine:render()
        end


    love.graphics.setColor(1, 1, 1, 1)
    if DEBUG then 
    love.graphics.setColor(0,0,1,1)
    love.graphics.rectangle('line',self.x, self.y, self.width, self.height)
    love.graphics.setColor(1,1,1,1)
    end
end
