droneMod = {
    otherLibs = require("lib/otherShits"),
    controlledDrone = nil,
    playerOrientation = nil,
    rollBlock = nil,
    dronePosition = nil,
    xRot = 0,
    yRot = 0,
    rollRotation = 0,
    forwardVec = 0,

    --You can edit this
    turnSpeed = 3,
    xSpeed = 18,
    ySpeed = 15,
    --

    TargetingHelper = require('TargetingHelper'),
    AIControa = require('AIControl'),
    playerPosition = nil
}

function droneMod.initHack()
    if Game.GetPlayer().doesItControlADrone == "nil" then
        Game.GetPlayer().doesItControlADrone = false
    end
    droneMod.PAAAAAAAAAANIIIICC()
end

function droneMod.isDroneControlled(object)
    return object.isControlled
end

function droneMod.doesPlayerControlADrone()
    return Game.GetPlayer().doesItControlADrone
end

function droneMod.isDrone(object)
    if object:isDrone() == nil then
        return false
    elseif object:isDrone() then
        return true
    else
        return false
    end
end

function droneMod.vmv(from, to)
    return math.sqrt((to.x - from.x)^2 + (to.y - from.y)^2)
end

function droneMod.isTooLength(length)
    if droneMod.vmv(droneMod.playerPosition, droneMod.controlledDrone:GetWorldPosition()) < length then
        return false
    else
        return true
    end 
end

function droneMod.setIsControlled(object, toggle)
    if toggle then
        if not droneMod.doesPlayerControlADrone() then
            GameObjectEffectHelper.StartEffectEvent(Game.GetPlayer(), "transition_glitch_loop")
            object.isControlled = true --Set the drone as controlled
            droneMod.controlledDrone = object --Add the drone in a variable
            droneMod.rollBlock = GetSingleton('Quaternion'):ToEulerAngles(droneMod.controlledDrone:GetWorldOrientation()).roll --Get drone roll
            droneMod.dronePosition = object:GetWorldPosition() --Get Initial Drone Position
            droneMod.playerPosition = Game.GetPlayer():GetWorldPosition() --Get Initial Player Position
            droneMod.playerOrientation = Game.GetPlayer():GetWorldOrientation() --Get Initial Player Orientation in quat
            
            GetSingleton('StatusEffectHelper'):ApplyStatusEffect(Game.GetPlayer(), "GameplayRestriction.NoCameraControl") --Block the player camera
            GetSingleton('StatusEffectHelper'):ApplyStatusEffect(droneMod.controlledDrone, "BaseStatusEffect.DefeatedWithRecover") --Block the drone
            Game.GetGodModeSystem():AddGodMode(Game.GetPlayer():GetEntityID(), "Invulnerable", CName.new("GracePeriodAfterSpawn"))

            Game.GetPlayer().doesItControlADrone = true --Set as the player control a drone
        end
    else
        if droneMod.doesPlayerControlADrone() then
            
            Game.GetTeleportationFacility():Teleport(Game.GetPlayer(), droneMod.playerPosition, GetSingleton('Quaternion'):ToEulerAngles(droneMod.playerOrientation)) --Teleport Player At His Initial Position/Orientation
            
            GetSingleton('StatusEffectHelper'):RemoveStatusEffect(Game.GetPlayer(), "GameplayRestriction.NoCameraControl") --Reset the player camera
            GetSingleton('StatusEffectHelper'):RemoveStatusEffect(droneMod.controlledDrone, "BaseStatusEffect.DefeatedWithRecover") --Reset the drone
            Game.GetGodModeSystem():ClearGodMode(Game.GetPlayer():GetEntityID(), CName.new("GracePeriodAfterSpawn"))
            Game.GetPlayer():SetInvisible(false)

            object.isControlled = false 
            droneMod.controlledDrone = nil
            droneMod.rollBlock = nil
            droneMod.dronePosition = nil
            droneMod.playerPosition = nil
            droneMod.playerOrientation = nil

            Game.GetPlayer():GetFPPCameraComponent():SetLocalOrientation(Quaternion.new(0.0, 0.0, 0.0, 1.0)) --Intial orientation
            Game.GetPlayer():GetFPPCameraComponent():SetLocalPosition(Vector4.new(0.0, 0.0, 0.0, 1.0)) --Intial Position

            Game.GetPlayer().doesItControlADrone = false --Set as the player don't control a drone
            GameObjectEffectHelper.StartEffectEvent(Game.GetPlayer(), "transition_glitch_loop")
            GameObjectEffectHelper.StopEffectEvent(Game.GetPlayer(), "camera_mask")
        end
    end
end

