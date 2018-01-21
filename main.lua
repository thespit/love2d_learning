require "block"

color = 0

-- 测试做一个类
Rec = {
	x = 0,
	y = 0,
	w = 10,
	h = 10,
	content = "",
	contentCountDown = 0,
	new = function(self, obj)
		obj = obj or {}
		obj.x = 0
		obj.y = 0 
		obj.w = 10
		obj.h = 10
		obj.content = ""
		obj.contentCountDown = 0
		return obj
	end,
}

player = nil;

function talk(msg)
	player.content = msg
	player.contentCountDown = 60
end

function love.draw()
    love.graphics.setColor(128, 128, 128)
    love.graphics.rectangle("fill", player.x, player.y, player.w, player.h)
    if player.content ~= "" then
    	love.graphics.print(player.content, player.x,  player.y - 20)
    end

    love.graphics.setColor(200, 200, 200)

    for i = 0, 100, 1 do
    	for j = 0, 100, 1 do
	    	if map.block[i][j] == 1 then
	    		love.graphics.rectangle("fill", i * 10, j * 10, 10, 10)
	    	end
	    end
    end

end

function love.update()
	checkKey()
	if player.contentCountDown > 0 then
		player.contentCountDown = player.contentCountDown - 1
	end
	if player.contentCountDown == 0 then
		player.content = ""
	end
end

-- 检查按键
function checkKey()
	local spdx = 0
	local spdy = 0
	if love.keyboard.isDown("up") then
		spdy = -1
	end
	if love.keyboard.isDown("down") then
		spdy = 1
	end
	if love.keyboard.isDown("left") then
		spdx = -1
	end
	if love.keyboard.isDown("right") then
		spdx = 1
	end

	player.x = player.x + spdx
	player.y = player.y + spdy

	local blockx = math.ceil(player.x / 10)
	local blocky = math.ceil(player.y / 10)

	if map.block[blockx][blocky] == 1 then
		player.x = player.x - spdx
		player.y = player.y - spdy
	end

	if love.keyboard.isDown("space") then
		talk(blockx .. "," .. blocky)
	end
end

function love.load()
	color = 100
    love.graphics.setColor( color, 0, 0 )
    player = Rec.new(nil)

    -- 初始化block
    for i = 0, 100, 1 do
    	map.block[i] = {}
    	for j = 0, 100, 1 do 
	   		if love.math.random(5) == 1 then
	   			map.block[i][j] = 1
	   		else
	   			map.block[i][j] = 0
	   		end
	   	end
   	end
end

