--measure_headless.lua


local function acquisition()  
 
    if gpio.read(5) == 1 or flag_stop then
        flag_stop=false --rearmement
        tmr_measure:unregister()
        tmr_measure:stop()
        print("Mesure terminee !")
        log:close()
        

        -- copier dans un autre fichier
        log = file.open("last_measure.html", "a+")        
        local final_log = file.open(filename, "w+") --clear file, create if needed, Read+Write
        
        while true do
                s = log:read(1460)
                if s == nil then
                    break
                end
                final_log:write(s)
        end
        
        log:close()
        final_log:close()
        dofile("duplicate_file.lua")
        return

    end
    
    measure = adc.read(0)
    measure = measure - 8
    measure = 12*(measure/1024)*3.123/(0.100) --Mise à l'echelle (VDD=3.1V), puis 0.1V/A
    print_measure = (math.floor(measure*10000))/10000 -- arrondi pour éviter les soucis d'affichage
    
    -- logger
    if log then
      log:write(cjson.encode({x=counter*delay/1000 , y=print_measure})..",\n")
    end


    print("Courant : "..print_measure.." A") --debug, permet de voir dans la console
    
    counter = counter + 1
end




running, mode = tmr_measure:state()

if running then
    print("mesure déjà lancée")
else
        -- open file in flash:
    filename = "meas_"..tmr.time()..".txt"
    
    log = file.open("last_measure.html", "w+") --clear file, create if needed, Read+Write
    
    measure = 0
    counter = 0
    delay = 1000 --ms
    
    if log then
      --log:write(cjson.encode({filename=filename}).."\n")
    else
      print("Fichier non disponible")
    end
    
    tmr_measure:register(delay, tmr.ALARM_AUTO, function() acquisition() end )
    tmr_measure:start()
end

