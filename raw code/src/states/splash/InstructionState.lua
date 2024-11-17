InstructionState = Class{__includes = DefaultState}



function InstructionState:init()

    self.IMG = IMG{
        x = 0,
        y = 0,
        anim = {
            frames={1},
            graphic = 'instructions'
        }
    }

end


function InstructionState:update(dt)
    if love.keyboard.wasPressed('space') then 

        gStateStack:pop()

    end
    self.IMG:update(dt,{x= 0,y = camY})
end

function InstructionState:render()

    self.IMG:render()

end