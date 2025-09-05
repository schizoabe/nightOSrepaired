tvMod = {
    isOn = true
}

function tvMod.getMaxChannelCount(object)
    local i = 0
    for _, v in ipairs(object:GetGlobalTVChannels()) do
        i = i + 1
    end
    return i
end

function tvMod.getChannel(object)
    return object:GetBlackboard():GetInt(GetAllBlackboardDefs().TVDeviceBlackboard.CurrentChannel)
end

function tvMod.turnOff(object)
    object:TurnOffDevice()
end

function tvMod.turnOn(object)
    object:TurnOnDevice()
end

function tvMod.glitch(object)
    object:StartGlitching(EGlitchState.DEFAULT, 1.00)
end

function tvMod.noGlitch(object)
    object:StopGlitching()
end

function tvMod.nextChannel(object)
    local dps = object:GetDevicePS()
    local ps = Game.GetPersistencySystem()
    ps:QueuePSDeviceEvent(dps:ActionNextStation())
    Game.GetAudioSystem():Play("ui_menu_mouse_click")
end

return tvMod
