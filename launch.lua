--read coordinates and launch code

print("Input X")
vX = read()
print("Input Y")
vY = read()
print("Input Z")
vZ = read()
print("Input valid launch code")
code = read()

message = vX.." "..vY.." "..vZ.." "..code.." " -- concatenates the message for the splitStr function to split it later - modem.transmit only accepts string
modem = peripheral.find("modem")
if modem.isWireless() then
    modem.transmit(7787, 7787, message) --transmit message on channel 7787
else
    printError("Nie znaleziono bezprzewodowego modemu")
end
