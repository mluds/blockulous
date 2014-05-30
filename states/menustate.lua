local menustate = gamestate.new()

local title
local menu
local buttons = {
	{"Level Select", function() gamestate.switch(levelselectstate) end},
	{"Level Editor", function() gamestate.switch(levelselectstate) end},
	{"Quit", function() love.event.quit() end}
}

function menustate:init()
	title = goo.text:new()
	title:setText("Blockulous")
	title:setPos(SCREEN_WIDTH / 2 - 
		love.graphics.getFont():getWidth(title:getText()) / 2)
	menu = goo.object:new()
	menu:setPos(SCREEN_WIDTH / 2 - BUTTON_WIDTH / 2, 
		SCREEN_HEIGHT / 2 - BUTTON_HEIGHT / 2)
	for i, v in ipairs(buttons) do
		local b = goo.button:new(menu)
		b:setText(v[1])
		b:setSize(BUTTON_WIDTH, BUTTON_HEIGHT)
		b:setPos(0, (i - 1) * BUTTON_VERTICAL_SPACING)
		b:resetStyle()
		b.onClick = v[2]
	end
end

function menustate:enter()
	anim:new{table = menu, key = 'x', start = -BUTTON_WIDTH,
		finish = SCREEN_WIDTH / 2 - BUTTON_WIDTH / 2,
		time = 0.5, style = 'elastic'}:play()
end

function menustate:leave()
	anim:new{table = menu, key = 'x',
		start = SCREEN_WIDTH / 2 - BUTTON_WIDTH / 2,
		finish = SCREEN_WIDTH + BUTTON_WIDTH,
		time = 0.5, style = 'elastic'}:play()
end

return menustate