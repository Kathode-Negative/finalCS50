StateStack = Class{}

function StateStack:init()
    self.states = {}
end

function StateStack:update(dt)
    if self.states[#self.states] then
    self.states[#self.states]:update(dt)
    end
end

function StateStack:clear()
    self.states = {}
end

function StateStack:AI(params,dt)
    self.states[#self.states]:AI(params,dt)
end

function StateStack:push(state)
    table.insert(self.states,state)
    state:enter()
end

function StateStack:render()
    for i, state in pairs(self.states) do 
        state:render()
    end
end


function StateStack:pop()
    if #self.states > 1 then
        self.states[#self.states]:exit()
        table.remove(self.states)
    end
end

function StateStack:popL()
    if #self.states > 1 then 
        self.states[#self.states-1]:exit()
        table.remove(self.states,1)
    end
end