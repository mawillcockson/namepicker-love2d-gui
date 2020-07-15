--[[
From this tutorial:
https://www.sheepolution.com/learn/book/contents
--]]

---[[ Explicit imports
local love_keyboard_isDown = love.keyboard.isDown
local love_graphics_rectangle = love.graphics.rectangle
local love_graphics_line = love.graphics.line
local love_graphics_points = love.graphics.points
local math_floor = math.floor
--]]

local function create_rectangle ()
  return {
    x = 100,
    x_direction = 0, -- stopped
    y = 100,
    y_direction= 0,
    width = 70,
    height = 90,
    speed = 100,
    delay = 0.3,
    update = function (self, dt)
      self.x = self.x + self.x_direction * self.speed * dt
      self.y = self.y + self.y_direction * self.speed * dt
    end,
  }
end

---[[ Variable definitions
local up = (-1)
local down = 1
local left = (-1)
local right = 1
local stopped = 0

local previous_y_direction = stopped -- Everything starts stopped
local previous_x_direction = stopped

local rectangles = {}
local moves = {}

local primary_rect = create_rectangle()
primary_rect.delay = 0

---[=[ Debug timing
-- Could be a lot better
-- There's probably something built into love that could help
local count = 0
local total_dt = 0
--]=]
--]]

local function x_direction ()
  local go_right = love_keyboard_isDown("right") and right or stopped
  local go_left  = love_keyboard_isDown("left")  and left  or stopped
  return go_right + go_left
end

local function y_direction ()
  local go_up   = love_keyboard_isDown("up")   and up   or stopped
  local go_down = love_keyboard_isDown("down") and down or stopped
  return go_up + go_down
end

function love.load ()
  love.keyboard.setKeyRepeat(false)
end

local key_functions = {}

function key_functions.backspace ()
  moves[#moves] = nil
  moves[#moves] = nil
end


function key_functions.space ()
  moves[#moves + 1] = primary_rect.x
  moves[#moves + 1] = primary_rect.y
end

function key_functions.escape ()
  love.event.quit(0)
end

function love.keypressed (key, scancode, is_repeat)
  local key_func = key_functions[key]
  if key_func then key_func() end
end

function love.update(dt)
  -- Move primary rectangle
  primary_rect.x_direction = x_direction()
  primary_rect.y_direction = y_direction()
  primary_rect:update(dt)

  if love_keyboard_isDown("left") and love_keyboard_isDown("down") and love_keyboard_isDown("space") and not printed then
    print "Yup, can detect it"
    printed = true
  end

  ---[[ Print average dt
  count = count + 1
  total_dt = total_dt + dt
  if total_dt >= 1 then
    print(total_dt / count)
    count = 0
    total_dt = 0
  end
  --]]
end

function love.draw()
  love_graphics_rectangle("line", primary_rect.x, primary_rect.y, primary_rect.width, primary_rect.height)
  if #moves > 2 then
    love_graphics_line(moves)
    love_graphics_points(moves)
  end
end
