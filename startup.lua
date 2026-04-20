local BASE_URL = "https://raw.githubusercontent.com/JRascall/MinecraftLua/main/"

-- Label patterns -> scripts
local function getScript(label)
    -- Central control
    if label == "central" then
        return "master_controller.lua"
    end

    -- Door terminals (password outside, no password inside)
    if label:match("door") and label:match("_outside$") then
        return "doors/edge_terminal.lua"
    end
    if label:match("door") and label:match("_inside$") then
        return "doors/edge_terminal_inside.lua"
    end

    -- Light terminals (no password, just toggle)
    if label:match("light") and label:match("_switch$") then
        return "lights/edge_terminal.lua"
    end

    -- Door feature controller
    if label:match("door") then
        return "doors/feature_controller.lua"
    end

    -- Light feature controller
    if label:match("light") then
        return "lights/feature_controller.lua"
    end

    -- Unknown type
    return nil
end

local label = os.getComputerLabel()

if not label then
    term.clear()
    term.setCursorPos(1, 1)
    print("No label set!")
    print("")
    print("Set a label with:")
    print("  label set <name>")
    print("")
    print("Label patterns:")
    print("  *door*          -> door controller")
    print("  *door*_outside  -> door terminal (pass)")
    print("  *door*_inside   -> door terminal (open)")
    print("  *light*         -> light controller")
    print("  *light*_switch  -> light switch")
    print("  central         -> master control")
    print("")
    print("Examples:")
    print("  front_door")
    print("  front_door_outside")
    print("  front_door_inside")
    print("  main_lights")
    print("  main_lights_switch")
    return
end

local script = getScript(label)

if not script then
    term.clear()
    term.setCursorPos(1, 1)
    print("Unknown label type: " .. label)
    print("")
    print("Label must contain 'door', 'light',")
    print("end with '_outside', '_inside',")
    print("or be 'central'")
    return
end

local url = BASE_URL .. script

while true do
    print("Computer: " .. label)
    print("Fetching: " .. script)
    sleep(0.5)

    local res = http.get(url)
    if res then
        print("Download successful!")
        sleep(0.5)

        local code = res.readAll()
        res.close()

        local fn, err = load(code)
        if fn then
            print("Running...")
            sleep(0.5)
            fn()
        else
            print("Syntax error: " .. err)
            sleep(2)
        end
    else
        print("Download failed, retrying...")
    end
    sleep(2)
end
