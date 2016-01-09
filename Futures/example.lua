require("luasrc/Future")

local function factorial(x)
	local result
	if x <= 1 then 
		result = 1
	else
		result = x * factorial(x - 1)
	end
	return result
end

local function promiseChecker(promise, name)
	while not (promise:isFulfilled() or promise:isBroken()) do 
		print(name, "Pending?", promise:isPending())
	end
	
	print(name, "RESULT:", promise:result())
	return promise:result()
end

local function standardExample()
  local factorial8CalculationPromise  = Future(factorial, 8)
  local factorial12CalculationPromise = Future(factorial, 12)
end

local function wackyConcurrencyExample()
	local simplePromise = Future(factorial, 7)
	local a             = Future(promiseChecker, simplePromise, "Factorial 7:")
	
	local hardPromise   = Future(factorial, 20)
	local b             = Future(promiseChecker, hardPromise, "Factorial 20:")
end

local function immediateCallbackExample()
  local function displayResult(xResult, xLabel)
    print(xLabel, xResult)
  end
  
  Future(factorial, 13):callback(displayResult, "Factorial 13:")
  
  local promise = Future(factorial, 16):callback(displayResult, "Factorial 16:")
  promiseChecker(promise, "Factorial 16:")
end

standardExample()
wackyConcurrencyExample()
immediateCallbackExample()