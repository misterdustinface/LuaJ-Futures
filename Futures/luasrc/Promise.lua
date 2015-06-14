local function isBroken(promise)
	return promise.status == "BROKEN"
end

local function isPending(promise)
	return promise.status == "PENDING"
end

local function isFulfilled(promise)
	return promise.status == "FULFILLED"
end

local function result(promise)
	return promise.key
end

local function fulfilled(notifier, key)
	notifier.promise.key = key
	notifier.promise.status = "FULFILLED"
end

local function broken(notifier)
	notifier.promise.status = "BROKEN"
end

function Promise()

	local promise = {
		isPending   = isPending,
		isBroken    = isBroken,
		isFulfilled = isFulfilled,
		result      = result,
		status      = "PENDING",
	}
	
	local notifier = {
		promise     = promise,
		fulfilled   = fulfilled,
		broken      = broken,
	}
	
	return promise, notifier
end