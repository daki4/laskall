---@module 'adt'
require("common")
require("debug")

local function containsCase(states, case)
  for _, entry in ipairs(states) do
    if entry.func == case then
      return true
    end
  end
  return false
end

local function copy(obj, seen)
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
  return res
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
  local adtFactory = { name = typename, baseState = {} }

  local states = setmetatable({ { func = Any, name = "Any", takesValue = false } }, funcArrMt)

  function adtFactory:Register(func, name, takesValue)
    table.insert(states, { func = func, name = name, takesValue = takesValue })
  end

  function adtFactory:AdtCtor(state, value)
    if type(states) ~= "table" then
      error("states needs to be a list")
    end

    function adtFactory.baseState:match(cases)
      for key, _ in pairs(cases) do
        if not containsCase(states, key) then
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

    local instance = copy(adtFactory.baseState)
    return instance
  end

  return adtFactory
end

