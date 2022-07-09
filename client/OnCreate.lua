TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('chest:OnCreate')
AddEventHandler('chest:OnCreate', function(type)
    TriggerEvent("close:inventory")
    Citizen.Wait(5000)
    OpenCreator(type)
end)

local menuxx = false
local mainMenu = RageUI.CreateMenu(" ", "Que veux tu faire ?")
mainMenu.Closed = function() 
    menuxx = false 
end

mainMenu.Closable = false

function OpenCreator(type)
    local data = {
        Type = type,
        Position = 'Non defini',
        Rotation = 'Non defini',
        Password = 'Non defini',
        Whitelist = 'no',
    }
    if menuxx then
        return 
    else
        menuxx = true
        RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while true do
                RageUI.IsVisible(mainMenu,function()
                    RageUI.Button("Position du coffre", false, {RightLabel = data.Position}, true, {
                        onSelected = function()
                            local Position = GetEntityCoords(PlayerPedId())-vector3(0,0,0.5)
                            data.Position = Position
                        end
                    })
                    RageUI.Button("Rotation du coffre", false, {RightLabel = data.Rotation}, true, {
                        onSelected = function()
                            local Rotation = Chest_Client:GetEntityRotation(PlayerPedId())
                            data.Rotation = Rotation
                        end
                    })
                    RageUI.Button("Mot de passe", false, {RightLabel = data.Password}, true, {
                        onSelected = function()
                            local Password = exports.Aft_input:ShowSync('Mot de pass du coffre', false, 320, "small-text")
                            data.Password = Password
                        end
                    })
                    RageUI.Button("jobs ? laisser no si non wl", false, {RightLabel = data.Whitelist}, true, {
                        onSelected = function()
                            local Whitelist = exports.Aft_input:ShowSync('jobs ? laisser no si non wl', false, 320, "small-text")
                            data.Whitelist = Whitelist
                        end
                    })
                    RageUI.Button("Valider", false, {}, true, {
                        onSelected = function()
                            TriggerServerEvent('chest:OnCreateSV', data)
                            RageUI.CloseAll()
                            TriggerServerEvent('chest:OnCreateDB', data)
                        end
                    })
                end)
                Wait(0)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while ESX == nil do Citizen.Wait(0) end
    Citizen.Wait(1000)
    ESX.TriggerServerCallback('chest:GetAllChest', function(result)
        for k, v in pairs(result) do
            local datax = {
                Server_id = v.id,
                Type = v.Type,
                Position = v.Position,
                Rotation = v.Rotation,
                Password = v.Password,
                Whitelist = v.Whitelist,
            }
            Chest_Client:CreateChest(datax)
            Chest_Client:OnReady()
        end
    end)
end)