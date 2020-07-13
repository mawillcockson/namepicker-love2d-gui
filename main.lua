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
end

function love.update(dt)
  if love.keyboard.isDown("right") and not love.keyboard.isDown("left") then
    x_direction = right
  elseif love.keyboard.isDown("left") and not love.keyboard.isDown("right") then
    x_direction = left
  else
    x_direction = stopped
  end

  if love.keyboard.isDown("up") and not love.keyboard.isDown("down") then
    y_direction = up
  elseif love.keyboard.isDown("down") and not love.keyboard.isDown("up") then
    y_direction = down
  else
    y_direction = stopped
  end
  
  x = x + (distance * x_direction * dt)
  y = y + (distance * y_direction * dt)
end

function love.draw()
  love.graphics.rectangle("line", x, y, 200, 150)
end
