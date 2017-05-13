

-- Create server
srv = net.createServer(net.TCP) 
srv:listen(80,function(conn)   
 
conn:on("receive",function(conn,payload) 
    print("payload : \n"..payload)

    for line in string.gmatch(payload,'[^\r\n]+') do
        if string.find(line, "&measure_headless") then
            dofile("measure_headless.lua")
        end
        if string.find(line, "&measure_LCD") then
            dofile("measure_LCD.lua")
        end        
        
        
       
        if string.find(line, "GET /index.html") then
            file.open("index.html", "r")
            while true do
                s = file.read(1460)
                if s == nil then
                    break
                end
                conn:send(s)
            end
            file.close()
        elseif string.find(line, "GET /ESP8266.jpg") then
            file.open("ESP8266.jpg", "r")
            while true do
                s = file.read(100)
                if s == nil then
                    break
                end
                conn:send(s)
            end
            file.close()
        else
            conn:send("NO PAGE FOUND.") 
        end
        break
    end
    conn:on("sent", function(conn) conn:close() end)
end)
end)
