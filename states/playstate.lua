require("objects/block")
require("objects/timer")

local playstate = gamestate.new()

local function lex (csv)
	local s = csv:sub(csv:find("map") + 4)
	local arr = {}
	local prev = 1
	for i = 1, s:len() + 1 do
		local sub = s:sub(i, i)
		if sub == "\n" then prev = prev + 1 end
		if sub == "," then
			table.insert(arr, tonumber(s:sub(prev, i - 1)))
			prev = i + 1
		end
	end
	return arr
end

local function createBlocks (world, toks, w, h)
	local b = {}
	for x = 1, w do
		for y = 1, h do
			local val = toks[(y - 1) * w + x]
			local bType = "normal"
			if val ~= 0 then
				local typ = math.floor(val / 10)
				local shape = val % 10
				if typ == 1 then bType = "normal" end
				if typ == 2 then bType = "bouncy" end
				if typ == 3 then bType = "inert" end
				if typ == 4 then bType = "explosive" end
				if typ == 5 then bType = "combo" end
				if typ == 6 then bType = "trophy" end
				table.insert(b, Block:new(world,
					Block.IMAGES[bType..tostring(val % 10)],
					(x - 1) * UNIT_SIZE,
					(y - 1) * UNIT_SIZE,
					bType))
			end
		end
	end
	return b
end

local function addCollision (a, b, coll)
	local blockA = a:getUserData()
	local blockB = b:getUserData()
	blockA:onCollision(blockB)
	blockB:onCollision(blockA)
end

function playstate:init()
	local menu = goo.object:new()
	local reset = goo.button:new(menu)
	local quit = goo.button:new(menu)
	menu:setPos(SCREEN_WIDTH - SCREEN_WIDTH * 0.05 - BUTTON_WIDTH, 
		SCREEN_HEIGHT * 0.05)
	reset:setText("Reset")
	reset:setSize(BUTTON_WIDTH, BUTTON_HEIGHT)
	reset:setPos(0, 0)
	quit:setText("Quit")
	quit:setSize(BUTTON_WIDTH, BUTTON_HEIGHT)
	quit:setPos(0, BUTTON_VERTICAL_SPACING)
	quit.onClick = function() gamestate.switch(menustate) end
	self.menu = menu
	self.reset = reset
end

function playstate:enter(previousState, csvList, currentLevel)
	self.csvList = csvList
	self.currentLevel = currentLevel
	self.reset.onClick = function() 
		gamestate.switch(playstate, csvList, currentLevel)
	end
	if csvList[currentLevel + 1] == nil then
		self.goToNext = function() gamestate.switch(levelselectstate) end
	else
		self.goToNext = function() gamestate.switch(playstate, csvList, currentLevel + 1) end
	end
	self.world = love.physics.newWorld(0, GRAVITY * UNIT_SIZE)
	self.world:setCallbacks(addCollision)
	self.blocks = {}
	local csv = csvList[currentLevel]
	table.insert(self.blocks, Block:new(self.world, Block.IMAGES.ground, 0, 
		love.graphics.getHeight() -
		Block.IMAGES.ground:getHeight(), "ground"))
	self.remaining = tonumber(csv:sub(csv:find("goal:+%d*") + 5,
		({csv:find("goal:+%d*")})[2]))
	local tokens = lex(csv)
	for i,v in ipairs(createBlocks(self.world, tokens, 20, 15)) do
		table.insert(self.blocks, v)
	end
	self.timer = Timer:new()
	self.menu:setVisible(true)
end

function playstate:leave()
	self.menu:setVisible(false)
end

function playstate:update(dt)
	self.world:update(dt)
	self.timer:update()
	for i,b in ipairs(self.blocks) do
		if b.dead then
			if b.type == "trophy" then
				self.reset:onClick()
			else
				b.fixture:destroy()
				table.remove(self.blocks, i)
				self.remaining = self.remaining - 1
				if self.remaining == 0 then
					self.goToNext()
				end
			end
		end
	end
end

function playstate:draw()
	for i,b in ipairs(self.blocks) do
		b:draw()
	end
end

function playstate:mousereleased(x, y, b)
	if b == "l" then
		if self.timer:isReady() then
			for i,b in ipairs(self.blocks) do
				if b.fixture:testPoint(x, y) then
					b:onClick(self.timer, self.blocks)
					break
				end
			end
		end
	end
end

return playstate