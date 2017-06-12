
-- On liste tous les fichiers stockés
l = file.list()
-- Le résultat est donné sous forme de paires Clé-Valeurs (Key-Values d'où les variables k,v)
for k,v in pairs(l) do
    print("name:"..k..", size:"..v)
    if string.find(k, "meas_") then -- si le nom contient "meas_"
        file.remove(k)
    end
end
