 --init.lua

-- Configure AP
wifi.setmode(wifi.STATIONAP)
cfg={}
cfg.ssid="ESP8266"
cfg.pwd="WeMosD1mini"
wifi.ap.config(cfg)


local lcd = require("i2clcdpcf")

lcd.begin(3, 4) --D3, D4
lcd.setBacklight(1)
lcd.setCursor(0,0)
lcd.print("SSID : "..cfg.ssid)
lcd.setCursor(0,1)
lcd.print("IP : "..wifi.ap.getip())
lcd.setCursor(0,2)
lcd.print("Acceder a index.html")

-- Pin config for ADC measure
adc.force_init_mode(adc.INIT_ADC)

-- Pin config for switch polling
gpio.mode(6,gpio.OUTPUT)
gpio.mode(5,gpio.INPUT,gpio.PULLUP)

gpio.write(6,gpio.HIGH)


-- controler les accès avec des globales
tmr_measure = tmr.create()
flag_stop = false

-- Lancement de l'application
print("Switch state : "..gpio.read(5))
print("Please launch a server...")
local server = "AP_server_plusplus.lua"
dofile(server)
print("Server "..server.." launched")
