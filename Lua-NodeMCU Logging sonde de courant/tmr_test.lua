mytimer = tmr.create()
mytimer:register(5000, tmr.ALARM_AUTO, function() print("hey there") end)
mytimer:start()