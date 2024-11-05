require("laskall")

function Main()
  local valSome = Some(111)
  local valNone = None()

  local resultOk = Ok(valSome)
  local resultErr = Err(valNone)

  local optPatternMatch = {
    [Some] = function (value)
      return value
    end,
    [None] = function ()
      return 11
    end,
  }

  local resultPatternMatch = {
    [Ok] = function (value)
      return value
    end,
    [Err] = function (value)
      return value
    end
  }
  print("Option returned: " .. tostring(valSome:match(optPatternMatch)))
  print("Option returned: " .. tostring(valNone:match(optPatternMatch)))

  print("Result returned: " .. tostring(resultOk:match(resultPatternMatch):match(optPatternMatch)))
  print("Result returned: " .. tostring(resultErr:match(resultPatternMatch):match(optPatternMatch)))

  print(tableToString(valSome))

  print("option map returned: " .. valSome:Map(function (_) return "Okay" end))
end

Main()