function droneMod.Rotate()
    if droneMod.doesPlayerControlADrone() == true then
        if droneMod.isDroneDeath(droneMod.controlledDrone) == false then
            --print(droneMod.controlledDrone:GetWorldYaw() + (ClampF(droneMod.xRot / 15, -180.00, 180.00) * (-1)))
            if Game.GetPlayer():checkForObjectInLine(Game.GetPlayer(), droneMod.controlledDrone:GetWorldPosition(), getCoordinaateForwardObject(droneMod.controlledDrone, droneMod.forwardVec * 1.75)) == false then
                droneMod.AIControa.TeleportTo(droneMod.controlledDrone, getCoordinaateForwardObject(droneMod.controlledDrone, droneMod.forwardVec / 5), droneMod.controlledDrone:GetWorldYaw() + (ClampF(droneMod.xRot / droneMod.xSpeed, -180.00, 180.00) * (-1)))
            end
            EulerPP1 = GetSingleton('Quaternion'):ToEulerAngles(Game.GetPlayer():GetFPPCameraComponent():GetLocalOrientation())
            EulerPP = GetSingleton('Quaternion'):ToEulerAngles(droneMod.controlledDrone:GetWorldOrientation())
            --print(droneMod.controlledDrone:GetWorldYaw())
            --print(Game.GetPlayer():GetWorldYaw())
            EulerModified = EulerAngles.new(EulerPP1.roll + (droneMod.rollRotation * (droneMod.turnSpeed * (-1))), EulerPP1.pitch + ClampF(droneMod.yRot / droneMod.ySpeed, -180.00, 180.00), EulerPP.yaw)
            QuatPP = GetSingleton('EulerAngles').ToQuat(EulerModified)
            Game.GetPlayer():GetFPPCameraComponent():SetLocalOrientation(QuatPP)
        end
    end
end

function droneMod.PAAAAAAAAAANIIIICC()
    --If the drone is destroyed, we can paaaaniiiic
    if droneMod.doesPlayerControlADrone() then
        Game.GetTeleportationFacility():Teleport(Game.GetPlayer(), droneMod.playerPosition, GetSingleton('Quaternion'):ToEulerAngles(droneMod.playerOrientation)) --Teleport Player At His Initial Position/Orientation
    end
    
    GetSingleton('StatusEffectHelper'):RemoveStatusEffect(Game.GetPlayer(), "GameplayRestriction.NoCameraControl") --Reset the player camera
    Game.GetGodModeSystem():ClearGodMode(Game.GetPlayer():GetEntityID(), CName.new("GracePeriodAfterSpawn"))
    Game.GetPlayer():SetInvisible(false)

    droneMod.controlledDrone = nil
    droneMod.rollBlock = nil
    droneMod.dronePosition = nil
    droneMod.playerPosition = nil
    droneMod.playerOrientation = nil

    Game.GetPlayer():GetFPPCameraComponent():SetLocalOrientation(Quaternion.new(0.0, 0.0, 0.0, 1.0)) --Intial orientation
    Game.GetPlayer():GetFPPCameraComponent():SetLocalPosition(Vector4.new(0.0, 0.0, 0.0, 1.0)) --Intial Position

    Game.GetPlayer().doesItControlADrone = false --Set as the player don't control a drone
end

function droneMod.listener()
    if (droneMod.doesPlayerControlADrone()) then
        if droneMod.isTooLength(40) then
            GameObjectEffectHelper.StartEffectEvent(Game.GetPlayer(), "transition_glitch_loop")
            droneMod.tpCameraToDrone()
            droneMod.Rotate()
            if droneMod.isTooLength(60) then
                droneMod.setIsControlled(droneMod.controlledDrone, false)
            end
        else
            droneMod.tpCameraToDrone()
            droneMod.Rotate()
        end
    end
    --GetSingleton('StatusEffectHelper'):RemoveStatusEffect(Game.GetPlayer(), "GameplayRestriction.NoCameraControl")
    --Game.GetTeleportationFacility():Teleport(Game.GetPlayer(), Game.GetPlayer():GetWorldPosition(), EulerAngles.new(0, 0, 0))
    --Game.GetPlayer():GetFPPCameraComponent():SetLocalOrientation(Quaternion.new(0.0, 0.0, 0.0, 1.0))
    --print(ClampF(droneMod.yRot, -180.00, 180.00))
    --print("test")
end

function getCoordinaateForwardObject(object, multiplier)
    diection = Game.GetCameraSystem():GetActiveCameraForward()
    playerPos = object:GetWorldPosition()
    vector = Vector4.new(0,0,0,0)
    vector.x = playerPos.x + (diection.x * multiplier)
    vector.y = playerPos.y + (diection.y * multiplier)
    vector.z = playerPos.z + (diection.z * multiplier)
    return vector
end

function droneMod.getCoordinaateForwardCamera(multiplier)
    diection = Game.GetPlayer():GetWorldForward()
    vector = Vector4.new(0,0,0,0)
    vector.x = (diection.x * multiplier)
    vector.y = (diection.y * multiplier)
    vector.z = (diection.z * multiplier)
    return vector
end

function droneMod.tpCameraToDrone()
    if droneMod.doesPlayerControlADrone() == true then
        if droneMod.isDroneDeath(droneMod.controlledDrone) == false then
            --Game.GetPlayer():SetInvisible(true)
            Game.GetTeleportationFacility():Teleport(Game.GetPlayer(), droneMod.controlledDrone:GetWorldPosition(), EulerAngles.new(droneMod.rollBlock,0,droneMod.controlledDrone:GetWorldYaw()))
            Game.GetPlayer():GetFPPCameraComponent():SetLocalPosition(droneMod.getCoordinaateForwardCamera(1.5))
        else
            droneMod.PAAAAAAAAAANIIIICC()
        end
    end
end

function droneMod.isDroneDeath(drone)
    if drone:GetWorldOrientation() == Quaternion.new(0.0, 0.0, 0.0, 1.0) then
        return true
    else
        return false
    end
end

function droneMod.controlTheDrone(entity)
    if droneMod.isDrone(entity) and not droneMod.isDroneControlled(entity) and not droneMod.doesPlayerControlADrone() then
        droneMod.setIsControlled(entity, true)
    end
end

return droneMod