-- Script used to drop all items in the slots 1-15 of the bot's inventory
function dropAll()
  for i = 1, 15 do
    turtle.select(i)
    turtle.drop()
  end
  turtle.select(16)
end

dropAll()
