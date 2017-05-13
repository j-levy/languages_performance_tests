-- open file in flash to log everything
local filename = "meas_"..tmr.time()..".txt"
table.insert(logs, filename)
log = file.open(filename, "a+") --append and read, create if needed



-- Open LCD
local lcd = require("i2clcdpcf")

lcd.begin(3, 4) --D3, D4
lcd.setBacklight(1)
lcd.setCursor(0,0)
lcd.print("Pince amperemetrique")
lcd.setCursor(0,2)
lcd.print("Courant (A) : ")
lcd.setCursor(0,1)
lcd.print("Mesure en cours :")

local measure = 0
local counter = 0
local delay = 500 --ms
local switch_on = true

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

    lcd.setCursor(0,3)
    lcd.print("      ") -- effacer les rémanences de la précédente valeur, 6 caractères
    lcd.setCursor(0,3)
    lcd.print(tostring(print_measure))
    
    

    -- logger
    if log then
      log:write(cjson.encode({time=counter*delay/1000,measure=print_measure}).."\n")
    end


    print("Courant : "..print_measure.." A") --debug, permet de voir dans la console
    
    counter = counter + 1
    tmr.delay(1000*delay) -- wait "delay" ms. tmr.delay(µs)
end

lcd.setCursor(0,1)
lcd.print("Mesure terminee !")

-- close file 

if log then
  tmr.delay(1000000) -- pause to display
  log:close()
end

    


    
