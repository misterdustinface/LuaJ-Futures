## LuaJ Futures

##### Index
0. [What](#what)
1. [How](#how)

## What
  - [What are Futures and Promises?](https://en.wikipedia.org/wiki/Futures_and_promises)
  - This library implements "eager" futures - where computation starts as soon as the future is created - which run in dynamically created threads.

## How

  - First, include the library
```Lua
  local future = require('luajfutures/Future')
```
  - Then, define some function
```Lua
  local function computeY(x)
    local y = x/3 + 5.2
    return y
  end
```

  - Note: There are a few variations of usage in this library
```Lua
  local promise = future(computeY)
```
