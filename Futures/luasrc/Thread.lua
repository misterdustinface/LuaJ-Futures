function Thread(runnable)
	local runner = luajava.createProxy("java.lang.Runnable", {
        run = runnable,
    })
	local thread = luajava.newInstance("java.lang.Thread", runner)
	return thread
end