-- Branching FUNCTION

function digIt(block)
	if turtle.detect() then
		turtle.dig()
		turtle.forward()
	end
	if turtle.detectUp() then
		turtle.digUp()
		if block % 10 == 0 then
			placeTorch()
		end
	end
	if turtle.detectDown() then
		turtle.digDown()
	end
end

function placeTorch()
	turtle.select(16)
	turtle.turnLeft()
	turtle.placeUp()
	turtle.turnRight()
end

--=========Main Function===========
local run = 0
local blocks = 0

print("Length of tunnel?")
run = io.read()

for i = 1, run do
	digIt(i)
end
