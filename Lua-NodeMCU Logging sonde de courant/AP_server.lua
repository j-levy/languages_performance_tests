

-- Create server
srv = net.createServer(net.TCP) 
srv:listen(80,function(conn)   
 
conn:on("receive",function(conn,payload) 
    print("payload : \n"..payload)
    -- récupérer les liste des fichiers. Pour trouver un fichier à afficher
    l = file.list()
    
    for line in string.gmatch(payload,'[^\r\n]+') do
        -- actions par lancement de scripts
        if string.find(line, "&measure_headless") then
            dofile("measure_headless.lua")
        elseif string.find(line, "&measure_LCD") then
            dofile("measure_LCD.lua")  
        elseif string.find(line, "&clear_logs") then
            dofile("clear_logs.lua")
        elseif string.find(line, "&measure_stop") then
            flag_stop = true
        end
        --afficher un fichier
        if string.find(line, "GET /") then   
            -- trouver le fichier à afficher
            local file_found = false
            
            for name, size in pairs(l) do
                if string.find(line, "GET /"..name) then
                    file_found = true
                    file.open(name, "r")
                    --while true do
                        s = file.read(1400)
                        file.close()
                        if s == nil then
                            break
                        end
                        conn:send(s)
                        
                    --end
                    
                    break -- ne pas tester les autres fichiers
                end
            end

            
            if string.find(line, "GET /measure_list.html") then
                file_found = true
                l = file.list()
                buf = [[<!doctype html>
                <html lang="fr">
                  <head>
                    <title>Lecture de sonde de courant</title>
                    <meta charset="UTF-8">
                  </head>
                  <body bgcolor=white>
                  <p>Voir les mesures enregistrées :
                <ul>
                ]]
                for name, size in pairs(l) do
                    if string.find(name, "meas_") then
                        buf = buf.."<li> <a href=\""..name.."\">"..name.."</a>"
                    end
                end
                buf = buf.."</ul></body></html>"
                conn:send(buf)
                collectgarbage()
            end
            
            if file_found then
                break --ne pas lire le payload plus loin
            else
                conn:send("404 : Page not found.")
            end
        end
        break
    end
    conn:on("sent",function(conn) 
    if file_found then
        
        if file.open(file_name_to_send, "r") then          
            file.seek("set", DataToGet)
            local line=file.read(512)
            file.close()
            if line then
                conn:send(line)
                DataToGet = DataToGet + 512    

                if (string.len(line)==512) then
                    return
                end
            end
        end        
    end

    conn:close() 
    end)
end)
end)
