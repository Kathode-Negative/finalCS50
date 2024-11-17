
LoseState = Class{__includes = DefaultState}



function LoseState:init(player)
    love.audio.stop()

    self.menu = Menu{
        x = VIRTUAL_HEIGHT/2 - 50,
        y = -400,
        width = 400,
        height = 200,
        graphics = 'rectangle',
        color = {
            r = 69/255,
            g = 40/255,
            b = 60/255,
            o = 1,
            r2 = 145/255,
            g2 = 139/255,
            b2 = 139/255,
            o2 = 1
        },
        
        tween = {
            t = 0.3,
            inst = 
             {y = VIRTUAL_HEIGHT/2 - 100}
        },
        modules = {
            --[[             Button({

                x = 100,
                y = camY + 100,
                normal = Animation{frame = {1},
                graphic = 'enemy'},
                high = Animation{frame = {1},
                graphic = 'player'},
                activate = function(dt) 
                end
            })]]
            Text{
                x = 125,
                y = 45 ,
                font = love.graphics.newFont('fonts/PressStart2P-vaV7.ttf',24),
                string = 'YOU DIED',
                color = {1,0,0,1},
                arrang = 'center'
            },
            IMG{
                x = 32,
                y = 42,
                anim = {
                    frames = {1,2},
                    graphic = 'boss',
                    frate = 0.2,
                    loop = true
                },
            },
            Button{
                x = 174,
                y = 130,
                string = 'retry',
                normal = Animation{
                    frames = {1},
                    graphic = 'button'
                },
                high = Animation{
                    frames = {2,3,4,5},
                    graphic = 'button',
                    loop = true,
                    frate = 0.08
                },
                activate = function()
                    gStateStack:push(LoadState())
                    gStateStack:popL()
                end
            },
            Button{
                x = 174,
                y = 159,
                string = 'quit',
                normal = Animation{
                    frames  = {1},
                    graphic = 'button'
                },
                high = Animation{
                    frames = {2,3,4,5},
                    graphic = 'button',
                    loop = true,
                    frate = 0.08
                },
                activate = function()
                    love.event.quit()
                end
            }           
        }
    }
    --[[
    TO DO : 

        -- configure button layout and panel background 
        -- write title screen 
        -- win state is a changed version of this 
        -- Boss phase

    ]]
end

function LoseState:update(dt)

    self.menu:update(dt)
end


function LoseState:render()
    self.menu:render()
end