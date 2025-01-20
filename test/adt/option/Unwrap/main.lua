package.path = os.getenv("SRC_DIR") .. '/?.lua;' .. package.path

require("laskall")

function Main()
  local x = Some(10);
  local noerr, val = pcall(function () return x:Unwrap() end)
  if noerr then
    print(val)
  else
    print("true")
  end
end

Main()
