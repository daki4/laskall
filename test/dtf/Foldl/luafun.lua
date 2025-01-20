local fun = require('fun')

local result = fun.reduce(function(acc, x) return x - acc end, 0, {1, 2, 3, 4, 5})
print(result)
