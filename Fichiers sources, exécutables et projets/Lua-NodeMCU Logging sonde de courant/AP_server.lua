
-- Créer un serveur sur connexion TCP.
srv = net.createServer(net.TCP) 
srv:listen(80,function(conn)   
 
conn:on("receive",function(conn,payload) 
    print("payload : \n"..payload)
    -- récupérer les liste des fichiers pour trouver un fichier à afficher
    l = file.list()
    sending = nil
    sending_size = 0
    file_found = false
    DataToGet = 0
    
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
        elseif string.find(line, "&duplicate_file") then
            dofile("duplicate_file.lua")
        end
        
        --afficher un fichier
        if string.find(line, "GET /") then   
            -- trouver le fichier à afficher
            
            for name, size in pairs(l) do
                if string.find(line, "GET /"..name) then
                    print("Give : "..name..", size : "..size)
                    DataToGet = size
                    sending_size = size
                    file_found = true
                    sending = name
                    
                    -- on ouvre le fichier et on commence à le lire pour l'envoyer
                    file.open(name, "r")                   
                    s = file.read(1400)
                    DataToGet = DataToGet - 1400
                    file.close()
                    if s then
                        conn:send(s)
                    else
                        conn:send("Fichier créé mais vide.")
                    end
                    
                    break -- ne pas tester les autres fichiers
                end
            end
            
			
            -- si on demande la liste des mesures, on génère une page sur mesure
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
                -- génération des liens pour accéder aux fichiers mesures. On cherche tous les fichiers contenant "meas_" dans leur nom.
                -- Ces fichiers sont ajoutés dans une liste HTML avec un lien vers eux.
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
                break --ne pas lire le payload plus loin. On gagne du temps.
            else
            	-- si on n'a rien trouvé à afficher, rediriger vers la page d'accueil. Crée une mini-page contenant une redirection vers index.html.
                conn:send("<!DOCTYPE html><html><head><meta http-equiv=\"refresh\" content=\"1;URL=/index.html\"></head><body></body></html>")
            end
        end
        break
    end
    
    -- Callback function pour envoyer des fichiers de grande taille, appelée lors d'un envoi de données réussi.
    -- Cette fonction est donc appelée à chaque fois qu'un paquet de données à été envoyé.
    -- Pour le dernier envoi, la condition interne spécifiera que rien ne doit être envoyé à nouveau.
    conn:on("sent",function(conn) 
    if file_found and sending and DataToGet > 0 then
        
        if file.open(sending, "r") then          
            file.seek("set", sending_size - DataToGet)
            local line=file.read(1400)
            DataToGet = DataToGet - 1400
            file.close()
            if line then
                conn:send(line)
                if (string.len(line)==1400) then
                    return
                end
            end
        end        
        
    end

    conn:close()
    end)
end)
end)
