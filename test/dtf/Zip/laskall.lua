package.path = os.getenv("SRC_DIR") .. '/?.lua;' .. package.path
local F = require('laskall')

local result = F.zip({1, 2, 3}, {4, 5, 6})
for _, pair in ipairs(result) do
    print(table.concat(pair, " "))
end
