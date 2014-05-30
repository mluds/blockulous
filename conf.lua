require("globals")

function love.conf(t)
	t.screen.width = SCREEN_WIDTH
	t.screen.height = SCREEN_HEIGHT
	t.title = "Blockulous"
	t.author = "Mike Ludwig"
	t.modules.joystick = false;
	t.modules.keyboard = false;
end