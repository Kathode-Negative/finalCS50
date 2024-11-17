Hud = Class{}


function Hud:init(params)
    self.x = 20 
    self.y = camY
    self.texts = params.texts

    self.imgs = params.imgs

    self.score = Slider{
        dVal = false,
        x = -10,
        y = 108 ,
        widthO = 79,
        heightO = 16,
        widthI = 75,
        heightI = 12,
        xI = 2,
        yI = 2,
        fullVal = 4,
        minVal = 0,
        varVal = cave.player:getScore(),
        valR = 1,
        var = function() 
            return cave.player:getScore()
        end,
        color = {
            r = 185/255,
            g = 205/255,
            b = 216/255,
            o = 1,
            r1 = 95/255,
            g1 = 205/255,
            b1 = 228/255,
            o1 = 1,
            r2 = 1,
            g2 = 1,
            b2 = 1,
            o2 = 1,
            r3 = 1,
            g3  = 1,
            b3 = 1,
            o3 =1 

        }
    }
end


function Hud:update(dt,params)

    self.y = camY

    self.texts = params.texts

    self.score:update(dt,self)
    
    for i, img in pairs(self.imgs) do 
        img.update(params,img)
    end
    -- gets updated from playstate and filled with actualized information
end

function Hud:render(y)
    local offy = 0
    y = y + 10 
    for i, t in pairs(self.texts) do 
        love.graphics.print(t.string, self.x, y + offy)
        offy = offy + 10 
    end

    for k,i in pairs(self.imgs) do 
        i.render(i)
    end
    self.score:render()
end