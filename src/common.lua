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

Any = -1

