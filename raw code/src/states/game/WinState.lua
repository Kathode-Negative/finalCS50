WinState = Class{__includes = DefaultState}


function WinState:init()
    self.opac = 0
    gMusic['outro']:play()
    gMusic['outro']:setLooping(true)
    self.menu = Menu{
        x = 0,
        y = 0,
        width = 0,
        height = 0,
        color = {
            r = 0,
            g = 40/255,
            b = 60/255,
            o = 0,
            r2 = 145/255,
            g2 = 139/255,
            b2 = 139/255,
            o2 = 0
        },
        modules = {
            IMG{
                x = 0,
                y = 0,
                anim = {
                    frames = {1},
                    graphic = 'YouWin'
                }
            }
        }
    }
    self.texts = {
        Text{
            x = 199,
            y = 121,
            string = 'Thanks for Playing',
            color = {111/255,58/255,130/255,1},
            font = love.graphics.newFont('fonts/PressStart2P-vaV7.ttf',12)
        },
        Text{
            x = 200,
            y = 120,
            string = 'Thanks for Playing',
            color = {167/255,86/255,196/255,1},
            font = love.graphics.newFont('fonts/PressStart2P-vaV7.ttf',12)
        }
    }
end




function WinState:update(dt)
    for i,int in pairs(self.texts) do 
        int:update(dt,{x = 0,y = 0})
    end

    self.menu:update(dt)

    if love.keyboard.wasPressed('space') then 
        Timer.tween(2,{
            [self] = {opac = 1}
        })
        :finish(function()
        gStateStack:push(TitleState())
        gMusic['outro']:stop()
        cave = nil
        gStateStack:popL()
        gStateStack:popL()
        end)
    end
end


function WinState:render()
    self.menu:render()
    for i,int in pairs(self.texts) do
        int:render()
    end
    love.graphics.setColor(1,1,1,self.opac)
    love.graphics.rectangle('fill',0,0,600,320)
    love.graphics.setColor(1,1,1,1)
end