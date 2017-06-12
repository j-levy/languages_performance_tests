 --init.lua

-- Configurer le point d'accès AP
wifi.setmode(wifi.STATIONAP)
cfg={}
cfg.ssid="ESP8266-point-acces"
cfg.pwd="password_8266_agregation2017"
wifi.ap.config(cfg)


tmr.alarm(0, 1000, 1, function() 
   if wifi.sta.getip()==nil then
      print("connecting to AP...") 
   else
      print('ip: ',wifi.sta.getip())
      tmr.stop(0)
      continue();
   end
end)


function continue()

local lcd = require("i2clcdpcf")

lcd.begin(3, 4) --Correspond aux broches D3, D4 pour SCL et SDA en I2C
lcd.setBacklight(1)
lcd.setCursor(0,0)
lcd.print("SSID : "..cfg.ssid)
lcd.setCursor(0,1)
lcd.print("IP : "..wifi.sta.getip())
lcd.setCursor(0,2)
lcd.print("Acceder a index.html")

-- Configuration de la broche A0 pour CAN 
adc.force_init_mode(adc.INIT_ADC)

-- Configuration des broches 5 et 6 pour scrutation d'interrupteur
-- Cet interrupteur était à l'origine présent comme arrêt d'urgence de mesure.
gpio.mode(6,gpio.OUTPUT)
gpio.mode(5,gpio.INPUT,gpio.PULLUP)

gpio.write(6,gpio.HIGH)


-- controler les accès avec des variables globales
tmr_measure = tmr.create()
flag_stop = false

-- Lancement de l'application
print("Etat de l'interrupteur d'arret d'urgence : "..gpio.read(5))
print("Lancement du programme serveur...")
local server = "AP_server.lua"
dofile(server)
print("Serveur "..server.." lancé.")

end
