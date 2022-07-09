
local mainMenuChest = RageUI.CreateMenu("Coffre", "Que veux tu faire ?")
local depose = RageUI.CreateSubMenu(mainMenuChest, "Dépose", "Que veux tu faire ?")
local retire = RageUI.CreateSubMenu(mainMenuChest, "Retire", "Que veux tu faire ?")
local Gestion = RageUI.CreateSubMenu(mainMenuChest, "Gestion", "Que veux tu faire ?")

mainMenuChest.Closed = function() 
    menu = false 
end
function Chest_Client:OpenChest(id, svid)
    print(id, svid)
    coffreitem = {}
    if menu then 
        return 
    else 
        menu = true
        RageUI.Visible(mainMenuChest, true)
        CreateThread(function()
            while menu do
                RageUI.IsVisible(mainMenuChest,function()
                    RageUI.Separator("Capacité du coffre " .. Chest_Client:GetStockById(id) .. " items")
                    RageUI.Button("Déposer", false, {}, true, {onSelected = function() loadchest = false end}, depose)
                    RageUI.Button("Retirer", false, {}, true, {onSelected = function() loadchest = false end}, retire)
                  --  RageUI.Button("Gestion du coffre", false, {}, true, {onSelected = function()end}, Gestion)
                end)
                RageUI.IsVisible(Gestion, function()
                    RageUI.Button("Supprimer", false, {}, true, {onSelected = function()
                        TriggerServerEvent('chest:DeleteChest', svid)
                        Chest_Client:DeleteChestByServerId(svid)
                        RageUI.CloseAll()
                    end})
                end)
                RageUI.IsVisible(depose,function()
                    for _,item in ipairs(ESX.GetPlayerData().inventory) do
                        RageUI.Button(item.label, false, {RightLabel = "x~o~" .. item.count .. ""}, true, {
                            onSelected = function()
                                dataLoadedstock = false
                                qty = exports.Aft_input:ShowSync('Quantité', false, 320, "number")
                                if qty then
                                    if tonumber(qty) <= tonumber(item.count) then
                                        TriggerServerEvent('DeposeItemChest', svid, item.name, item.label, tonumber(qty), Chest_Client:GetStockById(id))
                                    else 
                                        ESX.ShowNotification('~r~Vous n\'en n\'avez pas assez !')
                                    end
                                else 
                                    ESX.ShowNotification('~r~Une erreur est survenue')
                                end
                            end
                        })
                    end
                end)
                RageUI.IsVisible(retire,function()
                    if not loadchest then 
                        ESX.TriggerServerCallback('Getcoffreitemt', function(inforeturn)
                            loadchest = true
                            coffreitemt = inforeturn
                        end,svid)
                    end
                    if loadchest then
                        if #coffreitemt == 0 then 
                            RageUI.Separator("") RageUI.Separator("~r~Vous n'avez pas d'item")RageUI.Separator("")
                        else
                            for _,item in ipairs(coffreitemt) do
                                if item.qty > 0 then 
                                    RageUI.Button(item.label, false, {RightLabel = "~o~[ ~r~x~o~" .. item.qty .. " ]"}, true, {
                                        onSelected = function()
                                            dataLoadedstock = false
                                            qty = exports.Aft_input:ShowSync('Quantité', false, 320, "number")
                                            if qty ~= nil and item.qty ~= nil then
                                                if tonumber(qty) <= tonumber(item.qty) then
                                                    TriggerServerEvent('Retirecoffreitemt', svid, item.name, item.label, tonumber(qty))
                                                    loadchest = false
                                                else 
                                                    ESX.ShowNotification('~r~Vous n\'en n\'avez pas assez !')
                                                end
                                            else 
                                                ESX.ShowNotification('~r~Une erreur est survenue')
                                            end
                                        end
                                    })
                                end
                            end
                        end
                    end
                end)
                Wait(0)
            end
        end)
    end
end