require("common")

local function bindResult(istate, ivalue)
  local value = ivalue
  local state = istate

  local result = {}

  function result:match(cases)
    for key, _ in pairs(cases) do
      if not ContainsValue({Any, Ok, Err}, key) then
        error(key .." is not a valid member of type result")
      end
    end

    if ContainsKey(cases, state) then
        return cases[state](value)
    end

    if ContainsKey(cases, Any) then
      return cases[Any]()
    end
  end

  return result
end

function Ok(value)
  return bindResult(Ok, value)
end

function Err(error)
  return bindResult(Err, error)
end

