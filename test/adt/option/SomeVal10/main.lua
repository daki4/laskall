package.path = os.getenv("SRC_DIR") .. '/?.lua;' .. package.path

require("laskall")

function Main()
  local x = Some(10);
  x:match({
    [Some] = function(val) print(tostring(val)) end,
    [None] = function() print("None") end
  })
end

Main()
