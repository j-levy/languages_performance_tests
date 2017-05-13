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


-- Logging of every filename created
logs = {}

print("Switch state : "..gpio.read(5))
print("Launch server...")
dofile("AP_server.lua")
print("Server launched.")
-- print("Launching headless logged measure...")
-- dofile("measure_headless.lua")


