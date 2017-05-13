--measure_headless.lua
-- open file in flash:
local filename = "meas_"..tmr.time()..".txt"
table.insert(logs, filename)
log = file.open(filename, "a+") --append and read, create if needed

switch_on = true

local measure = 0
local counter = 0
local delay = 1000 --ms

if log then
  log:write(cjson.encode({filename=filename,delay=delay}).."\n")
else
  print("File unavailable")
end

while switch_on do

    if gpio.read(5) == 1 then
        switch_on = false
    end
    
    measure = adc.read(0)
    measure = measure - 8
    measure = (measure/1024)*3.123/(0.100) --Mise à l'échelle (VDD=3.1V), puis 0.1V/A
    print_measure = (math.floor(measure*10000))/10000 -- arrondi pour éviter les soucis d'affichage


    -- logger
    if log then
      log:write(cjson.encode({time=counter*delay/1000,measure=print_measure}).."\n")
    end


    print("Courant : "..print_measure.." A") --debug, permet de voir dans la console
    
    counter = counter + 1
    tmr.delay(1000*delay) -- wait "delay" ms. tmr.delay(µs)
end

print("Mesure terminee !")

tmr.delay(1000000) -- pause to display
log:close()


    


    
