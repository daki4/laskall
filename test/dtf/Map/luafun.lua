local fun = require("fun")

local result = fun.map(function(x) return x * 2 end, {1, 2, 3}):totable()
print(table.concat(result, " "))
