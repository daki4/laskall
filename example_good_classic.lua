local function divide(x, y)
  if y == 0 then
    error("divide by zero")
  end
  return (x / y)
end

function Main()
  local x = 5;
  local y = 5;

  local success, result = pcall(divide, x, y)
  if not success then
    print("got error")
  else
    print(result)
  end
end

Main()
