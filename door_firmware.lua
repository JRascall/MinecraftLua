local PASSWORD = "secret"

term.clear()
term.setCursorPos(1, 1)
print("=== Secure Terminal ===")
print("")
print("Enter password:")
write("> ")

local input = read("*")

if input == PASSWORD then
    print("Access granted!")
    
    local state = redstone.getOutput("back")
    redstone.setOutput("back", not state)
    
    print("Redstone: " .. (not state and "ON" or "OFF"))
    sleep(2)
else
    print("Access denied!")
    sleep(1)
end