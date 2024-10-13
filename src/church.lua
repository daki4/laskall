local function zero(_)
    return function(x)
        return x
    end
end

local function next(n)
    return function(f)
        return function(x)
            return f(n(f)(x))
        end
    end
end


local function to_integer(n)
    return n(function(x) return x + 1 end)(0)
end

local function main()
  local one = next(zero)
  local two = next(one)

  print(to_integer(two))
end

main()
