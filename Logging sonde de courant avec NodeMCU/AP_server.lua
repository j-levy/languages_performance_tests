

-- Create server
srv = net.createServer(net.TCP) 
srv:listen(80,function(conn)    
conn:on("receive",function(conn,payload) 
    print("payload : \n"..payload)

    for line in string.gmatch(payload,'[^\r\n]+') do
        s = string.find(line, "GET /&")
        print(s)
        -- If query is there, control robot
        
       
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
        elseif string.find(line, "GET /bob.html") then
            file.open("bob.html", "r")
            while true do
                s = file.read(1460)
                if s == nil then
                    break
                end
                conn:send(s)
            end
            file.close()
        else
            conn:send("NO PAGE FOUND.")
            i = 0
            for i=1, 5 do
                conn:send("STILL NO PAGE AFTER "..i.."TRIES.")
                time = tmr.now
                while tmr.now < time+1000000 do
                end
            end  
        end
        break
    end
    conn:on("sent", function(conn) conn:close() end)
end)
end)
