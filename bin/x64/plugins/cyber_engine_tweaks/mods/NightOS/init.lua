NightOS = {
    disableFakeDoorHacking = false,
    HLWDDelta = 0,
    HLWDDelta2 = 0,
    HLWDDelta3 = 0,
    hasOpenedTheMenu = false,
    positionInMenu = 0,
    hud = false,
    executeTheShit = false,
    actuallyObject = "nil",
    VehiclesMod = require("hacks/vehicles"),
    TrafficLightMod = require("hacks/trafficlight"),
    propaneTankMod = require("hacks/propanetank"),
    menuNav = require("lib/menuNavigation"),
    droneMod = require("hacks/drone"),
    otherLibs = require("lib/otherShits"),
    TargetingHelper = require('TargetingHelper'),
    AIControl = require('AIControl'),
    settings = require('settings'),
    npcMod = require("hacks/npc"),
    dropPointMod = require("hacks/dropoff"),
    doorMod = require("hacks/door"),
    forkLiftMod = require("hacks/forkLift"),
    fuseboxMod = require("hacks/fusebox"),
    tvMod = require("hacks/tv"),
    distributorMod = require("hacks/distributor"),
    npcNearInstance = nil,
    NOSQHackSystem = nil,
    vehicleArray = {}
}

function NightOS.setupArray(array)
    for i = 1, 15 do
        array = nil
    end
end

function NightOS.registerObject(object)
    if not object:GetHudManager():IsRegistered(object:GetEntityID()) then
        object:RegisterToHUDManager(true)
        object.isHacked = false
        --currentObjectWatching.vehicleCooldown = 30
    end
end

function NightOS.decideByObjectHack(object)
    return object.isHacked
end

function NightOS.hackTheObject(object, position)
    if object:isHackableONS() then
        if object.isHacked == false and NightOS.otherLibs.doesPlayerCanMakeIt(NightOS.getMemory(), object:getHackTypeName(), position) then
            object.isHacked = true
            object.hackType = position

            if object:getHackTypeName() == "explodecho" then
                if object:IsSurveillanceCamera() == false and object:IsTurret() == false and not object:getHackTypeName() == "npcpuppet" then
                    NightOS.removeMemory(NightOS.otherLibs.getHackCost(object:getHackTypeName(), position) * (-1))
                end
            else
                NightOS.removeMemory(NightOS.otherLibs.getHackCost(object:getHackTypeName(), position) * (-1))
            end

            NightOS.suppEffectWhenStartUp(object)

            NightOS.addTheVehicleInArray(object)
        end
    end
end

