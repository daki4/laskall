require("adt")

local optionFactory = BuildAdt("Option")

function Some(value)
  return optionFactory:AdtCtor(Some, value)
end

function None()
  return optionFactory:AdtCtor(None, nil)
end

optionFactory:Register(Some, "Some(T)", true)
optionFactory:Register(None, "None", false)

function optionFactory.baseState:IsSome()
  return self:match({
    [Some] = true,
    [None] = false,
  })
end

function optionFactory.baseState:IsSomeAnd(f)
  return self:match({
    [Some] = function(val) return f(val) end,
    [None] = function() return false end
  })
end

function optionFactory.baseState:IsNone()
  return self:match({
    [Some] = false,
    [None] = true,
  })
end

function optionFactory.baseState:IsNoneOr(f)
  return self:match({
    [Some] = function(val) return f(val) end,
    [None] = function() return true end
  })
end

function optionFactory.baseState:Map(to_execute)
  return self:match({
    [Some] = function(x) return Some(to_execute(x)) end,
    [None] = function() return None() end
  })
end

function optionFactory.baseState:MapOr(default, f)
  return self:match({
    [Some] = function(val) return f(val) end,
    [None] = function() return default end
  })
end

function optionFactory.baseState:MapOrElse(fdefault, f)
  return self:match({
    [Some] = function(val) return f(val) end,
    [None] = function() return fdefault() end
  })
end

function optionFactory.baseState:Unwrap()
  return self:match({
    [Some] = function(x) return x end,
    [None] = function() error("unwrapped a None value") end
  })
end

function optionFactory.baseState:UnwrapOr(default)
  return self:match({
    [Some] = function(val) return val end,
    [None] = function() return default end
  })
end

function optionFactory.baseState:Inspect(f)
  return self:match({
    [Some] = function(val) f(val) end,
    [None] = function() return None() end
  })
end

function optionFactory.baseState:UnwrapOrElse(f)
  return self:match({
    [Some] = function(val) return val end,
    [None] = function() return f() end
  })
end

function optionFactory.baseState:OkOr(e)
  return self:match({
    [Some] = function(val) return Ok(val) end,
    [None] = function() return Err(e()) end
  })
end

function optionFactory.baseState:Or(optB)
  return self:match({
    [Some] = function(_) return self end,
    [None] = function() return optB end
  })
end

function optionFactory.baseState:OrElse(f)
  return self:match({
    [Some] = function(_) return self end,
    [None] = function() return f() end
  })
end

function optionFactory.baseState:Xor(optB)
  return self:match({
    [Some] = function(val)
      return
          optB:match({
            [Some] = function(_) return None() end,
            [None] = function() return val end
          })
    end,
    [None] = function()
      return
          optB:match({
            [Some] = function(val) return val end,
            [None] = function() return None() end
          })
    end
  })
end

function optionFactory.baseState:And(optB)
  return self:match({
    [Some] = function(_) return optB end,
    [None] = function() return None() end
  })
end

function optionFactory.baseState:AndThen(f)
  return self:match({
    [Some] = function(val) return f(val) end,
    [None] = function() return None() end
  })
end

function optionFactory.baseState:Filter(p)
  return self:match({
    [Some] = function(val)
      if p(val) then
        return Some(val)
      else
        return None()
      end
    end,
    [None] = function() return None() end
  })
end

function optionFactory.baseState:Expect(message)
  return self:match({
    [Some] = function(x) return x end,
    [None] = function() error(message) end
  })
end

MakeReadOnly(optionFactory)

