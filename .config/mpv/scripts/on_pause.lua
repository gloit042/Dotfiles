fullscreen = mp.get_property("fullscreen") == "yes"
pause_change = false

function on_pause_change(name, value)
    mp.msg.log("info", "pause change")
    if value and fullscreen then
        pause_change = true
        mp.set_property("fullscreen", "no")
    elseif fullscreen ~= (mp.get_property("fullscreen") == "yes") then
        pause_change = true
        mp.set_property("fullscreen", "yes")
    end
end

function on_fullscreen_change(name, value)
    mp.msg.log("info", "fullscreen change, pause_change:", pause_change)
    if not pause_change then
        fullscreen = value == "yes"
    else
        pause_change = false
    end
end

mp.observe_property("fullscreen", "string", on_fullscreen_change)
mp.observe_property("pause", "bool", on_pause_change)
