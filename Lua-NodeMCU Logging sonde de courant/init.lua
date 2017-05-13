 --init.lua

-- Configure AP
wifi.setmode(wifi.STATIONAP)
cfg={}
cfg.ssid="ESP8266"
cfg.pwd="WeMosD1mini"
wifi.ap.config(cfg)

-- Pin config

adc.force_init_mode(adc.INIT_ADC)


gpio.mode(6,gpio.OUTPUT)
gpio.mode(5,gpio.INPUT,gpio.PULLUP)

gpio.write(6,gpio.HIGH)

print(gpio.read(5))
dofile("example_i2cLCD.lua")