function NightOS.openTheMenu(toggle, object)
    cantClick = NightOS.decideByObjectHack(object)
    if toggle then
        if object:getHackTypeName() == "trafficlight" then
            NightOS.QHackSystemNOS:revealQHackMenuTrafficLight(object, Game.GetPlayer(), true, cantClick)
        elseif object:getHackTypeName() == "npcpuppet" and object:ToString() == "NPCPuppet" and not NightOS.droneMod.isDrone(object) then
            if object:GetPS():IsQuickHacksExposed() or object:IsCharacterPolice() or object:IsCharacterChildren() then
                NightOS.npcMod.showMenu(object, Game.GetPlayer(), true, cantClick, true)
            elseif not GetSingleton('PlayerPuppet'):IsTargetFriendlyNPC(Game.GetPlayer(), object) then
                NightOS.npcMod.showMenu(object, Game.GetPlayer(), true, cantClick, true)
            end
        elseif object:getHackTypeName() == "npcpuppet" and NightOS.droneMod.isDrone(object) then
            if object:GetPS():IsQuickHacksExposed() then
                NightOS.npcMod.showMenuDrone(object, Game.GetPlayer(), true, cantClick)
            else
                NightOS.npcMod.showMenuDrone(object, Game.GetPlayer(), true, true)
            end
        elseif object:getHackTypeName() == "turret" and object:IsTurret() then
            NightOS.npcMod.showMenuTurret(object, Game.GetPlayer(), true, cantClick)
        elseif object:getHackTypeName() == "door" then
            NightOS.QHackSystemNOS:revealQHackMenuDoor(object, Game.GetPlayer(), true, cantClick)
        elseif object:getHackTypeName() == "TV" then
            NightOS.QHackSystemNOS:revealQHackMenuTV(object, Game.GetPlayer(), true, cantClick)
        elseif object:getHackTypeName() == "elevator" then
            NightOS.QHackSystemNOS:revealQHackMenuElevator(object, Game.GetPlayer(), true, cantClick)
        elseif object:getHackTypeName() == "dropoff" and object:IsDropPoint() then
            NightOS.dropPointMod.revealQHackMenuDropOff(object, Game.GetPlayer(), true, cantClick)
        elseif object:getHackTypeName() == "forklift" then
            NightOS.QHackSystemNOS:revealQHackMenuForklift(object, Game.GetPlayer(), true, cantClick)
        elseif object:getHackTypeName() == "fusebox" then
            NightOS.QHackSystemNOS:revealQHackMenufusebox(object, Game.GetPlayer(),
                not object:GetDevicePS():IsOverloaded(), cantClick)
        elseif object:getHackTypeName() == "VendingMachine" then
            NightOS.QHackSystemNOS:revealQHackMenuVendingMachine(object, Game.GetPlayer(), true, cantClick)
        elseif object:getHackTypeName() == "explodecho" then
            if object:IsSurveillanceCamera() == false and object:IsTurret() == false then
                if object:GetDevicePS():IsExploded() == false then
                    NightOS.QHackSystemNOS:revealQHackMenuExplosiveDevice(object, Game.GetPlayer(), true, cantClick)
                else
                    NightOS.QHackSystemNOS:revealQHackMenuExplosiveDevice(object, Game.GetPlayer(), false, cantClick)
                end
            end
        end

        if NightOS.hasOpenedTheMenu == false then
            NightOS.hasOpenedTheMenu = true
            NightOS.positionInMenu = 0
        end
        if object.isHacked then
            Game.Noslowmo()
        else
            Game.SetTimeDilation(0.05)
        end
    else
        if object:getHackTypeName() == "VendingMachine" then
            NightOS.QHackSystemNOS:revealQHackMenuVendingMachine(object, Game.GetPlayer(), false, cantClick)
            Game.Noslowmo()
        elseif object:getHackTypeName() == "trafficlight" then
            NightOS.QHackSystemNOS:revealQHackMenuTrafficLight(object, Game.GetPlayer(), false, cantClick)
            Game.Noslowmo()
        elseif object:getHackTypeName() == "elevator" then
            NightOS.QHackSystemNOS:revealQHackMenuElevator(object, Game.GetPlayer(), false, cantClick)
            Game.Noslowmo()
        elseif object:getHackTypeName() == "explodecho" then
            NightOS.QHackSystemNOS:revealQHackMenuExplosiveDevice(object, Game.GetPlayer(), false, cantClick)
            Game.Noslowmo()
        elseif object:getHackTypeName() == "turret" and object:IsTurret() then
            NightOS.npcMod.showMenuTurret(object, Game.GetPlayer(), false, cantClick)
            Game.Noslowmo()
        elseif object:getHackTypeName() == "dropoff" and object:IsDropPoint() then
            NightOS.dropPointMod.revealQHackMenuDropOff(object, Game.GetPlayer(), false, cantClick)
            Game.Noslowmo()
        elseif object:getHackTypeName() == "door" and not object:HasAnyDirectInteractionActive() then
            NightOS.QHackSystemNOS:revealQHackMenuDoor(object, Game.GetPlayer(), false, cantClick)
            Game.Noslowmo()
        elseif object:getHackTypeName() == "forklift" then
            NightOS.QHackSystemNOS:revealQHackMenuForklift(object, Game.GetPlayer(), false, cantClick)
            Game.Noslowmo()
        elseif object:getHackTypeName() == "fusebox" then
            NightOS.QHackSystemNOS:revealQHackMenufusebox(object, Game.GetPlayer(), false, cantClick)
            Game.Noslowmo()
        elseif object:getHackTypeName() == "TV" then
            NightOS.QHackSystemNOS:revealQHackMenuTV(object, Game.GetPlayer(), false, cantClick)
            Game.Noslowmo()
        elseif object:getHackTypeName() == "npcpuppet" and object:ToString() == "NPCPuppet" and not NightOS.droneMod.isDrone(object) then
            NightOS.npcMod.showMenu(object, Game.GetPlayer(), false, cantClick)
            Game.Noslowmo()
        elseif object:getHackTypeName() == "npcpuppet" and NightOS.droneMod.isDrone(object) then
            NightOS.npcMod.showMenuDrone(object, Game.GetPlayer(), false, cantClick)
            Game.Noslowmo()
        end
        NightOS.positionInMenu = 0
        if NightOS.hasOpenedTheMenu == true then
            NightOS.hasOpenedTheMenu = false
        end
    end
