

l = file.list()
for k,v in pairs(l) do
    print("name:"..k..", size:"..v)
    if string.find(k, "meas_") then
        file.remove(k)
    end
end
