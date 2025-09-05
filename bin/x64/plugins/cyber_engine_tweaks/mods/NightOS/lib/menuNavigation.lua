menuNav = {}


function menuNav.addInPosition(object, position)
    if object:isHackableONS() then
        if position < (object:getQHackSize() - 1) then
            position = position + 1
        else
            position = 0
        end
    end
    return position
end

function menuNav.decreaseInPosition(object, position)
    if object:isHackableONS() then
        if position == 0 then
            position = object:getQHackSize()
        end
        if position <= object:getQHackSize() then
            position = position - 1
        end
    end
    return position
end

return menuNav