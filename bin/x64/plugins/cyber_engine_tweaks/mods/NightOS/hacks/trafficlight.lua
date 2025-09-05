TrafficLightMod = {}


function TrafficLightMod.ChangeLight(object, light)
    if light == "red" then
        object:HandleRedLight(true)
        object:HandleGreenLight(false)
        object:HandleYellowLight(false)
        object.lightState = worldTrafficLightColor.RED
    elseif light == "green" then
        object:HandleGreenLight(true)
        object:HandleYellowLight(false)
        object:HandleRedLight(false)
        object.lightState = worldTrafficLightColor.GREEN
    elseif light == "yellow" then
        object:HandleYellowLight(true)
        object:HandleRedLight(false)
        object:HandleGreenLight(false)
        object.lightState = worldTrafficLightColor.YELLOW
    end
end

function TrafficLightMod.OnOff(object)
    if object.onOffOneExec == false then
        if object:GetDevicePS():IsON() then
            object:TurnOffDevice()
        else
            object:TurnOnDevice()
        end
        object.onOffOneExec = true
    end
end

function TrafficLightMod.ChooseRandomLight()
    randomNumb = math.random(0,2)
    if randomNumb == 0 then
        return "red"
    elseif randomNumb == 1 then
        return "green"
    elseif randomNumb == 2 then
        return "yellow"
    end
end

return TrafficLightMod