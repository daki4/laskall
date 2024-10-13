require("common")


local function bindOption(istate, ivalue)
  local value = ivalue
  local state = istate

  local option = {}

  function option:match(cases)
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

  return option
end

function Some(value)
  return bindOption(Some, value)
end

function None()
  return bindOption(None, nil)
end

