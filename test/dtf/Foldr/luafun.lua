fun = require('fun')
t = {1,2,3}
result = fun.reduce(function(acc, x) return x - acc end, 0, fun.iter(t))
print(result)
