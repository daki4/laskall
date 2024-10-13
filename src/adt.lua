require("common")

function Define(states, istate, ivalue)
  if type(states) ~= "table" then
    error("states needs to be a list")
  end

  local value = ivalue
  local state = istate

  local typ = {}

  function typ:match(cases)
    for key, _ in pairs(cases) do
      if not ContainsValue({Any, Some, None}, key) then
        error(key .." is not a valid member of type Option")
      end
    end

    if ContainsKey(cases, state) then
      if state == Some then
        return cases[state](value)
      end
      return cases[state]()
    end

    if ContainsKey(cases, Any) then
      return cases[Any]()
    end
  end

  return typ
end

