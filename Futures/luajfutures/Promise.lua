-- Promise Methods --
local function isBroken(promise)
	return promise.private.status == "BROKEN"
end

local function isPending(promise)
	return promise.private.status == "PENDING"
end

local function isFulfilled(promise)
	return promise.private.status == "FULFILLED"
end

local function getResult(promise)
	return promise.private.result
end

local function setCallback(promise, xCallbackFunction, ...)
  promise.private.callbackFunc = xCallbackFunction
  promise.private.callbackArgs = {...}
  return promise
end

local function disregard(promise)
  promise.private.stopFuture()
  promise.private.result = nil
  promise.private.status = "BROKEN"
  promise.private.callbackFunc = function() end
  promise.private.callbackArgs = {}
end

-- Notifier Methods --
local function setPromiseFulfilled(notifier, result)
  local promise = notifier.private.promise
	promise.private.result = result
	promise.private.status = "FULFILLED"
	promise.private.callbackFunc(result, table.unpack(promise.private.callbackArgs))
end

local function setPromiseBroken(notifier)
  local promise = notifier.private.promise
	promise.private.status = "BROKEN"
end

local function Promise()

	local promise = {
		isPending   = isPending,
		isBroken    = isBroken,
		isFulfilled = isFulfilled,
		result      = getResult,
		callback    = setCallback,
		disregard   = disregard,
		private = {
		  result = nil,
		  status = "PENDING",
		  callbackFunc = function() end,
		  callbackArgs = {},
		  stopFuture   = function() end,
		},
		testing = {
		  getFutureThreadState = function() return "NA" end,
		},
	}
	
	local notifier = {
		fulfilled = setPromiseFulfilled,
		broken    = setPromiseBroken,
		private = {
		  promise = promise,
		},
	}
	
	return promise, notifier
end

return Promise