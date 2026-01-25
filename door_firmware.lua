local PASSWORD = "secret"
local DOOR_SIDE = "back"
local TIMEOUT = 10

local function showPrompt()
    term.clear()
    term.setCursorPos(1, 1)
    print("=== Jamies Super Secure Terminal ===")
    print("")
    print("Enter password:")
    write("> ")
end

showPrompt()
local input = read("*")

if input == PASSWORD then
    print("Access granted!")
    redstone.setOutput(DOOR_SIDE, true)

    sleep(TIMEOUT)

    redstone.setOutput(DOOR_SIDE, false)
    print("Door closed.")
    sleep(1)
else
    print("Access denied!")
    sleep(1)
end