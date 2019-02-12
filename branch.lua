-- Branching Script

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

--=========Main Function===========
local length = 0

print("Length of tunnel?")
run = io.read()

-- Bot digs a 3x1 tunnel that is how ever long the user requests
for i = 1, length do
	digIt(i)
end
