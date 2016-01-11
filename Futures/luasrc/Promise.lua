local function isBroken(promise)
	return promise._status == "BROKEN"
end

local function isPending(promise)
	return promise._status == "PENDING"
end

local function isFulfilled(promise)
	return promise._status == "FULFILLED"
end

local function getResult(promise)
	return promise._result
end

local function setCallback(promise, xCallbackFunction, ...)
  promise._callbackFunc = xCallbackFunction
  promise._callbackArgs = {...}
  return promise
end

local function interrupt()

end

local function disregard()
  
end

local function fulfilled(notifier, result)
  local promise = notifier.promise
	promise._result = result
	promise._status = "FULFILLED"
	promise._callbackFunc(result, table.unpack(promise._callbackArgs))
end

local function broken(notifier)
  local promise = notifier.promise
	promise._status = "BROKEN"
end

local function Promise()

	local promise = {
		isPending   = isPending,
		isBroken    = isBroken,
		isFulfilled = isFulfilled,
		result      = getResult,
		callback    = setCallback,
		_result     = nil,
		_status      = "PENDING",
		_callbackFunc = function() end,
		_callbackArgs = {},
	}
	
	local notifier = {
		promise     = promise,
		fulfilled   = fulfilled,
		broken      = broken,
	}
	
	return promise, notifier
end

return Promise