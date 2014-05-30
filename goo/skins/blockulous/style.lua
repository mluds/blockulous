-- Filename: goo.lua
-- Author: Luke Perkin
-- Date: 2010-02-26
-- Returns Style, Fonts.

-- How to use:
-- Each table reperesent a style sheet for a gui object.
-- Think of it like CSS. Colors are reperesented by RGBA tables.
-- If you specify an alpha value that property will not inherit its
-- parent's opacity.
-- use goo.skin to point to the current skin directory.

local style = {}
local fonts = {}
fonts.default24 = love.graphics.newFont(24)
fonts.grobold12 = love.graphics.newFont(GOO_SKINPATH .. 'grobold.ttf', 12)
fonts.grobold24 = love.graphics.newFont(GOO_SKINPATH .. 'grobold.ttf', 24)
fonts.grobold32 = love.graphics.newFont(GOO_SKINPATH .. 'grobold.ttf', 32)

style['goo panel'] = {
	backgroundColor = {255,255,255},
	borderColor = {255,255,255},
	titleColor = {130,130,130},
	titleFont = fonts.grobold12,
	seperatorColor = {100,100,100}
}

style['goo close button'] = {
	color = {255,255,255},
	colorHover = {255,0,0}
}

style['goo button'] = {
	backgroundColor = {0x00, 0x5B, 0x9A},
	backgroundColorHover = {0x74, 0xC2, 0xE1},
	borderColor = {0,0,0},
	borderColorHover = {0,0,0},
	textColor = {255,255,255},
	textColorHover = {255,255,255},
	textFont = fonts.grobold12
}

style['goo big button'] = {
	buttonColor = {255,255,255,255},
	buttonColorHover = {200,150,255,255},
	textColor = {0,0,0,255},
	textColorHover = {0,0,0,255},
	font = {'groboldblack.ttf', 12}
}

style['goo text input'] = {
	borderColor = {0,0,0},
	backgroundColor = {255,255,255},
	textColor = {0,0,0},
	cursorColor = {0,0,0},
	cursorWidth = 2,
	borderWidth = 2,
	textFont = fonts.grobold12,
	blinkRate = 0.5,
	leading = 12
}

style['goo progressbar'] = {
	backgroundColor = {255,255,255},
	fillMode		= 'fill'
}

style['goo image'] = {
	imageTint = {255,255,255}
}

style['goo debug'] = {
	backgroundColor = {0,0,0,170},
	textColor = {255,255,255,255},
	textFont = fonts.grobold12
}

return style, fonts