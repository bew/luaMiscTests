#!/usr/bin/env love

local playerImg


function love.load()
	playerImg = love.graphics.newImage("assets/plane.png")
end

function love.update(dt)

end

function love.draw()
	love.graphics.print("Hello World!", 150, 10)
	love.graphics.draw(playerImg, 30, 30)
end
