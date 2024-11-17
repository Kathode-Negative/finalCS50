OptionState = Class{__includes = DefaultState}



function OptionState:init()

    self.menu = Menu{
        x = VIRTUAL_WIDTH/2 - 250,
        y = VIRTUAL_HEIGHT/2 - 100 + camY, 
        width = 500,
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
        modules = {
            IMG {
                x = 160,
                y = 39,
                anim = {
                    frames = {1},
                    graphic = 'vol'
                }
            },
            Slider{
                dVal = true,
                x = 200,
                y = 44,
                widthO = 100,
                heightO = 10,
                widthI = 96,
                heightI = 6,
                xI = 2,
                yI = 2,
                fullVal = 100,
                minVal = 0,
                varVal = VOLUME * 100 * 2,
                valR = 2,
                var = function(val) 
                    self.g = val
                    VOLUME = val /100 /2
                    return val
                end,
                color = {
                    r = 223/255,
                    g = 113/255,
                    b = 38/255,
                    o = 1,
                    r1 = 1,
                    g1 = 1,
                    b1 = 1,
                    o1 = 1,
                    r2 = 251/255,
                    g2 = 242/255,
                    b2 = 54/255,
                    o2 = 1,
                    r3 = 1,
                    g3 = 1,
                    b3 = 1,
                    o3 = 1
                }

            },
            Button{

                x = 216,
                y = 90,
                string = 'contrl',
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
                    gStateStack:push(InstructionState())
                end
            },
            Button{
                x = 216,
                y = 130,
                string = 'resume',
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
                    gStateStack:pop()
                    if cave then 
                        if cave.bossFight then 
                            gMusic['boss']:play()
                        else
                            gMusic['test-music']:play()
                        end
                    end
                end
            },
            
            Button{
                x = 216,
                y = 170,
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



end


function OptionState:update(dt)

    if love.keyboard.wasPressed('escape') and cave then 
        gSounds['resume']:stop()
        gSounds['resume']:play()
        if not cave.bossFight then 
        gMusic['test-music']:play()
        else
        gMusic['boss']:play()
        end
        gStateStack:pop()
    end
    self.menu:update(dt)
end


function OptionState:render()
    love.graphics.setColor(0,0,0,1)
    love.graphics.rectangle('fill',0,camY,600,320)
    love.graphics.setColor(1,1,1,1)
    self.menu:render()
end