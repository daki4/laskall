package.path = os.getenv("SRC_DIR") .. '/?.lua;' .. package.path

require("laskall")

function Main()
  local x = None();
  local err = pcall(function () x:Unwrap() end)
  if not err then
    print("true")
  end
end

Main()
