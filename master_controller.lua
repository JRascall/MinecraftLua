-- Central Controller
-- Master control panel that can command any feature controller

local CHANNEL = 100

local modem = peripheral.find("modem")
if not modem then
    print("No modem found!")
    return
end
modem.open(CHANNEL)

-- Register all your features here
local features = {
    { name = "Front Door", target = "front_door" },
    { name = "Back Door", target = "back_door" },
    { name = "Lights", target = "lights" },
    { name = "Vault", target = "vault" },
    -- Add more as needed
}

local function sendCommand(target, action)
    modem.transmit(CHANNEL, CHANNEL, { target = target, action = action })
end

local function drawMenu()
    term.clear()
    term.setCursorPos(1, 1)
    print("=== CENTRAL CONTROL ===")
    print("")
    for i, feature in ipairs(features) do
        print(i .. ". " .. feature.name)
    end
    print("")
    print("Enter number to toggle")
    print("Or: [num] on / [num] off")
    print("'q' to quit")
    print("")
    write("> ")
end

while true do
    drawMenu()
    local input = read()

    if input == "q" then
        break
    end

    -- Parse input: "1" or "1 on" or "1 off"
    local parts = {}
    for part in input:gmatch("%S+") do
        table.insert(parts, part)
    end

    local choice = tonumber(parts[1])
    local action = parts[2] or "toggle"

    if choice and features[choice] then
        local feature = features[choice]
        print("Sending " .. action .. " to " .. feature.name)
        sendCommand(feature.target, action)
        sleep(0.5)
    else
        print("Invalid!")
        sleep(1)
    end
end

print("Shut down.")
