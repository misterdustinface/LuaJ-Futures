## LuaJ Futures

##### Index
0. [What](#what)
1. [Why](#why)
2. [When](#when)
3. [How](#how)

## What
  - [What are Futures and Promises?](https://en.wikipedia.org/wiki/Futures_and_promises)
  - This library implements "eager" futures - where computation starts as soon as the future is created - which run in dynamically created threads.
  - Note: There are a few variations of usage in this library

## Why
  - Futures are useful for delegating tasks
  - Futures are especially useful for delegating lengthy tasks

## When
  - Loading
  - Loading pictures, video, or sound within a menu
  - Loading a level of a video game, or some feature of that level
  - Computation

## How

  - First, include the library
```Lua
  local future = require('luajfutures/Future')
```
  - Then, define some function, which should take some time to complete, and returns one value
```Lua
  local function computeY(x)
    local y = x/3 + 5.2
    return y
  end
```

  - Then run the function as a future, followed by any arguments you wish to pass to the function
```Lua
  local promise = future(computeY, 3)
```

  - Which returns a promise, which can be monitored with
```Lua
  promise:isPending()   -- true while promise is computing, false if promise completed.
  promise:isFulfilled() -- true if promise completed and returned value.
  promise:isBroken()    -- true if promise completed and did not return value.
  promise:result()      -- returns a computed promise result if it exists; otherwise, returns nil.
```
  - Or, instead of monitoring, you can set a callback which gets called after the future executes
```Lua
  future(computeY, 3):callback(print)
```
  - When the computeY future is finished, print is called with the result
```
  6.2
```

  - Another example, in which arguments are given to the callback
```Lua
  future(computeY, 3):callback(print, "Hello World!")
```
  - Which similarly prints
```
  6.2   Hello World!
```

  - Or similarly, using Future2
```Lua
  local future = require('luajfutures/Future2')
  
  future(computeY, 3)(print, "Hello World!")
```
  - Which similarly prints
```
  6.2   Hello World!
```
