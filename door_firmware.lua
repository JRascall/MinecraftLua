local PASSWORD = "secret"

term.clear()
term.setCursorPos(1, 1)
print("=== Jamies Super Secure Terminal ===")
print("")
print("Enter password:")
write("> ")

local input = read("*")

if input == PASSWORD then
    print("Access granted!")
    
    local doorState = redstone.getOutput("back")
    redstone.setOutput("back", not doorState)
    sleep(2)
else
    print("Access denied!")
    sleep(1)
end