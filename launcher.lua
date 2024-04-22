network = peripheral.getNames() -- get all peripherals
launchers = {} 

code_B = "&y6M#G5KKN*8oc9#5nEU3^2H^"
code_M = "&!gv2@sGFuT2A52@%5Gru2X38"
code_N = "w5V#$@kQM7723^bK&QL98$!7@"

for i=1,#network do --get every silocontroller on the wired network
    network[i] = peripheral.wrap(network[i])
    if peripheral.getType(network[i]) == "silocontroller" then
        table.insert(launchers, peripheral.getName(network[i]))
    end
end

function splitStr(input, separator) -- separator for the string message
    if sep == nil then
        sep = "%s"
    end
    local retValue = {}
    for str in string.gmatch(input, "%S+ ") do
        table.insert(retValue, str)
        -- print("String: "..str) 
    end
    return retValue
end

function launch(x, y, z) -- launch 5 missiles from 5 separate launchers
    for i=1, #launchers do
        if i == 1 then
            peripheral.call(launchers[i], "launchWithPosition", x, y, z)
        elseif i == 2 then
            peripheral.call(launchers[i], "launchWithPosition", x+45, y, z+45)
        elseif i == 3 then
            peripheral.call(launchers[i], "launchWithPosition", x-45, y, z+45)
        elseif i == 4 then
            peripheral.call(launchers[i], "launchWithPosition", x+45, y, z-45)
        elseif i == 5 then
            peripheral.call(launchers[i], "launchWithPosition", x-45, y, z-45)
        end
    end
end
 
local modem = peripheral.find("modem") --find a wireless modem
if modem.isWireless() then
   modem.open(7787)
    local event, side, channel, replyChannel, message, distance -- initialize every modem_message argument 
    while true do
        repeat -- pull messages from every modem channel
            event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
        until channel == 7787
        values = splitStr(message) -- split message
        if (values[4] == code_B.." ") or (values[4] == code_M.." ") or (values[4] == code_N ) then --check every code, if true - launch the missiles, else: Abort
            launch(tonumber(values[1]), tonumber(values[2]), tonumber(values[3]))
        else
            printError("ERROR - INCORRECT CODE - ABORTING ")
        end
   end
else
printError("NO WIRELESS MODEM FOUND")
end
