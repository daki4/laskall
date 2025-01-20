package.path = os.getenv("SRC_DIR") .. '/?.lua;' .. package.path

require("laskall")

local function divide(x, y)
  if y == 0 then
    return None()
  end
  return Some(x / y)
end

function Main()
  local x = 5;
  local y = 0;

  divide(x, y):match({
    [Some] = function (val)
      print("result: " .. tostring(val))
    end,
    [None] = function ()
      print("got error")
    end
  })
end

Main()
