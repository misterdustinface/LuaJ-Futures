## LuaJ Futures

First of all, [what are Futures and Promises?](https://en.wikipedia.org/wiki/Futures_and_promises)

##### Furthermore,
0. [What does this library do](#what-does-this-library-do)
1. [Why futures are useful](#why-futures-are-useful)
2. [When should you use futures](#when-should-you-use-futures)
3. [How to use this library](#how-to-use-this-library)

## What does this library do
  - This library implements "eager" futures - where computation starts as soon as the future is created - which run in dynamically created threads.
  - Note: There are a few variations of usage in this library

## Why futures are useful
  - Futures are practical for delegating tasks
  - Futures are especially useful for delegating lengthy tasks

## When should you use futures
  - Loading pictures, video, or sound within a menu
  - Loading a level of a video game, or some feature of that level
  - Loading anything
  - Lengthy computation

## How to use this library

First, include the library
```Lua
  local future = require('luajfutures/Future')
```

Then, define some function, which should take some time to complete, and returns one value
```Lua
  local function computeY(x)
    local y = x/3 + 5.2
    return y
  end
```

Then run the function as a future, followed by any arguments you wish to pass to the function
```Lua
  local promise = future(computeY, 3)
```

A future returns a promise, which can be monitored with
```Lua
  promise:isPending()   -- true while future is computing, false if future completed.
  promise:isFulfilled() -- true if future completed and returned value.
  promise:isBroken()    -- true if future completed and did not return value.
  promise:result()      -- returns the future's result if it exists; otherwise, returns nil.
```

Or, instead of monitoring, you can set a callback which gets called after the future completes execution
```Lua
  future(computeY, 3):callback(print)
```
In this setup: when the computeY future is finished, print is called with the result (as the first argument to print)
```
  6.2
```

Another example, in which arguments are given to the callback (with "Hello World!" as the second argument to print)
```Lua
  future(computeY, 3):callback(print, "Hello World!")
```
Which similarly prints
```
  6.2   Hello World!
```

Or with the syntactic sugar of Future2
```Lua
  local future = require('luajfutures/Future2')
  
  future(computeY, 3)(print, "Hello World!")
```
