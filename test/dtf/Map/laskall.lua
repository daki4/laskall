package.path = os.getenv("SRC_DIR") .. '/?.lua;' .. package.path

F = require("laskall")
result = F.map(function(x) return x * 2 end, {1,2,3,nil,4,5})
print(table.concat(result, " "))
