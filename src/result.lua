require("common")

local result = BuildAdt("Result")

function Ok(value)
  return result:AdtCtor(Ok, value)
end

function Err(error)
  return result:AdtCtor(Err, error)
end

result:Register(Ok, "Ok(T)", true)
result:Register(Err, "Err(E)", true)

MakeReadOnly(result)
