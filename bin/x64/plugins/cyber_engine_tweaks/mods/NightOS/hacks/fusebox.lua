fuseboxMod = {}

function fuseboxMod.startLight()
    local scriptSystem =  Game.GetScriptableSystemsContainer()
    local ct = scriptSystem:Get('CityLightSystem')
    if ct:GetState().value == "ForcedON" or ct:GetState().value == "DEFAULT" then
        ct:AddForcedStateRequest("ForcedOFF", "DEBUG", "Absolute", false)
        ct.state = 2
    elseif ct:GetState().value == "ForcedOFF" then
        ct:AddForcedStateRequest("ForcedON", "DEBUG", "Absolute", false)
        ct.state = 1
    end
    ct:UpdateCLSForcedState()
end

function fuseboxMod.LightToOne(a)
    local scriptSystem =  Game.GetScriptableSystemsContainer()
    local ct = scriptSystem:Get('CityLightSystem')
    if a == 2 then
        ct:AddForcedStateRequest("ForcedOFF", "DEBUG", "Absolute", false)
    elseif a == 1 then
        ct:AddForcedStateRequest("ForcedON", "DEBUG", "Absolute", false)
    end
    ct.state = a
    ct:UpdateCLSForcedState()
end

function fuseboxMod.distractTheEnemy(object)
    object:GetStimBroadcasterComponent():TriggerSingleBroadcast(object, gamedataStimType.DeviceExplosion);
end

return fuseboxMod