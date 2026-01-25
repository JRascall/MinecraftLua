local url = "https://raw.githubusercontent.com/JRascall/MinecraftLua/main/door_firmware.lua"

while true do
    print("Fetching firmware...")
    sleep(1)

    local res = http.get(url)
    if res then
        print("Download successful!")
        sleep(0.5)

        local code = res.readAll()
        res.close()

        print("Loading firmware...")
        sleep(0.5)

        local fn, err = load(code)
        if fn then
            print("Running firmware...")
            sleep(0.5)
            fn()
        else
            print("Syntax error: " .. err)
            sleep(2)
        end
    else
        print("Download failed, retrying...")
        sleep(2)
    end
    sleep(2)
end
