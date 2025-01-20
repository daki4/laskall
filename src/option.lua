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

---Returns true if the Option is None or the value inside of it matches a predicate
---@generic T
---@param f fun(value: T): boolean The predicate function
---@return boolean true if Option is None or predicate returns true
function optionFactory.baseState:IsNoneOr(f)
  return self:match({
    [Some] = function(val) return f(val) end,
    [None] = function() return true end
  })
end

---Maps an Option<T> to Option<U> by applying a function to a contained value
---@generic T, U
---@param f fun(value: T): U Function to apply to the contained value
---@return Option<U> A new Option containing the modified value
function optionFactory.baseState:Map(f)
  return self:match({
    [Some] = function(x) return Some(f(x)) end,
    [None] = function() return None() end
  })
end

---Returns the provided default result if None, or applies a function to the contained value
---@generic T, U
---@param default U The default value to return if None
---@param f fun(value: T): U The function to apply if Some
---@return U The result of the function or the default value
function optionFactory.baseState:MapOr(default, f)
  return self:match({
    [Some] = function(val) return f(val) end,
    [None] = function() return default end
  })
end

---Returns the result of evaluating a default function if None, or applies a function to the contained value
---@generic T, U
---@param fdefault fun(): U Function that returns the default value
---@param f fun(value: T): U The function to apply if Some
---@return U The result of either function
function optionFactory.baseState:MapOrElse(fdefault, f)
  return self:match({
    [Some] = function(val) return f(val) end,
    [None] = function() return fdefault() end
  })
end

---Returns the contained Some value, or raises an error if None
---@generic T
---@return T The contained value
---@error "unwrapped a None value" when called on None
function optionFactory.baseState:Unwrap()
  return self:match({
    [Some] = function(x) return x end,
    [None] = function() error("unwrapped a None value") end
  })
end

---Returns the contained Some value or a provided default
---@generic T
---@param default T The default value to return if None
---@return T The contained value or the default
function optionFactory.baseState:UnwrapOr(default)
  return self:match({
    [Some] = function(val) return val end,
    [None] = function() return default end
  })
end

---Calls the provided function with the contained value if Some
---@generic T
---@param f fun(value: T) Function to call with the contained value
---@return Option<T> The original Option
function optionFactory.baseState:Inspect(f)
  return self:match({
    [Some] = function(val) f(val) return self end,
    [None] = function() return self end
  })
end

---Returns the contained Some value or computes it from a closure
---@generic T
---@param f fun(): T Function to compute the value if None
---@return T The contained value or computed value
function optionFactory.baseState:UnwrapOrElse(f)
  return self:match({
    [Some] = function(val) return val end,
    [None] = function() return f() end
  })
end

---Transforms the Option<T> into a Result<T, E>
---@generic T, E
---@param e fun(): E|E Error value or function returning error value
---@return Result<T, E> Result containing the value or error
function optionFactory.baseState:OkOr(e)
  return self:match({
    [Some] = function(val) return Ok(val) end,
    [None] = function() return Err(type(e) == "function" and e() or e) end
  })
end

---Returns self if it contains a value, otherwise returns optB
---@generic T
---@param optB Option<T> The other Option to return if self is None
---@return Option<T> The first Some value or None if both are None
function optionFactory.baseState:Or(optB)
  return self:match({
    [Some] = function(_) return self end,
    [None] = function() return optB end
  })
end

---Returns self if it contains a value, otherwise calls f and returns the result
---@generic T
---@param f fun(): Option<T> Function that returns an Option
---@return Option<T> The first Some value or the result of f
function optionFactory.baseState:OrElse(f)
  return self:match({
    [Some] = function(_) return self end,
    [None] = function() return f() end
  })
end

---Returns Some if exactly one of self and optB is Some, otherwise returns None
---@generic T
---@param optB Option<T> The other Option to compare with
---@return Option<T> Option containing the Some value or None
function optionFactory.baseState:Xor(optB)
  return self:match({
    [Some] = function(val)
      return
          optB:match({
            [Some] = function(_) return None() end,
            [None] = function() return Some(val) end
          })
    end,
    [None] = function()
      return
          optB:match({
            [Some] = function(val) return Some(val) end,
            [None] = function() return None() end
          })
    end
  })
end

---Returns None if self is None, otherwise returns optB
---@generic T, U
---@param optB Option<U> The other Option to return if self is Some
---@return Option<U> optB if self is Some, None otherwise
function optionFactory.baseState:And(optB)
  return self:match({
    [Some] = function(_) return optB end,
    [None] = function() return None() end
  })
end

---Returns None if self is None, otherwise calls f with the contained value
---@generic T, U
---@param f fun(value: T): Option<U> Function that returns an Option
---@return Option<U> The result of f or None
function optionFactory.baseState:AndThen(f)
  return self:match({
    [Some] = function(val) return f(val) end,
    [None] = function() return None() end
  })
end

---Returns None if self is None, otherwise calls predicate with the contained value
---@generic T
---@param p fun(value: T): boolean Predicate function returning boolean
---@return Option<T> Some if predicate returns true, None otherwise
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

---Returns the contained Some value or raises an error with a custom message
---@generic T
---@param message string The error message to use if None
---@return T The contained value
---@error message when called on None
function optionFactory.baseState:Expect(message)
  return self:match({
    [Some] = function(x) return x end,
    [None] = function() error(message) end
  })
end

MakeReadOnly(optionFactory)

--print(TableToString(optionFactory))
