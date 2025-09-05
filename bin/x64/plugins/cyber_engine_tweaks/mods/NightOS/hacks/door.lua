doorMod = {}


function doorMod.openDoor(object)
    if object:GetDevicePS():IsClosed() then
        object:OpenDoor()
    else
        object:CloseDoor()
    end
end


return doorMod