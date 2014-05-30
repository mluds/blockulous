require("lib/middleclass")

Timer = class("Timer")

Timer.WIDTH = 16
Timer.READY_TIME = 0.5
Timer.X_OFFSET = 0
Timer.Y_OFFSET = -26

function Timer:initialize ()
	self.x = love.mouse.getX() - Timer.X_OFFSET
	self.y = love.mouse.getY() - Timer.Y_OFFSET
	self.elapsed = 0
end

function Timer:update ()
	self.x = love.mouse.getX() - Timer.X_OFFSET
	self.y = love.mouse.getY() - Timer.Y_OFFSET
	self.elapsed = self.elapsed + love.timer.getDelta()
end

function Timer:draw ()
	if self.elapsed >= Timer.READY_TIME then
		--love.graphics.setColor(220, 220, 220)
	else
		--love.graphics.setColor(100, 100, 100)
	end
	love.graphics.setLine(2)
	love.graphics.line(self.x, self.y,
		self.x +
		Timer.WIDTH * math.min(self.elapsed, Timer.READY_TIME),
		self.y)
end

function Timer:isReady ()
	if self.elapsed >= Timer.READY_TIME then
		return true
	else
		return false
	end
end

function Timer:reset ()
	self.elapsed = 0
end