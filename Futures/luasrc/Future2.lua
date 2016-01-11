local Future = require("luasrc/Future")

local function future(futureFunction, ...)
  local promise = Future(futureFunction, ...)
  local function setCallback(callbackFunc, arg1, arg2, arg3)
    promise:callback(callbackFunc, arg1, arg2, arg3)  
    return promise
  end
  return setCallback
end

return future