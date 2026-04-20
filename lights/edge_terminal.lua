-- Light Edge Terminal
-- No password - just press any key to toggle lights

local CHANNEL = 100

local label = os.getComputerLabel() or "unknown"
local TARGET_FEATURE = label:match("^(.+)_outside$") or label:match("^(.+)_inside$") or label
local LIGHT_NAME = TARGET_FEATURE:gsub("_", " "):gsub("(%l)(%w*)", function(a,b) return string.upper(a)..b end)

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
    print("=== " .. LIGHT_NAME .. " ===")
    print("")
    print("Press any key to toggle")

    os.pullEvent("key")

    print("Toggling...")
    sendCommand("toggle")
    sleep(1)
end
