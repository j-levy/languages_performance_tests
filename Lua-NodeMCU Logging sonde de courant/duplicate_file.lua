log = file.open("JSON.html", "r")   
node.setcpufreq(160)    
local final_log = file.open("afficheur.html", "w+") --clear file, create if needed, Read+Write
print("duplicate started.")
while true do
        s = log:read(6000)
        if s == nil then
            break
        end
        final_log:write(s)
end
log:close()
final_log:close()
node.setcpufreq(80)
print("duplicate ended.")