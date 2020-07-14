--[[
From this tutorial:
https://sheepolution.com/learn/book/5
--]]

function love.load()
  x = 100
  y = 50
  distance = 200
  up = (-1)
  down = 1
  right = 1
  left = (-1)
  stopped = 0
  y_direction = stopped
  x_direction = stopped

  count = 0
  total_dt = 0
end

local function x_direction ()
  local go_right = love.keyboard.isDown("right")
  local go_left  = love.keyboard.isDown("left")
  return (go_left and left or stopped) + (go_right and right or stopped)
end

local function y_direction ()
  local go_up   = love.keyboard.isDown("up")
  local go_down = love.keyboard.isDown("down")
  return (go_up and up or stopped) + (go_down and down or stopped)
end

function love.update(dt)
  local go_right = love.keyboard.isDown("right")
  local go_left  = love.keyboard.isDown("left")
  local go_up   = love.keyboard.isDown("up")
  local go_down = love.keyboard.isDown("down")

  if go_right and not go_left then
    x_direction = right
  elseif go_left and not go_right then
    x_direction = left
  else
    x_direction = stopped
  end

  if go_up and not go_down then
    y_direction = up
  elseif go_down and not go_up then
    y_direction = down
  else
    y_direction = stopped
  end
  
  x = x + (distance * x_direction * dt)
  y = y + (distance * y_direction * dt)
  --[[
  x = x + (distance * x_direction() * dt)
  y = y + (distance * y_direction() * dt)
  --]]

  count = count + 1
  total_dt = total_dt + dt

  if count >= 60 then
    print(total_dt / count)
    count = 0
    total_dt = 0
  end
end

function love.draw()
  love.graphics.rectangle("line", x, y, 200, 150)
end
