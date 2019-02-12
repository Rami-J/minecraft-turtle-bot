-- Tunneler Script

-- Function that drops common blocks in order to conserve space in inventory
-- Note: the turtle.getItemDetail() API only works in ComputerCraft version 1.64 and above
function dropBlocks()
	for i = 1, 15 do
		turtle.select(i)
		local data = turtle.getItemDetail(i)
		if data.name == "cobblestone" or data.name == "dirt" or data.name == "gravel" then
			turtle.drop()
		end
	end
	-- turtle selects the last slot in its inventory, usually reserved for torches
	turtle.select(16)
end

-- Function that tells the turtle to dig a 3x1 in front of it and move forward one block
function digIt(blocks)
	while turtle.detect() do
		turtle.dig()
		-- accounts for gravel that falls down when mined
  		os.sleep(0.5)
	end
 	turtle.forward()

	while turtle.detectUp() do
		turtle.digUp()
	end

	while turtle.detectDown() do
		turtle.digDown()
	  -- places a torch every 10 blocks
	  if blocks % 10 == 0 then
	    placeTorch()
	  end
	end
end

-- Function that selects the last slot of the turtle's inventory and places the object down, typically a torch
function placeTorch()
	turtle.select(16)
	turtle.placeDown()
end

-- Function that moves the turtle forward n blocks
function moveForward(n)
  for i = 1, n do
    turtle.forward()
  end
end

-- Function that moves the turtle backward n blocks
function moveBackward(n)
  for i = 1, n do
    turtle.back()
  end
end

-- Todo: fix the extra layer dug by the bot if the length given is odd
-- Function that creates a tunnel of height 3, and length and width as user inputted variables
function digLoop(length, width)
	-- Assumes the turtlebot is 1 block inside a wall, facing inwards
	-- First 2 Layers of the tunnel
	turtle.turnLeft()

	-- Digs to the left for the first layer
	for i = 1, width do
	  digIt(i)
	end
 	length = length - 1

	-- Digs inwards 1 block and digs to the right for the second layer
	turtle.turnRight()
	digIt(1)
	turtle.turnRight()

	for i = 1, width - 1 do
	  digIt(i)
	end
 	length = length - 1

 -- Rest of the layers, incrementing i by 2 each iteration since the bot mines 2 layers within one iteration
	for i = 1, length, 2 do
		turtle.turnLeft()
		digIt(1)
		turtle.turnLeft()
		for j = 1, width - 1 do
			digIt(j)
		end

		turtle.turnRight()
		digIt(1)
		turtle.turnRight()
		for j = 1, width - 1 do
			digIt(j)
		end

		-- places a torch down every 6 blocks
		if i % 3 == 0 then
     		placeTorch()
  		end
	end
end

--=========Main Function===========
local length = 0
local width = 0
local blocks = 0

print("Length of tunnel?")
length = io.read()

print("How wide?")
width = io.read()

digLoop(length, width)

-- Turn the turtle around and moves back
-- If there's a block in front of it keep turning to the right
while turtle.forward() == false do
  turtle.turnRight()
end

moveForward(length)

if turtle.forward() == false then
  turtle.turnRight()
  moveForward(length)
end
