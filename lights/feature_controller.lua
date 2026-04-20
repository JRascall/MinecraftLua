-- Light Feature Controller
-- Toggles on/off and stays in that state

local CHANNEL = 100
local DEVICE_NAME = os.getComputerLabel() or "unknown"
local OUTPUT_SIDE = "back"

local modem = peripheral.find("modem")
if not modem then
    print("No modem found!")
    return
end
modem.open(CHANNEL)

local isOn = false

local function setLight(state)
    isOn = state
    redstone.setOutput(OUTPUT_SIDE, isOn)
    print("Lights " .. (isOn and "ON" or "OFF"))
end

term.clear()
term.setCursorPos(1, 1)
print("Light Controller: " .. DEVICE_NAME)
print("Output: " .. OUTPUT_SIDE)
print("")
print("Waiting for commands...")

while true do
    local event, side, channel, reply, msg = os.pullEvent("modem_message")

    if type(msg) == "table" and msg.target == DEVICE_NAME then
        print("Received: " .. (msg.action or "unknown"))
        if msg.action == "toggle" then
            setLight(not isOn)
        elseif msg.action == "on" then
            setLight(true)
        elseif msg.action == "off" then
            setLight(false)
        end
    end
end
