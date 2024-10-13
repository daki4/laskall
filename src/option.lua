require("adt")

local option = BuildAdt("Option")

function Some(value)
  return option:AdtCtor(Some, value)
end

function None()
  return option:AdtCtor(None, nil)
end

option:Register(Some, "Some(T)", true)
option:Register(None, "None", false)

MakeReadOnly(option)
