dropPointMod = {}


function dropPointMod.cutPower(object)
    if object:IsDropPoint() then
        object:TurnOffDevice()
    end
end

function dropPointMod.turnScreenOff(object)
    if object:IsDropPoint() then
        object.uiComponent:Toggle(false)
    end
end

function dropPointMod.Glitch(object)
    if object:IsDropPoint() then
        object:StartGlitching("DEFAULT", 1.0)
    end
end

function dropPointMod.takeTheMoney(object)
    if object:IsDropPoint() then
        Game.AddToInventory("Items.money", object.moneyAmount)
        object.moneyAmount = 0
    end
end

function dropPointMod.revealQHackMenuDropOff(npc, player, shouldShow, lockIm)
    local CheckPrereqs = Game['gameRPGManager::CheckPrereqs;array<IPrereq_Record>GameObject']
    local CalculateStatModifiers = Game['gameRPGManager::CalculateStatModifiers;FloatFloatFloatarray<StatModifier_Record>GameInstanceGameObjectStatsObjectIDStatsObjectIDStatsObjectID']
    local GetPlayerQuickHackListWithQuality = Game['gameRPGManager::GetPlayerQuickHackListWithQuality;PlayerPuppet']
    local GetPlayerQuickHackListWithQualityNOS = Game['gameRPGManager::GetPlayerQuickHackListWithQualityNOS;PlayerPuppet']
    
    local playerQHacksList = GetPlayerQuickHackListWithQualityNOS(player)
    
    local commands = {}

    local context = player:GetPS():GenerateContext("Remote", NewObject("handle:gamedeviceClearance"), Game.GetPlayerSystem():GetLocalPlayerControlledGameObject(), npc:GetEntityID())
    local i = 0
 
    for _, actionData in pairs(playerQHacksList) do

        local action = player:GetPS():GetAction(actionData.actionRecord)
        actionRecord = actionData.actionRecord
        
    	if (i == 3) then
            break
        end
        
        if actionRecord:ObjectActionType():Type().value == "DeviceQuickHack" then
            local newCommand = NewObject("handle:QuickhackData")
            
            newCommand.actionOwnerName = player:GetTweakDBFullDisplayName(true)
            

            newCommand.icon = actionRecord:ObjectActionUI():CaptionIcon():TexturePartID():GetID()
            newCommand.type = actionRecord:ObjectActionType():Type()
            newCommand.actionOwner = npc:GetEntityID()
            newCommand.isInstant = false
            newCommand.ICELevel = player:GetICELevel()
            newCommand.ICELevelVisible = true
            newCommand.quality = actionData.quality
            newCommand.networkBreached = player:IsBreached()
            newCommand.category = actionRecord:HackCategory()
            newCommand.actionCompletionEffects = actionRecord:CompletionEffects()

            if i == 1 then
                newCommand.title = "On/Off"
            elseif i == 2 then
                newCommand.title = "Steal Money (" .. npc.moneyAmount .. "€$)"
            end


            actionStartEffects = actionRecord:StartEffects()
            for _, effect in pairs(actionStartEffects) do

                if effect:StatusEffect() and effect:StatusEffect():StatusEffectType():Type().value == "PlayerCooldown" then
                    statModifiers = effect:StatusEffect():Duration():StatModifiers()
                    newCommand.cooldown = 0.0
                    newCommand.cooldownTweak = effect:StatusEffect():GetID()
                end
                
            end

            newCommand.duration = player:GetQuickHackDuration(actionData.actionRecord, npc, npc:GetEntityID(), Game.GetPlayer():GetEntityID())

            local puppetAction = player:GetPS():GetAction(actionData.actionRecord)
            puppetAction:SetExecutor(context.processInitiatorObject)
            puppetAction:RegisterAsRequester(player:GetPS():GetMyEntityID())
            puppetAction:SetObjectActionID(actionData.actionRecord:GetID())
            puppetAction:SetUp(player:GetPS())
      
            newCommand.uploadTime = puppetAction:GetActivationTime()
            newCommand.costRaw = puppetAction:GetBaseCost()
            newCommand.cost = puppetAction:GetCost();

            newCommand.actionMatchesTarget = true

            if puppetAction:IsInactive() then
                newCommand.isLocked = true
                newCommand.inactiveReason = puppetAction.GetInactiveReason()
            elseif Game.GetStatPoolsSystem():IsStatPoolAdded(npc:GetEntityID(), "QuickHackUpload") then
                newCommand.isLocked = true
                newCommand.inactiveReason = "LocKey#7020"
            elseif not puppetAction:CanPayCost() then
                newCommand.isLocked = true
                newCommand.actionState = "OutOfMemory"
                newCommand.inactiveReason = "LocKey#27398"
            else
                newCommand.action = puppetAction
            end

            if actionRecord:GetTargetActivePrereqsCount() > 0 then
                targetActivePrereqs = actionRecord:TargetActivePrereqs()
                for _, activePrereqs in pairs(targetActivePrereqs) do

                    prereqsToCheck = activePrereqs:FailureConditionPrereq()
                    if not CheckPrereqs(prereqsToCheck, npc) then
                        newCommand.isLocked = true;
                        newCommand.inactiveReason = activePrereqs:FailureExplanation()
                    end
                end

            end
            newCommand.isLocked = lockIm;
            commands[i] = newCommand
            i = i + 1
        end

    end

    npc.NpcPuppetQHackSize = i

    quickSlotsManagerNotification = NewObject("handle:RevealInteractionWheel")
    quickSlotsManagerNotification.lookAtObject = npc
    quickSlotsManagerNotification.shouldReveal = shouldShow
    quickSlotsManagerNotification.commands = commands

    Game.GetUISystem():QueueEvent(quickSlotsManagerNotification)
end

return dropPointMod