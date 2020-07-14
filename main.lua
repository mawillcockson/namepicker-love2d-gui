--[[
From this tutorial:
https://sheepolution.com/learn/book/5
--]]

function love.load()
  fruits = {
    "apple",
    "banana",
    "pineapple",
    "tomato",
    "boiled cabbage",
    "pickles",
  }

  ---[[ Debug timing
  -- Could be a lot better
  -- There's probably something built into love that could help
  count = 0
  total_dt = 0
  --]]
end

local function esc ()
  if love.keyboard.isDown("escape") then
    love.event.quit(0)
  end
end

function love.update(dt)
  count = count + 1
  total_dt = total_dt + dt

  if count >= 60 then
    print(total_dt / count)
    count = 0
    total_dt = 0
  end

  esc()
end

function love.draw()
  --[[
  for i,v in ipairs(fruits) do
    love.graphics.print(v, 100, 100
  --]]
  local font = love.graphics.getFont()
  local text = love.graphics.newText(font, fruits[1])
  love.graphics.draw(text, 100, 100)
  local width, height = text:getDimensions()
  local total_height = height
  local max = math.max
  local max_width = max(width, 0)
  for i=2,#fruits do
    text:set(fruits[i])
    width, height = text:getDimensions()
    love.graphics.draw(text, 100, 100 + total_height)
    max_width = max(max_width, width)
    total_height = total_height + height
  end
  love.graphics.rectangle("line", 100 - 5, 100 - 5, max_width + 10, total_height + 10)
end
