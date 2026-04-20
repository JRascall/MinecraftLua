-- Door Edge Terminal (Outside)
-- Password required to open door

local CHANNEL = 100
local PASSWORD = "secret"

local label = os.getComputerLabel() or "unknown"
local TARGET_FEATURE = label:match("^(.+)_outside$") or label
local DOOR_NAME = TARGET_FEATURE:gsub("_", " "):gsub("(%l)(%w*)", function(a,b) return string.upper(a)..b end)

local modem = peripheral.find("modem")
if not modem then
    print("No modem found!")
    return
end
modem.open(CHANNEL)

local function sendCommand(action)
    modem.transmit(CHANNEL, CHANNEL, { target = TARGET_FEATURE, action = action })
end

while true do
    term.clear()
    term.setCursorPos(1, 1)
    print("=== " .. DOOR_NAME .. " ===")
    print("")
    print("Enter password:")
    write("> ")

    local input = read("*")

    if input == PASSWORD then
        print("Access granted!")
        sendCommand("toggle")
        sleep(2)
    else
        print("Access denied!")
        sleep(1)
    end
end
