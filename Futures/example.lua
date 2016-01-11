local Future = require("luasrc/Future")

local function factorialTailCaller(x, accumulatedTotal)
  if x > 1 then
    return factorialTailCaller(x - 1, x * accumulatedTotal)
  end
  return accumulatedTotal
end
local function factorial(x)
  return factorialTailCaller(x, 1)
end

local function promiseChecker(promise, name)
  while not (promise:isFulfilled() or promise:isBroken()) do 
    print(name, "Pending?", promise:isPending())
  end  
  
  if promise:isFulfilled() then
    print(name, "=", promise:result())
  else
    print(name, "[PROMISE BROKEN]")
  end
end

local function myCallbackPrint(result, ...)
  local printLabels = {...}
  table.insert(printLabels, result)
  print(table.unpack(printLabels))
end

local function standardExamples()
  local factorial7CalculationPromise  = Future(factorial, 7)
  local factorial10CalculationPromise = Future(factorial, 10):callback(print)
  local factorial12CalculationPromise = Future(factorial, 12):callback(print, "is the result of Factorial 12.")
  local factorial14CalculationPromise = Future(factorial, 14):callback(myCallbackPrint, "[CALLBACK PRINT]", "Factorial 14", "=")
  
  promiseChecker(factorial7CalculationPromise, "Factorial 7")
end

local function promiseWatchingExamples()
	local simplePromise = Future(factorial, 8)	
	local hardPromise   = Future(factorial, 20)
	
	local promiseToCheckTheSimplePromise = Future(promiseChecker, simplePromise, "Factorial 8")
	promiseChecker(hardPromise, "Factorial 20")
end

local function immediateCallbackExamples()
  Future(factorial, 13):callback(myCallbackPrint, "[CALLBACK PRINT]", "Factorial 13", "=")
  
  local promise = Future(factorial, 16):callback(myCallbackPrint, "[CALLBACK PRINT]", "Factorial 16", "=")
  promiseChecker(promise, "Factorial 16")
end

-- My strange design decisions --
local function futureMustReturnIndividualValue()
  local function noReturn()
    print("('noReturn' finished execution, has no return value - thus, will break promise)")
  end
  local promise = Future(noReturn):callback(myCallbackPrint, "[YOU WILL NOT SEE THIS]")
  promiseChecker(promise, "('noReturn' Result)")
  
  local function multiReturn()
    return 'A', 'B', 'C'
  end
  local promiseB = Future(multiReturn):callback(myCallbackPrint, "[Only the first return value is saved]")
end

-- Syntactic Sugar --
local future = require("luasrc/Future2")
local function syntacticSugarExamples()
  future(factorial, 17)(print, "is the result of Factorial 17.")

  local promise = future(factorial, 19)(print, "is the result of Factorial 19.")
  promiseChecker(promise, "Factorial 19")
end

-- Forcefully Breaking a Promise --
local function disregardingPromiseExample()
  local function infiniteloopfunc() while true do end end
  local promise = Future(infiniteloopfunc)
  print('state', promise.testing.getFutureThreadState(), "Should be 'RUNNABLE'")
  promise:disregard()
  print('state', promise.testing.getFutureThreadState(), "Should be 'TERMINATED'")
  promiseChecker(promise, "[Promise Disregarded - Should be BROKEN]")
end

standardExamples()
print("[Checkpoint A]")
promiseWatchingExamples()
print("[Checkpoint B]")
immediateCallbackExamples()
print("[Checkpoint C]")
futureMustReturnIndividualValue()
print("[Checkpoint D]")
syntacticSugarExamples()
print("[Checkpoint E]")
--disregardingPromiseExample()
--print("[Checkpoint F]")
