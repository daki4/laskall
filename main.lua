package.path = os.getenv("SRC_FOLDER") .. "/*.lua" .. package.path

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

  --print(TableToString(valSome))

  print("option map returned: " .. valSome:Map(function (_) return "Okay" end):match(optPatternMatch))
  print("option map returned: " .. valNone:Map(function (_) return "Okay" end):match(optPatternMatch))
  print("option unwrap returned: " .. tostring(valSome:Unwrap()))
  local val = "had no error"
  local err = pcall(function () valNone:Unwrap() end)
  if not err then
    val = "error thrown, Tried to unwrap a None"
  end
  print("option unwrap returned: " .. val)
  print("option Ok returned: " .. valSome:OkOr(None):match(resultPatternMatch))
  print("option Ok returned: " .. valNone:OkOr(None):match(resultPatternMatch):match(optPatternMatch))

end

Main()
