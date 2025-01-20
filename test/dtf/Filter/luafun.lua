local fun = require('fun')

local result = fun.filter(function(x) return x > 2 end, {1, 2, 3, 4, 5}):totable()
print(table.concat(result, " "))

