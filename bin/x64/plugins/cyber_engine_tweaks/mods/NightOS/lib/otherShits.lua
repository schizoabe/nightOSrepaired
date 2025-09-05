otherLibs = {}

function otherLibs.VectorMoinsVector(vector1, vector2)
    vec1x = vector1.x 
    vec1y = vector1.y
    vec1z = vector1.z

    vec2x = vector2.x
    vec2y = vector2.y
    vec2z = vector2.z

    
    return Vector4.new((vec1x - vec2x),(vec1y - vec2y),(vec1z - vec2z),vector1.w)
end

function otherLibs.getPositionIsVector(object, vector, multiplier)
    a = object:GetWorldPosition()
    
    return Vector4.new(a.x + (vector.x * multiplier), a.y + (vector.y * multiplier), a.z + (vector.z * multiplier), a.w)
end

function otherLibs.distanceVectorX(from, to)
    return math.sqrt((to.x - from.x)^2)
end

function otherLibs.distanceVectorY(from, to)
    return math.sqrt((to.y - from.y)^2)
end

function otherLibs.distanceVectorZ(from, to)
    return math.sqrt((to.z - from.z)^2)
end

function otherLibs.doesPlayerCanMakeIt(Amount, hackType, hackNumber)
    if Amount >= otherLibs.getHackCost(hackType, hackNumber) then
        return true
    else
        return false
    end
end

function otherLibs.getHackCost(hackType, hackNumber)
    if hackType == "vehicle" then
        if hackNumber == 0 then
            return 1
        elseif hackNumber == 1 then
            return 1
        elseif hackNumber == 2 then
            return 1
        elseif hackNumber == 3 then
            return 1
        elseif hackNumber == 4 then
            return 1
        elseif hackNumber == 5 then
            return 2
        elseif hackNumber == 6 then
            return 2
        end
    elseif hackType == "trafficlight" then
        if hackNumber == 0 then
            return 1
        elseif hackNumber == 1 then
            return 1
        elseif hackNumber == 2 then
            return 1
        elseif hackNumber == 3 then
            return 1
        elseif hackNumber == 4 then
            return 1
        end
    elseif hackType == "npcpuppet" then
        return 5
    elseif hackType == "door" then
        if hackNumber == 0 then
            return 1
        elseif hackNumber == 1 then
            return 1
        elseif hackNumber == 2 then
            return 1
        end
    elseif hackType == "elevator" then
        if hackNumber == 0 then
            return 1
        end
    elseif hackType == "dropoff" then
        return 2
    elseif hackType == "fakedoor" then
        return 1
    elseif hackType == "forklift" then
        if hackNumber == 0 then
            return 3
        elseif hackNumber == 1 then
            return 1
        elseif hackNumber == 2 then
            return 1
        end
    elseif hackType == "fusebox" then
        if hackNumber == 0 then
            return 3
        elseif hackNumber == 1 then
            return 3
        elseif hackNumber == 2 then
            return 1
        end
    elseif hackType == "explodecho" then
        if hackNumber == 0 then
            return 3
        elseif hackNumber == 1 then
            return 3
        end
    elseif hackType == "TV" then
        if hackNumber == 0 then
            return 1
        elseif hackNumber == 1 then
            return 1
        elseif hackNumber == 2 then
            return 1
        elseif hackNumber == 3 then
            return 2
        end
    elseif hackType == "VendingMachine" then
        if hackNumber == 0 then
            return 6
        elseif hackNumber == 1 then
            return 2
        end
    end
end

return otherLibs