---Checks if a table contains a specific value
---@param t table The table to search in
---@param value any The value to search for
---@return boolean true if the value is found, false otherwise
function ContainsValue(t, value)
    for _, v in pairs(t) do
        if v == value then
            return true
        end
    end
    return false
end

---Checks if a table contains a specific key
---@param t table The table to search in
---@param value any The key to search for
---@return boolean true if the key is found, false otherwise
function ContainsKey(t, value)
  for k, _ in pairs(t) do
    if k == value then
      return true
    end
  end
  return false
end

---Makes a table read-only by creating a proxy with a metatable that prevents modifications
---@param t table The table to make read-only
---@return table A read-only proxy of the input table
function MakeReadOnly(t)
  return setmetatable({}, {
    __index = t,
    __newindex = function(_, _, _)
      error("Attempt to modify a read-only table", 2)
    end,
    __metatable = false
  })
end

---Converts a table to a string representation with proper indentation
---@param tbl table The table to convert
---@param indent number? Optional indentation level (default: 0)
---@return string The string representation of the table
function TableToString(tbl, indent)
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
          str = str .. TableToString(v, indent + 1)  -- Recursively format nested tables
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
