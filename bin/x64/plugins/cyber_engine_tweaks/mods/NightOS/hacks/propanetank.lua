propaneTankMod = {}


function propaneTankMod.Explode(object)
    if object:GetDevicePS():IsExploded() == false and object:IsSurveillanceCamera() == false and object:IsTurret() == false then
        object:Explode(0, object)
    end
end

function propaneTankMod.getNearNPCs(radius, shouldSize, object)
    targetingSystem = Game.GetTargetingSystem()
    parts = {}
    searchQuery = Game["TSQ_ALL;"]() -- Search ALL objects
    searchQuery.maxDistance = radius -- Set search radius
    searchQuery.searchFilter = Game["TSF_NPC;"]() -- Filter EnemyNPCs
    success, parts = targetingSystem:GetTargetParts(object, searchQuery)
    if shouldSize then
        local i = 0
        for _, v in ipairs(parts) do
            i = i + 1
        end
        return i
    else
        return parts
    end
end

function propaneTankMod.explodeIfNPCNear(object)
    if object:GetDevicePS():IsExploded() == false and object:IsSurveillanceCamera() == false and object:IsTurret() == false then
        print(propaneTankMod.getNearNPCs(10, true, object))
        if propaneTankMod.getNearNPCs(2.5, true, object) > 0 then
            propaneTankMod.Explode(object)
        end
    end
end

return propaneTankMod