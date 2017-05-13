local lcd = require("i2clcdpcf")

lcd.begin(3, 4) --D3, D4
lcd.setBacklight(1)
lcd.setCursor(0,0)
lcd.print("Pince amperemetrique")
lcd.setCursor(0,1)
lcd.print("Mesure en cours :")
lcd.setCursor(0,2)
lcd.print("Courant (A) : ")

measure = 0

switch_on = true
while switch_on do
    if gpio.read(5) == 1 then
        switch_on = false
    end
    
    measure = adc.read(0)
    measure = measure - 8
    measure = (measure/1024)*3.123/(0.100) --Mise à l'échelle (VDD=3.1V), puis 0.1V/A
    print_measure = (math.floor(measure*10000))/10000

    lcd.setCursor(0,3)
    lcd.print("      ") -- effacer les rémanences de la précédente valeur, 6 caractères
    lcd.setCursor(0,3)
    lcd.print(tostring(print_measure))
    
    print("Courant : "..print_measure.." A")
    tmr.delay(1000000) -- wait 1s
end
lcd.setCursor(0,1)
lcd.print("Mesure terminee !")
    


    