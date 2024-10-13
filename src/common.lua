function ContainsValue(t, value)
    for _, v in pairs(t) do
        if v == value then
            return true
        end
    end
    return false
end

function ContainsKey(t, value)
  for k, _ in pairs(t) do
    if k == value then
      return true
    end
  end
  return false
end

function MakeReadOnly(t)
  return setmetatable({}, {
    __index = t,
    __newindex = function(_, _, _)
      error("Attempt to modify a read-only table", 2)
    end,
    __metatable = false
  })
end

-- Recursive function to convert a table to a string
function tableToString(tbl, indent)
  indent = indent or 0  -- Default indentation level
  local str = ""
  local indentStr = string.rep("  ", indent)  -- Two spaces per indent level

  str = str .. "{\n"
  for k, v in pairs(tbl) do
      -- Format the key as a string
      local keyStr = tostring(k)
      str = str .. indentStr .. "  [" .. keyStr .. "] = "

      -- Handle different value types
      if type(v) == "table" then
          str = str .. tableToString(v, indent + 1)  -- Recursively format nested tables
      elseif type(v) == "string" then
          str = str .. '"' .. v .. '"\n'  -- Add quotes around strings
      else
          str = str .. tostring(v) .. "\n"  -- Convert other types to strings
      end
  end
  str = str .. indentStr .. "}"

  return str
end

-- wildcard handle
Any = -1

