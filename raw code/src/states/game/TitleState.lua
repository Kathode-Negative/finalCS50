TitleState = Class{__includes = DefaultState}




function TitleState:init()

    self.background = gTextures['title_screen']
    self.title = gTextures['title_title']
    gMusic['title']:play()
    gMusic['title']:setLooping(true)

    self.menu = Menu{
        x = 167,
        y = 244,
        width = 0, 
        height = 0,
        color = {
            r = 1,
            g = 1,
            b = 1,
            o = 0,
            r2 = 1,
            g2 = 1,
            b2 = 1,
            o2 = 0
        },
        modules = {
            Button{ -- play 
                x = 72 + 25,
                y = 0,
                string = 'play',
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
                    gMusic['title']:stop()
                    gStateStack:popL()
                end
            },
            Button{
                x = 144 + 50,
                y = 0,
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
            },
            Button{
                string = 'opt',
                x = 0,
                y  = 0,
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
                    gStateStack:push(OptionState())
                end
            }
        }


    }
end



function TitleState:update(dt)

    self.menu:update(dt)
    

end



function TitleState:render()

    love.graphics.draw(self.background,0,0)
    love.graphics.draw(self.title,91,14)
    self.menu:render()
end