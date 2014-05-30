SCREEN_WIDTH  = 640
SCREEN_HEIGHT = 480
BUTTON_WIDTH = SCREEN_WIDTH * 0.15
BUTTON_HEIGHT = SCREEN_HEIGHT * 0.08
TITLE_WIDTH = SCREEN_WIDTH * 0.6
TITLE_HEIGHT = SCREEN_HEIGHT * 0.2
BUTTON_VERTICAL_SPACING = SCREEN_HEIGHT * 0.1
GRAVITY = 10
UNIT_SIZE = 32
IMG_PATH = "img/"
LVL_PATH = "lvl/"

function contains(tab, obj)
	for i,v in ipairs(tab) do
		if v == obj then return true end
	end
	return false
end