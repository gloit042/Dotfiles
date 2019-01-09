local utils = require 'mp.utils'

if mp.get_property_bool("option-info/vo/set-from-commandline") == true then
    return
end

poweroff = true

function check_power()
    t = {}
    t.args = {"WMIC", "Path", "Win32_Battery", "Get", "BatteryStatus"}

    res = utils.subprocess(t)

    power_status = string.match(res.stdout, "1")

    if power_status ~= poweroff then
        poweroff = power_status
        if poweroff then
            mp.commandv("apply-profile", "poweroff")
        else
            mp.commandv("apply-profile", "poweron")
        end
    end

end


timer = mp.add_periodic_timer(1, check_power)

check_power()


