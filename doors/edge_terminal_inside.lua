-- Door Edge Terminal (Inside)
-- No password - press any key to open

local CHANNEL = 100

local label = os.getComputerLabel() or "unknown"
local TARGET_FEATURE = label:match("^(.+)_inside$") or label
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
    print("Press any key to open")

    os.pullEvent("key")

    print("Opening...")
    sendCommand("toggle")
    sleep(2)
end
