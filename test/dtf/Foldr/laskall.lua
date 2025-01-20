package.path = os.getenv("SRC_DIR") .. '/?.lua;' .. package.path

local F = require('laskall')

local result = F.foldr(function(x, acc) return x - acc end, 0, {1, 2, 3})
print(result)

