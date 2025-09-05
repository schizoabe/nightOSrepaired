forkLiftMod = {
    playerPos = nil,
    controlledForkLift = nil,
    forward = 0,
    rollRotation = 0,
    ori = 0,
    deltaTime = 0,
    deltaTimeEffect = 0,
    xF = 0
}

function forkLiftMod.initMod()
    Game.GetPlayer().doesPlayerControlAForkLift = false
end

function forkLiftMod.distractTheEnemy(object)
    object:GetController():GetPS():ExecuteAction()
    object:GetStimBroadcasterComponent():TriggerSingleBroadcast(object, gamedataStimType.DeviceExplosion);
end

function forkLiftMod.setIsControlled(toggle, object)
    if toggle then
        if object:ToString() == "forklift" then
            if not forkLiftMod.doesPlayerControlAForkLift() then
                forkLiftMod.playerPos = Game.GetPlayer():GetWorldPosition()
                GameObjectEffectHelper.StartEffectEvent(Game.GetPlayer(), "transition_glitch_loop")
                forkLiftMod.controlledForkLift = object
                Game.GetPlayer().doesPlayerControlAForkLift = true
                forkLiftMod.setHUDVisibility(true)
                Game.GetPlayer():SetInvisible(true)
                GetSingleton('StatusEffectHelper'):ApplyStatusEffect(Game.GetPlayer(), "GameplayRestriction.NoCameraControl")
                Game.GetTeleportationFacility():Teleport(Game.GetPlayer(), Game.GetPlayer():GetWorldPosition(), EulerAngles.new(0,0,0))
                Game.GetPlayer():GetFPPCameraComponent():ResetPitch()
            end
        end
    else
        if forkLiftMod.doesPlayerControlAForkLift() then
            GameObjectEffectHelper.StartEffectEvent(Game.GetPlayer(), "transition_glitch_loop")
            Game.GetTeleportationFacility():Teleport(Game.GetPlayer(), forkLiftMod.playerPos, EulerAngles.new(0,0,Game.GetPlayer():GetWorldYaw()))
            Game.GetPlayer().doesPlayerControlAForkLift = false
            forkLiftMod.playerPos = nil
            forkLiftMod.setHUDVisibility(false)
            Game.GetPlayer():SetInvisible(false)
            GetSingleton('StatusEffectHelper'):RemoveStatusEffect(Game.GetPlayer(), "GameplayRestriction.NoCameraControl")
            Game.GetPlayer():GetFPPCameraComponent():SetLocalPosition(Vector4.new(0.0, 0.0, 0.0, 1.0))
            Game.GetPlayer():GetFPPCameraComponent():SetLocalOrientation(Quaternion.new(0.0, 0.0, 0.0, 1.0))
        end
    end
end

function forkLiftMod.setHUDVisibility(trigger)
    Game.GetPlayer().forceHideHealth = trigger
    Game.GetPlayer().forceHideMinimap = trigger
    Game.GetPlayer().forceHideQuest = trigger
    Game.GetPlayer().forceHideItem = trigger
    Game.GetPlayer().forceHideWidget = trigger
    Game.GetPlayer().forceShowHud = trigger
end

function forkLiftMod.setTextOfThings()
    Game.GetPlayer().ForkliftUserName = "User: " .. forkLiftMod.RandomVariable(12)
    Game.GetPlayer().ForkliftSignal = "Signal: " .. forkLiftMod.getSignal() .. "%"
    Game.GetPlayer().ForkliftEnergy = "Energy: " .. forkLiftMod.getForkLift().energy .. "%"
    if forkLiftMod.getForkLift():GetController():GetPS():IsForkliftUp() then Game.GetPlayer().ForkliftUp = "Is Lift Up: Yes" else Game.GetPlayer().ForkliftUp = "Is Lift Up: No" end
end


function forkLiftMod.RandomVariable(length)
	local res = ""
	for i = 1, length do
		res = res .. string.char(math.random(97, 122))
	end
	return res
end

function forkLiftMod.getCoordinaateDown(multiplier)
    diection = Game.GetPlayer():GetWorldUp()
    vector = Vector4.new(0,0,0,0)
    vector.x = (diection.x * multiplier * (-1))
    vector.y = (diection.y * multiplier * (-1))
    vector.z = (diection.z * multiplier * (-1))
    return vector
