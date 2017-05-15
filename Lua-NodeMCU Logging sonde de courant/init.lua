 --init.lua

-- Configure AP
wifi.setmode(wifi.STATIONAP)
cfg={}
cfg.ssid="ESP8266"
cfg.pwd="WeMosD1mini"
wifi.ap.config(cfg)

-- Pin config for ADC measure
adc.force_init_mode(adc.INIT_ADC)

-- Pin config for switch polling
gpio.mode(6,gpio.OUTPUT)
gpio.mode(5,gpio.INPUT,gpio.PULLUP)

gpio.write(6,gpio.HIGH)


-- global values to control access
tmr_measure = tmr.create()
flag_stop = false

-- Lancement de l'application
print("Switch state : "..gpio.read(5))
print("Please launch a server...")
local server = "AP_server_plusplus.lua"
dofile(server)
print("Server "..server.." launched")
