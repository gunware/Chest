Citizen.CreateThread(function()
    while not NetworkIsPlayerActive(PlayerId()) do
        Citizen.Wait(0)
    end
    while true do
        Waitx = 500
        local Position = GetEntityCoords(PlayerPedId())
        for k,v in pairs(Chest_Client.AllChest) do
            if #(Position - v.Position) < 4.5 then
                Waitx = 0
                if v.Whitelist ~= "no" then
                    if ESX.GetPlayerData().job.name == v.Whitelist then
                        DrawText3D(v.Position.x, v.Position.y, v.Position.z+2, "~g~[~w~E~g~]~w~")
                        if IsControlJustPressed(0, 38) then
                            ExecuteCommand('me regarde dans le stock')
                            Chest_Client:OpenChest(v.Id, v.Server_id)
                        end
                    end
                else
                    DrawText3D(v.Position.x, v.Position.y, v.Position.z, "~g~[~w~E~g~]~w~")
                    if IsControlJustPressed(0, 38) then
                        password = exports.Aft_input:ShowSync('Mot de pass du coffre', false, 320, "small-text")
                        if (password == v.Password) then
                            ExecuteCommand('me regarde dans le coffre')
                            Chest_Client:OpenChest(v.Id, v.Server_id)
                            PlaySoundFrontend(-1, "Pin_Good", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 1)
                        else
                            PlaySoundFrontend(-1, "Pin_Bad", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 1)  
                        end
                    end
                end
            end
        end
        Citizen.Wait(Waitx)
    end
end)
