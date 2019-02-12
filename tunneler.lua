-- Tunneler FUNCTION

--function dropBlocks()
--	for i = 1, 16 do
--		if turtle.getItemDetail(i) ==
--			turtle.select(i)
--			turtle.drop()
--	end
-- end

-- test test
function digIt(block)
	while turtle.detect() do
		turtle.dig()
  os.sleep(0.5)
	end
 turtle.forward()
	while turtle.detectUp() do
		turtle.digUp()
	end
	while turtle.detectDown() do
		turtle.digDown()
	  if block % 10 == 0 then
	    placeTorch()
   end
	end
end

function placeTorch()
	turtle.select(16)
	turtle.placeDown()
end

function moveForward(n)
  for i = 1, n do
    turtle.forward()
  end
end

function moveBackward(n)
  for i = 1, n do
    turtle.back()
  end
end

function digLoop(length, width)
	-- First 2 Layers
	turtle.turnLeft()

	for i = 1, width do
	  digIt(i)
	end
 length = length - 1

	turtle.turnRight()
	digIt(1)
	turtle.turnRight()

	for i = 1, width - 1 do
	  digIt(i)
	end
 length = length - 1

 -- Rest of the layers, increment by 2
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
		if i % 3 == 0 then
     placeTorch()
  end
	end

 -- Accounts for one-off error
 if length % 2 == 0 then
   turtle.turnLeft()
   digIt(1)
   turtle.turnLeft()
   for i = 1, width - 1 do
     digIt(i)
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

-- Turn the turtle around, moves back
while turtle.forward() == false do
  turtle.turnRight()
end

moveForward(length)

if turtle.forward() == false then
  turtle.turnRight()
  moveForward(length)
end
