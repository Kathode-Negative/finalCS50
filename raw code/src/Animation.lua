Animation = Class{}


function Animation:init(params)
    self.frames = params.frames
    self.frate = params.frate or 1
    self.loop = params.loop
    self.graphic = params.graphic
    

    self.timesPlayed = 0
    self.cframe = 1
    self.timer = 0 
end

function Animation:update(dt)

    if not self.loop and self.timesPlayed > 0 then 
        return 
    end

    if #self.frames > 1 then  -- filtering out animations that are only one frame 
        self.timer = self.timer + dt

        if self.timer > self.frate then 
            self.timer = self.timer % self.frate
            self.cframe = math.max(1, (self.cframe + 1) % (#self.frames + 1))
        
            if self.cframe == 1 then 
                self.timesPlayed = self.timesPlayed + 1
            end
        end
    end
end

function Animation:reset()
    self.timesPlayed = 0
    self.timer = 0 
    self.cframe = 1
end



function Animation:getFrame()
    return self.frames[self.cframe]
end