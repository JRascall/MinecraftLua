-- Door Feature Controller
-- Opens for a duration then closes automatically (pulse mode)

local CHANNEL = 100
local DEVICE_NAME = os.getComputerLabel() or "unknown"
local OUTPUT_SIDE = "back"
local OPEN_DURATION = 10  -- How long door stays open

local modem = peripheral.find("modem")
if not modem then
    print("No modem found!")
    return
end
modem.open(CHANNEL)

local function openDoor()
    print("Opening door...")
    redstone.setOutput(OUTPUT_SIDE, true)
    sleep(OPEN_DURATION)
    redstone.setOutput(OUTPUT_SIDE, false)
    print("Door closed.")
end

term.clear()
term.setCursorPos(1, 1)
print("Door Controller: " .. DEVICE_NAME)
print("Output: " .. OUTPUT_SIDE)
print("Duration: " .. OPEN_DURATION .. "s")
print("")
print("Waiting for commands...")

while true do
    local event, side, channel, reply, msg = os.pullEvent("modem_message")

    if type(msg) == "table" and msg.target == DEVICE_NAME then
        print("Received: " .. (msg.action or "unknown"))
        if msg.action == "toggle" or msg.action == "on" then
            openDoor()
        end
    end
end
