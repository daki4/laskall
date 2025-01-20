--return require("fun")

local F = {}

-- map: Apply a function to all elements in a table
function F.map(fn, tbl)
    local result = {}
    for i, v in ipairs(tbl) do
        result[i] = fn(v)
    end
    return result
end

-- filter: Keep elements that satisfy a predicate
function F.filter(pred, tbl)
    local result = {}
    for _, v in ipairs(tbl) do
        if pred(v) then
            table.insert(result, v)
        end
    end
    return result
end

-- foldr: Right-associative fold
function F.foldr(fn, init, tbl)
    local acc = init
    for i = #tbl, 1, -1 do
        acc = fn(tbl[i], acc)
    end
    return acc
end

-- foldl: Left-associative fold
function F.foldl(fn, init, tbl)
    local acc = init
    for _, v in ipairs(tbl) do
        acc = fn(acc, v)
    end
    return acc
end

-- concat: Concatenate multiple tables
function F.concat(tbls)
    local result = {}
    for _, tbl in ipairs(tbls) do
        for _, v in ipairs(tbl) do
            table.insert(result, v)
        end
    end
    return result
end

-- concatMap: Map and then concatenate results
function F.concatMap(fn, tbl)
    return F.concat(F.map(fn, tbl))
end

-- zip: Combine two tables element-wise
function F.zip(tbl1, tbl2)
    local result = {}
    local len = math.min(#tbl1, #tbl2)
    for i = 1, len do
        result[i] = {tbl1[i], tbl2[i]}
    end
    return result
end

-- zipWith: Combine two tables using a function
function F.zipWith(fn, tbl1, tbl2)
    local result = {}
    local len = math.min(#tbl1, #tbl2)
    for i = 1, len do
        result[i] = fn(tbl1[i], tbl2[i])
    end
    return result
end

-- take: Take first n elements
function F.take(n, tbl)
    local result = {}
    for i = 1, math.min(n, #tbl) do
        result[i] = tbl[i]
    end
    return result
end

-- drop: Drop first n elements
function F.drop(n, tbl)
    local result = {}
    for i = n + 1, #tbl do
        result[#result + 1] = tbl[i]
    end
    return result
end

-- splitAt: Split table at index n
function F.splitAt(n, tbl)
    return F.take(n, tbl), F.drop(n, tbl)
end

-- reverse: Reverse a table
function F.reverse(tbl)
    local result = {}
    for i = #tbl, 1, -1 do
        table.insert(result, tbl[i])
    end
    return result
end

-- sort: Sort a table (creates a new table)
function F.sort(tbl, comp)
    local result = {}
    for i, v in ipairs(tbl) do
        result[i] = v
    end
    table.sort(result, comp)
    return result
end

-- group: Group consecutive equal elements
function F.group(tbl)
    if #tbl == 0 then return {} end
    local result = {}
    local current = {tbl[1]}
    
    for i = 2, #tbl do
        if tbl[i] == tbl[i-1] then
            table.insert(current, tbl[i])
        else
            table.insert(result, current)
            current = {tbl[i]}
        end
    end
    table.insert(result, current)
    return result
end

-- ungroup: Flatten grouped elements
function F.ungroup(tbl)
    return F.concat(tbl)
end

-- traverse: Map with effects (simplified version)
function F.traverse(fn, tbl)
    local result = {}
    for _, v in ipairs(tbl) do
        local mapped = fn(v)
        if mapped ~= nil then
            table.insert(result, mapped)
        end
    end
    return result
end

-- sequence: Evaluate effects in sequence
function F.sequence(tbl)
    return F.traverse(function(x) return x end, tbl)
end

-- mapM: Monadic map (simplified for Lua)
F.mapM = F.traverse  -- In Lua, we'll treat this the same as traverse

-- fmap: Functor map (same as map in this context)
F.fmap = F.map

-- bind: Monadic bind (simplified for Lua)
function F.bind(value, fn)
    if value == nil then return nil end
    return fn(value)
end

-- return: Wrap a value (identity in Lua)
function F.return_(value)
    return value
end

-- pure: Same as return in this context
F.pure = F.return_

-- head: Get first element
function F.head(tbl)
    return tbl[1]
end

-- tail: Get all but first element
function F.tail(tbl)
    return F.drop(1, tbl)
end

-- init: Get all but last element
function F.init(tbl)
    return F.take(#tbl - 1, tbl)
end

-- last: Get last element
function F.last(tbl)
    return tbl[#tbl]
end

return F
