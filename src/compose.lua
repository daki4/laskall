require("dtf")()

local function id(...) return ... end


local function compose(f, g)
    return function(...)
        -- Get generator, param and state from f's iterator
        local gen, param, state = f(...)
        -- Pass the raw iterator parts to g
        return g(gen, param, state)
    end
end

function chain(...)
    -- Convert varargs to table that luafun can iterate over
    local funcs = {...}
    return foldl(compose, id, funcs)
end

function pipe(arg, ...)
    return chain(...)(arg)
end

function ra(f, fun)
    return function(iter)
        return f(fun, iter)
    end
end

