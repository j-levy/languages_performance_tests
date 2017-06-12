
-- On duplique le fichier contenant le code JavaScript afficheur de graphe
local ressource = file.open("JSON-like.html", "r")   
node.setcpufreq(160) -- astuce : l'ESP8266 peut être overclocké à 160MHz. C'est fait ici car l'opération est très longue !
local afficheur = file.open("afficheur.html", "w+") --Efface le fichier et l'ouvre en mode Read+Write
print("duplicate started.")

while true do
		-- lecture par petits paquets pour éviter de surcharger la mémoire dynamique (le tas, ou heap).
		-- Note : la mémoire de la NodeMCU est consultable à tout moment par la commande "node.heap()"
        s = ressource:read(1500)
        if s == nil then
            break
        end
        afficheur:write(s)
end
ressource:close()
afficheur:close()
-- Ici, le fichier afficheur.html contient tout le code HTML et JavaScript pour afficher un graphe. On y ajoute les points de mesure.
afficheur = file.open("afficheur.html", "a") -- mode ajout

local mes = file.open("last_measure.html") -- fichier de mesures en temps réel
while true do
        s = mes:read(1400)
        if s == nil then
            break
        end
        afficheur:write(s)
end
-- On rajoute à la fin du fichier le code nécessaire aux fermeture des balises et autres portions de JavaScript.
afficheur:write(" ]}]});chart.render();}</script></head><body><div id=\"chartContainer\" style=\"height: 100%; width: 100%;\"></div></body></html> ")
afficheur:close()
node.setcpufreq(80) -- on redescend à 80MHz.
print("duplicate ended.")
