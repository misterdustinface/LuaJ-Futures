## LuaJ Futures

What are [futures and promises](https://en.wikipedia.org/wiki/Futures_and_promises)?

##### 
0. [What does this library do?](#what-this-library-does)
1. [Why are futures useful?](#why-futures-are-useful)
2. [When should you use futures?](#you-should-use-futures-for)
3. [How do I use this library?](#how-to-use-this-library)

## What this library does
  This library allows you to create an asyncronous/concurrent process called a "future".  
  The result of this future can be monitored with a "promise";  
  or, you can just set a callback function for the future to call when it has completed it's task.

  This library implements "eager" futures - where computation starts as soon as the future is created.  
  These futures run in dynamically created threads.
  
  Futures and Promises are confusing - mostly because they have a variety of implementations.  
  This library is no exception to that rule.  
  My primary focus was to make a simple and accessible asynchronous/concurrent function dispatcher.
  For those who do not approve of my incorrect usage of the keywords "future" and "promise",  
  I shall remind you that you are not bounded to my vocabulary, for you can define the names of your own variables.  
  Furthermore, I am willing to update my vocabularly, so please inform me of more suitable word usage.

## Why futures are useful
  Futures are practical for delegating tasks, but they are especially suited for delegating lengthy tasks.  
  Essentially you can run some process in the background and worry about it's return value later.

## You should use futures for
  - Loading pictures, video, or sound within a menu
  - Loading a level of a video game, or some feature of that level
  - Loading anything
  - Lengthy computation

## How to use this library

First include the library
```Lua
  local future = require('luajfutures/Future')
```

Then define your function of interest such that is has one return value
```Lua
  -- Imagine that this function is more complex and slow. (:
  local function computeY(x)
    local y = x/3 + 5.2
    return y
  end
```

Then run the function as a future, followed by any arguments you wish to pass to the function
```Lua
  local promise = future(computeY, 3)
```

A future returns a promise which can be monitored with the following:
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

An example with arguments passed to the callback (uses "Hello World!" as the second argument to print)
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
