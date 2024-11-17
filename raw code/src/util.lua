

-- this file is used for useful class independent functions




function cropFrames(atlas, width, height)
    local sheetwidth = atlas:getWidth() / width 
    local sheetheight = atlas:getHeight() / height

    local counter = 1
    local spritesheet = {}

    for y = 0, sheetheight - 1 do
        for x = 0, sheetwidth -1 do 
            spritesheet[counter] = 
        love.graphics.newQuad(x * width, y * height, width,
        height, atlas:getDimensions())
        counter = counter + 1
        end
    end
    return spritesheet
end

function createAnimations(animations)

    local animationsRet = {}

    for i, anim in pairs(animations) do 

        animationsRet[i] = Animation{
            
            graphic = anim.graphic,
            frames = anim.frames,
            frate = anim.frate,
            loop = anim.loop or true
        }
    end
    return animationsRet
end


function SepState(name)
    return gStates[name]
end


function colliding(a,b)
    return not (a.x + a.width 
    < b.x or a.y + a.height < b.y 
    or a.x > 
    b.x + b.width or a.y > b.y + b.height)
end


function findSimilar(table, string)
    
    for k, int in pairs(table) do 
        if int == string then 
            return true 
        end
    end
    return false
end


function getFactor(width,height,texture,frame)
    local x
    local y 
    local owidth 
    local oheight
    x,y,owidth,oheight = gFrames[texture][frame]:getViewport()
    local fx = width / owidth
    local fy = height /  oheight


    return fx,fy
end


function inscribeTable(table1, table2)

    for k, i in pairs(table1) do
        table.insert(table2,i)
    end
    return table2
end


function rotateTransform(x,y,r,rot)

	local a = 0 
	local b = 0

		a = math.floor(x + math.cos(rot) * r)
		b = math.floor(y + math.sin(rot) * r) 
	
	return a,b
end



function find(fx,fy,tx,ty,tab) -- for homing AI 


	if tx < fx then 
		tab.direction = 'left'
	elseif tx > fx then 
		tab.direction = 'right'
	else 
		tab.direction = nil
	end
		
	
	if ty < fy then 
		tab.directionY = 'up'
	elseif ty > fy then 
		tab.directionY = 'down'
	else 
		tab.directionY = nil
	end
end


function clearId(id,tab)
    for i, ent in pairs(tab) do 
        if ent.id == id then 
            table.remove(tab,i)
        end
    end
end
