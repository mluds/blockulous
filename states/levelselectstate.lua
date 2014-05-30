local levelselectstate = gamestate.new()

local menu

function levelselectstate:init()
	menu = goo.object:new()
	menu:setPos(SCREEN_WIDTH / 2 - BUTTON_WIDTH / 2, 
		SCREEN_HEIGHT / 2 - BUTTON_HEIGHT / 2)
	local files = love.filesystem.enumerate("lvl")
	local dataList = {}
	for i, v in ipairs(files) do
		local btn = goo.button:new(menu)
		local data = love.filesystem.read("lvl/"..v)
		table.insert(dataList, data)
		btn.onClick = function() 
			gamestate.switch(playstate, dataList, i)
		end
		btn:setText("Level "..i)
		btn:setSize(BUTTON_WIDTH, BUTTON_HEIGHT)
		btn:setPos(0, (i - 1) * BUTTON_VERTICAL_SPACING)
	end
end

function levelselectstate:enter()
	anim:new{table = menu, key = 'x', start = -BUTTON_WIDTH,
		finish = SCREEN_WIDTH / 2 - BUTTON_WIDTH / 2,
		time = 0.5, style = 'elastic'}:play()
end

function levelselectstate:leave()
	anim:new{table = menu, key = 'x',
		start = SCREEN_WIDTH / 2 - BUTTON_WIDTH / 2,
		finish = SCREEN_WIDTH + BUTTON_WIDTH,
		time = 0.5, style = 'elastic'}:play()
end

return levelselectstate