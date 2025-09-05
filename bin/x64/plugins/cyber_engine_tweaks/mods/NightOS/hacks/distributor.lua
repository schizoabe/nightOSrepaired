distributorMod = {}

function distributorMod.dispense(object)
    local vendor = Game.GetScriptableSystemsContainer():Get('MarketSystem'):GetVendor(object)
    vendor:RegenerateStock()

    for _, item in ipairs(vendor:GetStock()) do
        local quantity = item.quantity

        for i = 1, quantity / RandRange(1, 5) do
            local dispenseRequest = object:CreateDispenseRequest(false, item.itemID)
            object:DispenseItems(dispenseRequest)
        end
    end

    object:PlayItemFall()
end


return distributorMod