function dropAll()
  for i = 1, 15 do
    turtle.select(i)
    turtle.drop()
  end
  turtle.select(16)
end

dropAll()