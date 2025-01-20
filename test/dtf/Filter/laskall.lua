package.path = os.getenv("SRC_DIR") .. '/?.lua;' .. package.path

F = require("laskall")

local result = F.filter(function(x) return x > 2 end, {1, 2, 3, 4, 5})
print(table.concat(result, " "))

