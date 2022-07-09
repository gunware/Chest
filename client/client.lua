RegisterNetEvent("CreateChestNewChest")
AddEventHandler("CreateChestNewChest", function(data)
    Chest_Client:CreateChest(data)
    Chest_Client:OnReady()
end)


RegisterNetEvent("UpdateChest")
AddEventHandler("UpdateChest", function(id, newrot, newpos)
    Chest_Client:SetChestNewCoordsAndRot(id, newrot, newpos)
    Chest_Client:RemoveAndCreateAllChest()
end)