end

function NightOS.manageEffects()
    for i = 1, 15 do
        if NightOS.vehicleArray[i] == nil then
        else
            if NightOS.vehicleArray[i]:getHackTypeName() == "trafficlight" then
                if NightOS.vehicleArray[i].hackType == 4 then
                    NightOS.TrafficLightMod.ChangeLight(NightOS.vehicleArray[i],
                        NightOS.TrafficLightMod.ChooseRandomLight())
                elseif NightOS.vehicleArray[i].hackType == 0 then
                    NightOS.TrafficLightMod.OnOff(NightOS.vehicleArray[i])
                elseif NightOS.vehicleArray[i].hackType == 1 then
                    NightOS.TrafficLightMod.ChangeLight(NightOS.vehicleArray[i], "red")
                elseif NightOS.vehicleArray[i].hackType == 2 then
                    NightOS.TrafficLightMod.ChangeLight(NightOS.vehicleArray[i], "green")
                elseif NightOS.vehicleArray[i].hackType == 3 then
                    NightOS.TrafficLightMod.ChangeLight(NightOS.vehicleArray[i], "yellow")
                end
            elseif NightOS.vehicleArray[i]:getHackTypeName() == "explodecho" then
                if NightOS.vehicleArray[i].hackType == 0 then
                    NightOS.propaneTankMod.Explode(NightOS.vehicleArray[i])
                elseif NightOS.vehicleArray[i].hackType == 1 then
                    NightOS.propaneTankMod.explodeIfNPCNear(NightOS.vehicleArray[i])
                end
            elseif NightOS.vehicleArray[i]:getHackTypeName() == "dropoff" then
                if NightOS.vehicleArray[i].hackType == 0 then
                    NightOS.dropPointMod.cutPower(NightOS.vehicleArray[i])
                elseif NightOS.vehicleArray[i].hackType == 1 then
                    NightOS.npcMod.makePlayerResearched()
                    NightOS.dropPointMod.takeTheMoney(NightOS.vehicleArray[i])
                end
                NightOS.StopThisHack(NightOS.vehicleArray[i])
                --elseif NightOS.vehicleArray[i]:getHackTypeName() == "door" then
            elseif NightOS.vehicleArray[i]:getHackTypeName() == "forklift" then
                if NightOS.vehicleArray[i].hackType == 0 then
                    NightOS.forkLiftMod.setIsControlled(true, NightOS.vehicleArray[i])
                    NightOS.StopThisHack(NightOS.vehicleArray[i])
                end
            elseif NightOS.vehicleArray[i]:getHackTypeName() == "fusebox" then
                if NightOS.vehicleArray[i].hackType == 1 then
                    if NightOS.vehicleArray[i].vehicleCooldown > 25 then
                        fuseboxMod.LightToOne(1)
                    end
                    NightOS.vehicleArray[i].isHacked = true
                end
            end
        end
    end
end

