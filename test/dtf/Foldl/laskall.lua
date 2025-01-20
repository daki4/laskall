package.path = os.getenv("SRC_DIR") .. '/?.lua;' .. package.path
F = require('laskall')
result = F.foldl(function(acc, x) return x - acc end, 0, {1,2,3,4,5})
print(result)
