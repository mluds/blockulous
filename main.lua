require("globals")
goo = require("goo/goo")
anim = require("anim/anim")
gamestate = require("lib/gamestate")
menustate = require("states/menustate")
levelselectstate = require("states/levelselectstate")
playstate = require("states/playstate")

function love.load()
	love.graphics.setFont(love.graphics.newFont("goo/skins/blockulous/grobold.ttf"))
	love.graphics.setBackgroundColor(0x01, 0x91, 0xC8)
	goo:load()
	goo:setSkin("blockulous")
	gamestate.switch(menustate)
end

function love.update(dt)
	gamestate.update(dt)
	goo:update(dt)
	anim:update(dt)
end

function love.draw()
	gamestate.draw()
	goo:draw()
end

function love.mousepressed(x, y, b)
	gamestate.mousepressed(x, y, b)
	goo:mousepressed(x, y, b)
end

function love.mousereleased(x, y, b)
	gamestate.mousereleased(x, y, b)
	goo:mousereleased(x, y, b)
end