function NightOS.manageTimer()
    for i = 1, 15 do
        if NightOS.vehicleArray[i] == nil then
        else
            if NightOS.vehicleArray[i].isHacked == true then
                if NightOS.vehicleArray[i].vehicleCooldown < 30 then
                    NightOS.vehicleArray[i].vehicleCooldown = NightOS.vehicleArray[i].vehicleCooldown + 1
                else
                    NightOS.vehicleArray[i].isHacked = false
                    NightOS.vehicleArray[i].vehicleCooldown = 0
                    NightOS.vehicleArray[i] = nil
                end
            end
        end
    end
end

function NightOS.addTheVehicleInArray(vehicle)
    for i = 1, 15 do
        if NightOS.vehicleArray[i] == nil then
            NightOS.vehicleArray[i] = vehicle
            break
        end
    end
end

function NightOS.StopThisHack(object)
    object.vehicleCooldown = 31
end

function NightOS.suppEffectWhenStartUp(object)
    if object:getHackTypeName() == "trafficlight" then
        object.onOffOneExec = false
    elseif object:getHackTypeName() == "door" then
        object.vehicleCooldown = 25
        if object.hackType == 0 then
            if not object:GetDevicePS():IsSkillCheckActive() then
                NightOS.doorMod.openDoor(object)
            end
        elseif object.hackType == 1 then
            if not object:GetDevicePS():IsSkillCheckActive() then
                if object:GetDevicePS().isLocked == true then
                    object:GetDevicePS().isLocked = false
                    object:UpdateLight()
                else
                    object:GetDevicePS().isLocked = true
                    object:UpdateLight()
                end
            end
        elseif object.hackType == 2 then
            object:GetStimBroadcasterComponent():TriggerSingleBroadcast(object, gamedataStimType.DeviceExplosion);
            object.vehicleCooldown = 20
        end
    elseif object:getHackTypeName() == "npcpuppet" then
        if NightOS.droneMod.isDrone(object) then
            NightOS.droneMod.controlTheDrone(object)
        else
            if object:GetPS():IsQuickHacksExposed() then
                NightOS.npcMod.makePlayerResearched()
                Game.AddToInventory("Items.money", object.moneyAmount)
                object.moneyAmount = 0
            end
        end
    elseif object:getHackTypeName() == "fakedoor" then
        Game.GetTeleportationFacility():Teleport(object, object:GetWorldPosition(),
            EulerAngles.new(0, 0, object:GetWorldYaw() + 90))
    elseif object:getHackTypeName() == "elevator" then
        object:GetController():GetPS():UnlockConnectedDoors()
        object:GetController():GetPS():HackCallElevator()
    elseif object:getHackTypeName() == "forklift" then
        if object.hackType == 0 then
        elseif object.hackType == 1 then
            object.vehicleCooldown = 25
            NightOS.forkLiftMod.distractTheEnemy(object)
        elseif object.hackType == 2 then
            object.vehicleCooldown = 25
            object:GetController():GetPS():ExecutePSAction(object:GetController():GetPS():ActionActivateDevice(
                "Activate"))
        end
    elseif object:getHackTypeName() == "TV" then
        if object.hackType == 0 then
            object.vehicleCooldown = 25
            if object:GetDevicePS():IsGlitching() then
                tvMod.noGlitch(object)
            else
                tvMod.glitch(object)
            end
        elseif object.hackType == 1 then
            object.vehicleCooldown = 25
            if tvMod.isOn then
                tvMod.turnOff(object)
                tvMod.isOn = false
            else
                tvMod.turnOn(object)
                tvMod.isOn = true
            end
        elseif object.hackType == 2 then
            object.vehicleCooldown = 25
            tvMod.nextChannel(object)
        elseif object.hackType == 3 then
            object.vehicleCooldown = 25
            object:GetStimBroadcasterComponent():TriggerSingleBroadcast(object, gamedataStimType.DeviceExplosion);
        end
    elseif object:getHackTypeName() == "fusebox" then
        if object.hackType == 0 then
            fuseboxMod.startLight()
        elseif object.hackType == 1 then
            fuseboxMod.LightToOne(2)
            object:GetController():GetPS():ExecutePSAction(object:GetController():GetPS():ActionOverloadDevice())
        elseif object.hackType == 2 then
            fuseboxMod.distractTheEnemy(object)
        end
    elseif object:getHackTypeName() == "VendingMachine" then
        if object.hackType == 0 then
            distributorMod.dispense(object)
        elseif object.hackType == 1 then
            object.vehicleCooldown = 10
            object:GetStimBroadcasterComponent():TriggerSingleBroadcast(object, gamedataStimType.SoundDistraction)
        end
    end