end

function forkLiftMod.getCoordinaateUp(multiplier, object)
    diection = object:GetWorldUp()
    diection2 = object:GetWorldForward()
    objectPos = object:GetWorldPosition()
    vector = Vector4.new(0,0,0,0)
    vector.x = objectPos.x + (diection.x * multiplier) + (diection2.x * 1.5)
    vector.y = objectPos.y + (diection.y * multiplier) + (diection2.y * 1.5)
    vector.z = objectPos.z + (diection.z * multiplier) + (diection2.z * 1.5)
    return vector
end

function vmv(from, to)
    return math.sqrt((to.x - from.x)^2 + (to.y - from.y)^2)
end

function forkLiftMod.getSignal()
    local signal = math.floor(250 / vmv(forkLiftMod.playerPos, forkLiftMod.controlledForkLift:GetWorldPosition()))

    if signal > 100 then
        signal = 100
    elseif signal < 0 then
        signal = 0
    end

    if (forkLiftMod.deltaTimeEffect > signal / 300) and signal < 50 then
        GameObjectEffectHelper.StartEffectEvent(Game.GetPlayer(), "transition_glitch_loop")
        forkLiftMod.deltaTimeEffect = 0
    end
    if (signal < 10) and (RandRange(0, 250) < 2)then
        forkLiftMod.setIsControlled(false, forkLiftMod.getForkLift())
    end
    return signal
end

function forkLiftMod.listener()
    Game.GetUISystem():QueueEvent(UpdateElementEvent.new())
    if forkLiftMod.doesPlayerControlAForkLift() then
        if (forkLiftMod.deltaTime > 0.1) then
            forkLiftMod.setTextOfThings()
            forkLiftMod.deltaTime = forkLiftMod.deltaTime - 0.1
        end
        forkLiftMod.tpCameraToForkLift()
        forkLiftMod.pos()
    end
end

function forkLiftMod.pos()
    if forkLiftMod.doesPlayerControlAForkLift() then
        diection = forkLiftMod.getForkLift():GetWorldForward()
        playerp = forkLiftMod.getForkLift():GetWorldPosition()

        vector = Vector4.new(0,0,0,0)

        vector.x = playerp.x + ((diection.x * forkLiftMod.forward) / 50)
        vector.y = playerp.y + ((diection.y * forkLiftMod.forward) / 50)
        vector.z = playerp.z + ((diection.z * forkLiftMod.forward) / 50)

        if Game.GetPlayer():checkForObjectInLine(forkLiftMod.getForkLift(), playerp, vector) == false then
            Game.GetTeleportationFacility():Teleport(forkLiftMod.getForkLift(), vector, EulerAngles.new(0,0,forkLiftMod.getForkLift():GetWorldYaw() + forkLiftMod.rollRotation * (-1)))
        end
    end
end

function forkLiftMod.tpCameraToForkLift()
    if forkLiftMod.doesPlayerControlAForkLift() then
        Game.GetTeleportationFacility():Teleport(Game.GetPlayer(), forkLiftMod.getCoordinaateUp(13, forkLiftMod.getForkLift()), EulerAngles.new(0,0,forkLiftMod.getForkLift():GetWorldYaw()))
        Game.GetPlayer():GetFPPCameraComponent():SetLocalOrientation(GetSingleton('EulerAngles').ToQuat(EulerAngles.new(0.00, -90.00, 00.00)))
        Game.GetPlayer():GetFPPCameraComponent():SetLocalPosition(forkLiftMod.getCoordinaateDown(2))
    end
end

function forkLiftMod.upDownForkLift(object)
    if forkLiftMod.doesPlayerControlAForkLift() then
        object:GetController():GetPS():ExecutePSAction(object:GetController():GetPS():ActionActivateDevice("Activate"))
    end
end

function forkLiftMod.getForkLift()
    return forkLiftMod.controlledForkLift
end

function forkLiftMod.doesPlayerControlAForkLift()
    return Game.GetPlayer().doesPlayerControlAForkLift
end

return forkLiftMod