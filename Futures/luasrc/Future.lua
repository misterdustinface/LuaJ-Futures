require("luasrc/Thread")
require("luasrc/Promise")

function Future(futureFunction, ...)

	local varargs = {...}
	local promise, notifier = Promise()
	
	local function futureFunctionWrapper()
		local result = futureFunction(table.unpack(varargs))
		if result then
			notifier:fulfilled(result)
		else 
			notifier:broken()
		end
	end

	local thread = Thread(futureFunctionWrapper)
	thread:start()
	
	return promise
end