end

function NightOS.removeMemory(mem)
    return Game.GetStatPoolsSystem():RequestChangingStatPoolValue(Game.GetPlayer():GetEntityID(), 'Memory', mem,
        Game.GetPlayer(), true, false)
end

function NightOS.getMemory()
    return Game.GetStatPoolsSystem():GetStatPoolValue(Game.GetPlayer():GetEntityID(), "Memory", false)
end

function NightOS.initHack() --This function is for solving a bug, i don't know why this bug appear but that work
    local GetPlayerQuickHackListWithQuality = Game['gameRPGManager::GetPlayerQuickHackListWithQuality;PlayerPuppet']
    GetPlayerQuickHackListWithQuality(Game.GetPlayer())

    NightOS.npcNearInstance = Game.GetPlayer():getNPCNearSystem()
    NightOS.QHackSystemNOS = QHackSystemNOS.new()

    Game.GetPlayer().doesPlayerControlAForkLift = false
    NightOS.executeTheShit = Game.GetPlayer() and Game.GetPlayer():IsAttached() and
        not Game.GetSystemRequestsHandler():IsPreGame()
end

function NightOS.reloadMod()
    NightOS.HLWDDelta = 0
    NightOS.HLWDDelta2 = 0
    NightOS.hasOpenedTheMenu = false
    NightOS.positionInMenu = 0
    NightOS.VehiclesMod = require("hacks/vehicles")
    NightOS.TrafficLightMod = require("hacks/trafficlight")
    NightOS.propaneTankMod = require("hacks/propanetank")
    NightOS.menuNav = require("lib/menuNavigation")
    NightOS.vehicleArray = {}
    NightOS.droneMod.initHack()
    NightOS.initHack()
    Game.GetPlayer().doesPlayerControlAForkLift = false
    Game.GetUISystem():RestorePreviousVisualState("inkScanningState");
end

function NightOS.fakeDoorHackingManagement(currentObjectWatching)
    if NightOS.hud and currentObjectWatching:ToString() == "FakeDoor" then
        if not Game.GetPlayer():GetHudManager():IsQuickHackPanelOpened() then
            NightOS.QHackSystemNOS:revealQHackMenuFDoor(currentObjectWatching, Game.GetPlayer(), false, true)
        end
        if not currentObjectWatching.isHacked then
            NightOS.QHackSystemNOS:revealQHackMenuFDoor(currentObjectWatching, Game.GetPlayer(), true, false)
        else
            NightOS.QHackSystemNOS:revealQHackMenuFDoor(currentObjectWatching, Game.GetPlayer(), true, true)
        end
    elseif Game.GetPlayer():GetHudManager():IsQuickHackPanelOpened() then
        NightOS.QHackSystemNOS:revealQHackMenuFDoor(currentObjectWatching, Game.GetPlayer(), false, true)
    end
end

