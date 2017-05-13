for i, v in ipairs(logs) do 
    print(i, v)
    file.remove(v)
end
for i,v in ipairs(logs) do
    table.remove(logs,i)
end