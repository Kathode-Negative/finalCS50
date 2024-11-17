

StateMachine = Class{}


function StateMachine:init(states)
    self.empty =
    {
        enter = function()end,
        exit = function()end,
        update = function()end,
        render= function()end
    }
    self.states = states or {}
    self.current = self.empty
end

function StateMachine:change(name,params)
    assert(self.states[name])
    self.current:exit()
    self.current = self.states[name]()
    self.current:enter(params)
end

function StateMachine:update(dt)
        self.current:update(dt)
end

function StateMachine:render()
    self.current:render()
end

function StateMachine:AI(params, dt)
    self.current:AI(params, dt)
end