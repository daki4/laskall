require("common")

local resultFactory = BuildAdt("Result")

function Ok(value)
  return resultFactory:AdtCtor(Ok, value)
end

function Err(error)
  return resultFactory:AdtCtor(Err, error)
end

resultFactory:Register(Ok, "Ok(T)", true)
resultFactory:Register(Err, "Err(E)", true)
function x()
  return self:match({
    [Ok] = function(val) return end,
    [Err] = function(err) return end
  })
end

function resultFactory.baseState:And(resB)
  return self:match({
    [Ok] = function(_) return resB end,
    [Err] = function(err) return Err(err) end
  })
end

function resultFactory.baseState:AndThen(f)
  return self:match({
    [Ok] = function(val) return f(val) end,
    [Err] = function(err) return Err(err) end
  })
end

function resultFactory.baseState:Err()
  return self:match({
    [Ok] = function(_) return None() end,
    [Err] = function(err) return Some(err) end
  })
end

function resultFactory.baseState:Expect(message)
  return self:match({
    [Ok] = function(val) return val end,
    [Err] = function(_) return error(message) end
  })
end

function resultFactory.baseState:ExpectErr(message)
  return self:match({
    [Ok] = function(val) return error(message .. tostring(val)) end,
    [Err] = function(err) return err end
  })
end

function resultFactory.baseState:Inspect(f)
  return self:match({
    [Ok] = function(val) return f(val) end,
    [Err] = function(err) return Err(err) end
  })
end

function resultFactory.baseState:InspectErr(f)
  return self:match({
    [Err] = function(err) return f(err) end,
    [Ok] = function(val) return Ok(val) end
  })
end

function resultFactory.baseState:IsOk()
  return self:match({
    [Ok] = function(_) return true end,
    [Err] = function(_) return false end
  })
end

function resultFactory.baseState:IsOkAnd(f)
  return self:match({
    [Ok] = function(val) return f(val) end,
    [Err] = function(_) return false end
  })
end

function resultFactory.baseState:IsErr()
  return self:match({
    [Ok] = function(_) return false end,
    [Err] = function(_) return true end
  })
end

function resultFactory.baseState:IsErrAnd(f)
  return self:match({
    [Ok] = function(_) return false end,
    [Err] = function(err) return f(err) end
  })
end

function resultFactory.baseState:Ok()
  return self:match({
    [Ok] = function(val) return Some(val) end,
    [Err] = function(_) return None() end
  })
end

function resultFactory.baseState:Map(f)
  return self:match({
    [Ok] = function(val) return Ok(f(val)) end,
    [Err] = function(err) return Err(err) end
  })
end

function resultFactory.baseState:MapOr(ferr, fok)
  return self:match({
    [Ok] = function(val) return fok(val) end,
    [Err] = function(_) return ferr() end
  })
end

function resultFactory.baseState:MapOrElse(ferr, fok)
  return self:match({
    [Ok] = function(val) return fok(val) end,
    [Err] = function(err) return ferr(err) end
  })
end

function resultFactory.baseState:MapErr(f)
  return self:match({
    [Ok] = function(val) return Ok(val) end,
    [Err] = function(err) return Err(f(err)) end
  })
end

function resultFactory.baseState:Or(resB)
  return self:match({
    [Ok] = function(val) return Ok(val) end,
    [Err] = function(_) return resB end
  })
end

function resultFactory.baseState:OrElse(f)
  return self:match({
    [Ok] = function(val) return Ok(val) end,
    [Err] = function(err) return f(err) end
  })
end

function resultFactory.baseState:Unwrap()
  return self:match({
    [Ok] = function(val) return val end,
    [Err] = function(_) return error("Tried to Unwrap() a Result:Err") end
  })
end

function resultFactory.baseState:UnwrapErr()
  return self:match({
    [Ok] = function(_) return error("Tried to UnwrapErr() a Result:Ok") end,
    [Err] = function(err) return err end
  })
end

function resultFactory.baseState:UnwrapOrElse(f)
  return self:match({
    [Ok] = function(val) return val end,
    [Err] = function(err) return f(err) end
  })
end

function resultFactory.baseState:UnwrapOr(default)
  return self:match({
    [Ok] = function(val) return val end,
    [Err] = function(_) return default end
  })
end

MakeReadOnly(resultFactory)
