local ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function Chest_Server:CountObject(id, qty, maxqty)
    tablecountitem = {}
    qtyitem = 0
    tablecountitem = MySQL.Sync.fetchAll("SELECT * FROM Aft_Coffre_item WHERE chestid = @chestid", {['@chestid'] = id})
    if #tablecountitem == 0 then
        return false, qtyitem
    else
        for i = 1, #tablecountitem, 1 do
            qtyitem = qtyitem + tablecountitem[i].qty
        end
        if qtyitem+qty > maxqty then
            return true, qtyitem
        else
            return false , qtyitem
        end
    end
end

Chest_Server.AllChest = {}

function Chest_Server:OnReady()
    MySQL.Async.fetchAll('SELECT * FROM Aft_coffre', {}, function(result)
        for i = 1, #result, 1 do
            coords = json.decode(result[i].position)
            local data = {
                id = result[i].id,
                Type = result[i].type,
                Position = vector3(coords.x, coords.y, coords.z),
                Rotation = result[i].rotation,
                Password = result[i].password,
                Whitelist = result[i].whitelist
            }
            Chest_Server.AllChest[#Chest_Server.AllChest+1] = data
        end
    end)
end

ESX.RegisterUsableItem('coffre1', function(src)
    xply = ESX.GetPlayerFromId(src)
    xply.removeInventoryItem('coffre1', 1)
    TriggerClientEvent('chest:OnCreate', src, 'small')
end)

ESX.RegisterUsableItem('coffre2', function(src)
    xply = ESX.GetPlayerFromId(src)
    xply.removeInventoryItem('coffre2', 1)
    TriggerClientEvent('chest:OnCreate', src, 'medium')
end)

ESX.RegisterUsableItem('coffre3', function(src)
    xply = ESX.GetPlayerFromId(src)
    xply.removeInventoryItem('coffre3', 1)
    TriggerClientEvent('chest:OnCreate', src, 'large')
end)

ESX.RegisterUsableItem('coffre4', function(src)
    xply = ESX.GetPlayerFromId(src)
    xply.removeInventoryItem('chestbasic', 1)
    TriggerClientEvent('chest:OnCreate', src, 'chestbasic')
end)

RegisterNetEvent('chest:OnCreateDB')
AddEventHandler('chest:OnCreateDB', function(data)
    MySQL.Async.execute('INSERT INTO Aft_coffre (type, position, rotation, password, whitelist) VALUES (@type, @position, @rotation, @password, @whitelist)', {
        ['@type'] = data.Type,
        ['@position'] = json.encode(data.Position),
        ['@rotation'] = data.Rotation,
        ['@password'] = data.Password,
        ['@whitelist'] = data.Whitelist
    }, function(rowsChanged)
        Chest_Server:OnReady()
    end)
end)

RegisterNetEvent('DeposeItemChest')
AddEventHandler('DeposeItemChest', function(id, name, label, qty, Capacity)
    local xPlayer = ESX.GetPlayerFromId(source)
    pass = Chest_Server:CountObject(id, qty, Capacity)
    if pass then 
        TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Ce coffre est plein')
    else
        xPlayer.removeInventoryItem(name, qty)
        MySQL.Async.fetchAll("SELECT * FROM Aft_Coffre_item", {}, function(result)
            for k,v in pairs(result) do
                if v.name == name and v.chestid == id then
                    itemName = v.name
                    countItem = v.qty
                    id = v.id
                    hasItem = true
                end
            end
            if hasItem then
                local total = tonumber(countItem+qty)
                MySQL.Sync.execute("UPDATE Aft_Coffre_item SET `qty` = @a WHERE id = @id", {
                    ["@id"] = id,
                    ["@a"] = total
                })
                hasItem = false
                TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Vous avez déposé '..qty..' '..label..' dans le coffre')
            else
                MySQL.Async.execute("INSERT INTO Aft_Coffre_item (label, name, qty, chestid) VALUES (@label, @name, @qty, @chestid)", {
                    ['@label'] = label,
                    ['@name'] = name,
                    ['@qty'] = qty,
                    ['@chestid'] = id
                }, function()
                    TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Vous avez déposé '..qty..' '..label..' dans le coffre')
                end) 
                hasItem = false 
            end
        end)
    end
end)

RegisterNetEvent('Retirecoffreitemt')
AddEventHandler('Retirecoffreitemt', function(id, name, label, qty, Capacity)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM Aft_Coffre_item", {}, function(result)
        for k,v in pairs(result) do
            if v.name == name and v.chestid == id then
                itemName = v.name
                countItem = v.qty
                id = v.id
                hasItem = true
            end
        end
        if hasItem then
            local total = tonumber(countItem-qty)
            if total == 0 then
                MySQL.Sync.execute("DELETE FROM Aft_Coffre_item WHERE id = @id", {
                    ["@id"] = id
                })
            else
                MySQL.Sync.execute("UPDATE Aft_Coffre_item SET `qty` = @a WHERE id = @id", {
                    ["@id"] = id,
                    ["@a"] = total
                })
            end
            hasItem = false
            xPlayer.addInventoryItem(name, qty)
            TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Vous avez retiré '..qty..' '..label..' du coffre')
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Vous n\'avez pas cet item')
            hasItem = false 
        end
    end)
end)

ESX.RegisterServerCallback('Getcoffreitemt', function(source, cb, id)
    MySQL.Async.fetchAll("SELECT * FROM Aft_Coffre_item WHERE chestid = @chestid", {['@chestid'] = id}, function(result)
        cb(result)
    end)
end)

Citizen.CreateThread(function()
    Chest_Server:OnReady()
end)

ESX.RegisterServerCallback('chest:GetAllChest', function(source, cb)
    cb(Chest_Server.AllChest)
end)

RegisterNetEvent("chest:OnCreateSV")
AddEventHandler("chest:OnCreateSV", function(data)
   TriggerClientEvent('CreateChestNewChest', -1, data)
end)
