require("common")
require("debug")

local function cointainsCase(states, case)
  for _, entry in ipairs(states) do
    if entry.func == case then
      return true
    end
  end
  return false
end

local funcArrMt = {
  __index = function(t, key)
        for _, entry in ipairs(t) do
            if entry.func == key then
                return entry
            end
        end
      return nil
  end
}

function BuildAdt(typename)

  local adt = {name = typename}

  local states = setmetatable({{func = Any, name = "Any", takesValue = false}}, funcArrMt)

  function adt:Register(func, name, takesValue)
    table.insert(states, {func = func, name = name, takesValue = takesValue})
  end

  function adt:AdtCtor(state, value)
    if type(states) ~= "table" then
      error("states needs to be a list")
    end
  
    local tp = {}
    function tp:match(cases)
      for key, _ in pairs(cases) do
        if not cointainsCase(states, key) then
          error(debug.getinfo(key, "n").name .. " is not a valid member of ADT type " .. typename)
        end
      end
  
      if ContainsKey(cases, state) then
        local case = cases[state]
        if states[state].takesValue == true then
          return case(value)
        else
          return case()
        end
      end
  
      if ContainsKey(cases, Any) then
        return cases[Any]()
      end
    end
  
    return tp
    end
  return adt
end
