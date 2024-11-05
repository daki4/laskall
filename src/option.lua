require("adt")

local optionFactory = BuildAdt("Option")

function Some(value)
    return optionFactory:AdtCtor(Some, value)
end

function None()
    return optionFactory:AdtCtor(None, nil)
end

function optionFactory.baseState:Map(to_execute)
  return optionFactory.baseState:match({
    [Some] = to_execute,
    [None] = None
  })
end


optionFactory:Register(Some, "Some(T)", true)
optionFactory:Register(None, "None", false)


