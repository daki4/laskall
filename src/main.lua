--package.path = os.getenv("SRC_DIR") .. '/?.lua;' .. package.path

local lskl = require("laskall")
local json = require("dkjson")
--local function divide(x, y)
--  if y == 0 then
--    return None()
--  end
--  return Some(x / y)
--end
--
--function Main()
--  local x = 5;
--  local y = 5;
--
--  divide(x, y):match({
--    [Some] = function (val)
--      print("result: " .. tostring(val))
--    end,
--    [None] = function ()
--      print("got error")
--    end
--  })
--end
--
--local function isEven(x)
--  return x % 2 == 0
--end
--
--local function doubleEven(x)
--  if isEven(x) then
--  return x * 2
--  end
--  return x
--end
--
--local function isTriple(x)
--  return x % 3 == 0
--end
--local function quadrupleOdd(x)
--  if not isEven(x) then
--    return x * 4
--  end
--  return x
--end
--pipe(lskl.range(0, 100),
--    ra(lskl.filter, isEven),
--    --ra(lskl.filter, isTriple),
--    ra(lskl.filter, function(x) return not isTriple(x) end),
--    --ra(lskl.map, doubleEven),
--    --ra(lskl.map, quadrupleOdd),
--    ra(lskl.each, print))
--
--Main()

local x = 'test test kur test test kur kurva bober'
function mysplit(inputstr, sep)
  if sep == nil then
    sep = '%s'
  end
  local t = {}
  for str in string.gmatch(inputstr, '([^' .. sep .. ']+)')
  do
    table.insert(t, str)
  end
  return t
end

ans = mysplit(x, " ")
print(TableToString(ans))
for j, i in ipairs(ans) do
  print(i .. " " .. j)
end
-- print(ans)
--node = {
--key = "word",
--occurences = 1234,
--left = {node} | nil,
--right = {node} | nil
--}

local tree = { key = "", occurences = 0, left = nil, right = nil }

local function insert(node, str)
  if node.key > str then
    if node.left == nil then
      node.left = {
        key = str,
        occurences = 1,
        left = nil,
        right = nil
      }
    else
      insert(node.left, str)
    end
  elseif node.key == str then
    node.occurences = node.occurences + 1
  else
    if node.right == nil then
      node.right = {
        key = str,
        occurences = 1,
        left = nil,
        right = nil
      }
    else
      insert(node.right, str)
    end
  end
end

for _, val in ipairs(ans) do
  insert(tree, val)
end


-- local jsonString = json.encode(tree, { indent = true })
--print(jsonString)

local function find(tree, string)
  if tree.key > string then
    if tree.left ~= nil then
      return find(tree.left, string)
    else
      return None()
    end
  elseif tree.key == string then
    return Some(tree.occurences)
  else
    if tree.right ~= nil then
      return find(tree.right, string)
    else
      return None()
    end
  end
end

function double(x)
  return x * 2
end

pipe(ra(find(tree, "kura"):match({
  [Some] = function(val) return val end,
  [None] = function () return 0 end
})),
  ra(lskl.map, double),
  ra(lskl.each,   pr  )
)

function pr(z)
  print(z)
end