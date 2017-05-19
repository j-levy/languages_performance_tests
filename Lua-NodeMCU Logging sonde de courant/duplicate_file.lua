local ressource = file.open("JSON-like.html", "r")   
node.setcpufreq(160)    
local afficheur = file.open("afficheur.html", "w+") --clear file, create if needed, Read+Write
print("duplicate started.")
while true do
        s = ressource:read(1500)
        if s == nil then
            break
        end
        afficheur:write(s)
end
ressource:close()
afficheur:close()
afficheur = file.open("afficheur.html", "a") --overwrite

--afficheur:seek('end', -269)
local mes = file.open("last_measure.html")
while true do
        s = mes:read(1400)
        if s == nil then
            break
        end
        afficheur:write(s)
end
afficheur:write(" ]}]});chart.render();}</script></head><body><div id=\"chartContainer\" style=\"height: 100%; width: 100%;\"></div></body></html> ")
afficheur:close()
node.setcpufreq(80)
print("duplicate ended.")