function NightOS:new()
    registerForEvent("onInit", function()
        NightOS.setupArray(NightOS.vehicleArray)
        NightOS.initHack()

        Observe('QuestTrackerGameController', 'OnInitialize', function()
            Game.GetPlayer().canStopSlowDown = true
            NightOS.reloadMod()
            NightOS.executeTheShit = true
            print("NightOS: In scene")
        end)

        Observe('QuestTrackerGameController', 'OnUninitialize', function()
            NightOS.reloadMod()
            NightOS.executeTheShit = false
            print("NightOS: In scene")
        end)

        Observe('scannerGameController', 'ShowScanner', function(self, show)
            if show == false then
                Game.Noslowmo()
            end
        end)

        Observe("PlayerPuppet", "OnAction", function(self, action, consumer)
            local actionName = Game.NameToString(action:GetName(action))
            local actionType = action:GetType(action).value

            if actionName == "Ping" then
                if (actionType == "BUTTON_PRESSED") then
                    NightOS.hud = true
                elseif (actionType == "BUTTON_RELEASED") then
                    NightOS.hud = false
                end
            end

            if actionName == "OpenPauseMenu" then
                if NightOS.droneMod.doesPlayerControlADrone() then
                    ListenerActionConsumer.DontSendReleaseEvent(consumer)
                    NightOS.droneMod.setIsControlled(NightOS.droneMod.controlledDrone, false)
                elseif NightOS.forkLiftMod.doesPlayerControlAForkLift() then
                    ListenerActionConsumer.DontSendReleaseEvent(consumer)
                    NightOS.forkLiftMod.setIsControlled(false, NightOS.forkLiftMod.getForkLift())
                end
            end

            if actionName == "MoveY" then
                droneMod.forwardVec = action:GetValue(action)
                forkLiftMod.forward = action:GetValue(action)
            end

            if actionName == "character_preview_rotate" then
                droneMod.rollRotation = action:GetValue(action)
            end

            if actionName == "one_click_confirm" then
                if (actionType == "BUTTON_PRESSED") then
                    NightOS.forkLiftMod.upDownForkLift(NightOS.forkLiftMod.getForkLift())
                end
            end

            if actionName == "CameraMouseX" then
                if action:GetValue(action) > 0 then
                    forkLiftMod.rollRotation = 1
                elseif action:GetValue(action) == 0 then
                    forkLiftMod.rollRotation = 0
                else
                    forkLiftMod.rollRotation = -1
                end
                droneMod.xRot = action:GetValue(action)
            end

            if actionName == "CameraMouseX" then
                NightOS.droneMod.yRot = action:GetValue(action)
            end

            if actionName == "right_stick_x" then
                if action:GetValue(action) > 0 then
                    forkLiftMod.rollRotation = 1
                elseif action:GetValue(action) == 0 then
                    forkLiftMod.rollRotation = 0
                else
                    forkLiftMod.rollRotation = -1
                end
                droneMod.xRot = action:GetValue(action) * 20
            end
            if actionName == "right_stick_y" then
                droneMod.forwardVec = action:GetValue(action)
                droneMod.yRot = action:GetValue(action) * 20
            end
            --Appliquer un hack
            if actionName == "UI_ApplyAndClose" and actionType == "BUTTON_PRESSED" then
                currentObjectWatching = Game.GetTargetingSystem():GetLookAtObject(Game.GetPlayer(), false, false)
                NightOS.hackTheObject(currentObjectWatching, NightOS.positionInMenu)
            end

            -- Trouver sur quel hack le joueur est
            if actionName == "UI_MoveDown" and actionType == "BUTTON_PRESSED" then
                currentObjectWatching = Game.GetTargetingSystem():GetLookAtObject(Game.GetPlayer(), false, false)
                NightOS.positionInMenu = NightOS.menuNav.addInPosition(currentObjectWatching, NightOS.positionInMenu)
            elseif actionName == "UI_MoveUp" and actionType == "BUTTON_PRESSED" then
                currentObjectWatching = Game.GetTargetingSystem():GetLookAtObject(Game.GetPlayer(), false, false)
                NightOS.positionInMenu = NightOS.menuNav.decreaseInPosition(currentObjectWatching, NightOS
                    .positionInMenu)
            end
        end)
    end)

    function getSpeedBySpeed(speed)
        local actualSpeed = Game.GetMountedVehicle(Game.GetPlayer()):GetVehicleComponent().vehicleBlackboard:GetFloat(
            GetAllBlackboardDefs().Vehicle.SpeedValue) * 3
        local maxSpeed = (Game.GetMountedVehicle(Game.GetPlayer()):GetVehicleComponent().vehicleBlackboard:GetFloat(GetAllBlackboardDefs().Vehicle.RPMMax) / 49.5) /
            1.5
        return (maxSpeed / 6) * speed
    end

    function getNearNPCs(object)
        targetingSystem = Game.GetTargetingSystem()
        parts = {}
        searchQuery = Game["TSQ_ALL;"]()                                           -- Search ALL objects
        searchQuery.maxDistance = Game["SNameplateRangesData::GetDisplayRange;"]() -- Set search radius
        searchQuery.searchFilter = Game["TSF_EnemyNPC;"]()                         -- Filter EnemyNPCs
        success, parts = targetingSystem:GetTargetParts(object, searchQuerys)
        print(success)
        local i = 0
        for _, v in ipairs(parts) do
            i = i + 1
        end
        print(i)
    end

    registerForEvent("onUpdate", function(deltaTime)
        if Game.GetPlayer() then
            Game.GetPlayer().minMoney = settings.minMoneyWhenStealingNPC
            Game.GetPlayer().maxMoney = settings.maxMoneyWhenStealingNPC
            NightOS.droneMod.listener()
            NightOS.forkLiftMod.listener()
            forkLiftMod.deltaTime = forkLiftMod.deltaTime + deltaTime
            forkLiftMod.deltaTimeEffect = forkLiftMod.deltaTimeEffect + deltaTime
            NightOS.HLWDDelta = NightOS.HLWDDelta + deltaTime
            NightOS.HLWDDelta2 = NightOS.HLWDDelta2 + deltaTime
            if NightOS.HLWDDelta > 0.25 then
                currentObjectWatching = Game.GetTargetingSystem():GetLookAtObject(Game.GetPlayer(), false, false)
                if currentObjectWatching then
                    --print(10 + 100 - Game.GetStatPoolsSystem():GetStatPoolValue(currentObjectWatching:GetEntityID(), gamedataStatPoolType.Health, true))
                    if currentObjectWatching:isHackableONS() == nil or Game.GetPlayer():GetHudManager():IsBraindanceActive() then
                    elseif currentObjectWatching:isHackableONS() then
                        NightOS.registerObject(currentObjectWatching)
                        if currentObjectWatching:IsCurrentlyScanned() then
                            NightOS.actuallyObject = currentObjectWatching
                            NightOS.openTheMenu(true, currentObjectWatching)
                        elseif Game.GetPlayer():GetHudManager():IsQuickHackPanelOpened() and NightOS.hasOpenedTheMenu then
                            NightOS.openTheMenu(false, currentObjectWatching)
                        elseif currentObjectWatching:getHackTypeName() == "fakedoor" and not NightOS.disableFakeDoorHacking then
                            NightOS.fakeDoorHackingManagement(currentObjectWatching)
                        end
                    end
                end
                NightOS.manageEffects()
                NightOS.HLWDDelta = NightOS.HLWDDelta - 0.25
            end

            if NightOS.HLWDDelta2 > 1 then
                NightOS.manageTimer()
                NightOS.HLWDDelta2 = NightOS.HLWDDelta2 - 1
            end

            if not Game.GetPlayer():GetHudManager():IsQuickHackPanelOpened() and NightOS.executeTheShit then
                NightOS.positionInMenu = 0
            end

            if Game.GetPlayer():GetHudManager():IsQuickHackPanelOpened() and NightOS.executeTheShit then
                if not Game.GetTargetingSystem():GetLookAtObject(Game.GetPlayer(), false, false) then
                    if NightOS.actuallyObject:isHackableONS() then
                        NightOS.openTheMenu(false, NightOS.actuallyObject)
                        Game.Noslowmo()
                        NightOS.actuallyObject = nil
                    end
                end
            end
        end
    end)

    return NightOS
end

return NightOS.new()
