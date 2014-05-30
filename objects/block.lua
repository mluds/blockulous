require("globals")
require("lib/middleclass")

local IMG_PATH = "img/"

BlockType = {
	ground    = "ground",
	trophy    = "trophy",
	normal    = "normal",
	bouncy    = "bouncy",
	inert     = "inert",
	explosive = "explosive",
	combo     = "combo"
}

Block = class("Block")

Block.IMAGES = {
	ground     = love.graphics.newImage(IMG_PATH.."ground.png"),
	trophy1    = love.graphics.newImage(IMG_PATH.."trophy.png"),
	normal1    = love.graphics.newImage(IMG_PATH.."normal1.png"),
	normal2    = love.graphics.newImage(IMG_PATH.."normal2.png"),
	normal3    = love.graphics.newImage(IMG_PATH.."normal3.png"),
	bouncy1    = love.graphics.newImage(IMG_PATH.."bouncy1.png"),
	bouncy2    = love.graphics.newImage(IMG_PATH.."bouncy2.png"),
	bouncy3    = love.graphics.newImage(IMG_PATH.."bouncy3.png"),
	inert1     = love.graphics.newImage(IMG_PATH.."inert1.png"),
	inert2     = love.graphics.newImage(IMG_PATH.."inert2.png"),
	inert3     = love.graphics.newImage(IMG_PATH.."inert3.png"),
	explosive1 = love.graphics.newImage(IMG_PATH.."explosive1.png"),
	explosive2 = love.graphics.newImage(IMG_PATH.."explosive2.png"),
	explosive3 = love.graphics.newImage(IMG_PATH.."explosive3.png"),
	combo1     = love.graphics.newImage(IMG_PATH.."combo1.png"),
	combo2     = love.graphics.newImage(IMG_PATH.."combo2.png"),
	combo3     = love.graphics.newImage(IMG_PATH.."combo3.png")
}

Block.DESTRUCTIBLE = {
	"normal",
	"bouncy",
	"explosive"
}

Block.FRICTION = 0.3
Block.RESTITUTION = 0.2
Block.BOUNCY_RESTITUTION = 0.6
Block.EXPLOSION_FORCE = -10000

function Block:initialize (world, img, x, y, blockType)
	local bodyType = "static"
	self.img    = img
	self.type   = blockType
	self.dead   = false
	self.ox     = img:getWidth() / 2
	self.oy     = img:getHeight() / 2
	if blockType ~= "ground" then
		bodyType = "dynamic"
	end
	self.shape = love.physics.newRectangleShape(
		     img:getWidth(), img:getHeight())
	self.body  = love.physics.newBody(world, x + self.ox,
		     y + self.oy, bodyType)
	self.fixture = love.physics.newFixture(self.body, self.shape)
	self.fixture:setFriction   (Block.FRICTION)
	self.fixture:setRestitution(Block.RESTITUTION)
	self.fixture:setUserData   (self)
	if contains(Block.DESTRUCTIBLE, blockType) then
		self.destructible = true
	else
		self.destructible = false
	end
	if blockType == "bouncy" then
		self.fixture:setRestitution(Block.BOUNCY_RESTITUTION)
	end
end

function Block:draw ()
	love.graphics.draw(self.img, self.body:getX(), self.body:getY(),
		self.body:getAngle(), 1, 1, self.ox, self.oy)
end

function Block:onClick (timer, blocks)
	if self.destructible then
		self.dead = true
		timer:reset()
	end
	if self.type == "explosive" then
		for i, b in ipairs(blocks) do
			local angle = math.atan2(
				self.body:getY() - b.body:getY(),
				self.body:getX() - b.body:getX())
			b.body:applyForce(
				math.cos(angle) * Block.EXPLOSION_FORCE,
				math.sin(angle) * Block.EXPLOSION_FORCE)
		end
	end
end

function Block:onCollision (obj)
	if self.type == "trophy" and obj.type == "ground" then
		self.dead = true
	end
	if self.type == "combo" and obj.type == "combo" then
		self.dead = true
	end
end