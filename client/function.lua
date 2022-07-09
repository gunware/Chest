
---@field public Chest_Client.config table
config = Chest_Client.config

---@field public Chest_Client.AllChest table
Chest_Client.AllChest = {}

---GetId
---@return number
function Chest_Client:GetId()
    return #Chest_Client.AllChest + 1
end

---GetChest
---@param type string
---@return table
function Chest_Client:GetChestByType(type)
    return config.typeChest[type]
end

---SetCoords
---@param entity Entity
---@param coords vector3
function Chest_Client:SetCoords(entity, coords)
    SetEntityCoords(entity, coords.x, coords.y, coords.z, 1, 0, 0, 1)
end

---SetRot
---@param entity Entity
---@param rot number
function Chest_Client:SetRot(entity, rot)
    Chest_Client:SetEntityRotation(entity, rot)
end

---FreezeEntityPosition
---@param entity Entity
---@param freeze boolean
function Chest_Client:FreezeEntityPosition(entity, freeze)
    FreezeEntityPosition(entity, freeze)
end

---OnGroundProperly
---@param entity Entity
function Chest_Client:OnGroundProperly(entity)
   PlaceObjectOnGroundProperly(entity)
end

---SetServerID
function Chest_Client:SetServerID(id, data)
    Chest_Client.AllChest[id].Server_id = data.Server_id
end


---SetPosition
---@param id number
---@param data table
function Chest_Client:SetPosition(id, data)
    Chest_Client.AllChest[id].Position = data.Position
    Chest_Client.AllChest[id].Rotation = data.Rotation
end

---SetPassWord
---@param id number
---@param data table
function Chest_Client:SetPassWord(id, data)
    Chest_Client.AllChest[id].Password = data.Password
end


---SetWhitelist
---@param id number
---@param data table
function Chest_Client:SetWhitelist(id, data)
    Chest_Client.AllChest[id].Whitelist = data.Whitelist
end
---CreateEntity
---@param props model
function Chest_Client:CreateEntity(props)
    local model = GetHashKey(model)
    RequestModel(props)
    while not HasModelLoaded(props) do
        Wait(0)
    end
    local entity = CreateObject(props, props.Position, props.Rotation, false, false, false)
    return entity
end

---SetDetaill
---@param typeChest string
function Chest_Client:SetDetaill(typeChest)
    id = Chest_Client:GetId()
    Chest_Client.AllChest[id] = {}
    Chest_Client.AllChest[id].Object = typeChest.Object
    Chest_Client.AllChest[id].Capacity = typeChest.Capacity
    Chest_Client.AllChest[id].Id = id
    return id
end

---GetStockById
function Chest_Client:GetStockById(id)
    return Chest_Client.AllChest[id].Capacity
end

---CreateChestByType
---@param typeChest string
---@param data table
function Chest_Client:CreateChestByType(typeOfChest, data)
    Chest = Chest_Client:GetChestByType(typeOfChest)
    id = Chest_Client:SetDetaill(Chest)
    Chest_Client:SetPosition(id, data)
    Chest_Client:SetPassWord(id, data)
    Chest_Client:SetServerID(id, data)
    Chest_Client:SetWhitelist(id, data)
end

---CreateChest
---@param data table
function Chest_Client:CreateChest(data)
    Chest_Client:CreateChestByType(data.Type, data)
end

---SpawnAllChest
---@return void
function Chest_Client:SpawnAllChest()
    for k, v in pairs(Chest_Client.AllChest) do
        if v.Entity == nil then 
            local chest = Chest_Client:CreateEntity(v.Object)
            Chest_Client.AllChest[id].Entity = chest
            Chest_Client:SetCoords(chest, v.Position)
            Chest_Client:SetRot(chest, v.Rotation)
            Chest_Client:OnGroundProperly(chest)
            Chest_Client:FreezeEntityPosition(chest, true)
        end
    end
end

---OnLoad
---@return void
function Chest_Client:OnLoad()
    print(GetCurrentResourceName(), "OnLoad")
end

---DelteAllChest
---@return void
function Chest_Client:DeleteAllChest()
    for k, v in pairs(Chest_Client.AllChest) do
        if v.Entity ~= nil then
            DeleteEntity(v.Entity)
        end
    end
end

---OnReady
---@return void
function Chest_Client:OnReady()
    Chest_Client:SpawnAllChest()
    Chest_Client:OnLoad()
end

---GetAll
---@return table
function Chest_Client:GetAll()
    return Chest_Client.AllChest
end

---GetById
---@param id number
---@return table
function Chest_Client:GetById(id)
    return Chest_Client.AllChest[id]
end

---GetByServerId
---@param id number
---@return table
function Chest_Client:GetByServerId(id)
    for k, v in pairs(Chest_Client.AllChest) do
        if v.Server_id == id then
            return v
        end
    end
end

---GetByCoordsRadius
---@param coords vector3
---@param radius number
---@return table
function Chest_Client:GetByCoordsRadius(coords, radius)
    local chests = {}
    for k, v in pairs(Chest_Client.AllChest) do
        if #(coords - v.Position) < radius then
            table.insert(chests, v)
        end
    end
    return chests
end

---GetByCapacity
---@param capacity number
---@return table
function Chest_Client:GetByCapacity(capacity)
    local chests = {}
    for k, v in pairs(Chest_Client.AllChest) do
        if v.Capacity == capacity then
            table.insert(chests, v)
        end
    end
    return chests
end

---RemoveAndCreateAllChest
---@return void
function Chest_Client:RemoveAndCreateAllChest()
    Chest_Client:DeleteAllChest()
    Chest_Client:OnReady()
end

---GetChestByPassword
---@param password string
---@return table
function Chest_Client:GetChestByPassword(password)
    for k, v in pairs(Chest_Client.AllChest) do
        if v.Password == password then
            return v
        end
    end
end

---GetChestByModel
---@param model string
---@return table
function Chest_Client:GetChestByModel(model)
    for k, v in pairs(Chest_Client.AllChest) do
        if v.Object == model then
            return v
        end
    end
end

---GetChestById
---@param id number
---@return table
function Chest_Client:GetChestById(id)
    return Chest_Client.AllChest[id]
end

---RotatChest
---@param id number
---@param rot number
---@return void
function Chest_Client:RotatChest(id, rot)
    local chest = Chest_Client:GetById(id)
    if chest ~= nil then
        Chest_Client:SetRot(chest.Entity, rot)
    end
end

---Chest_Client:GetEntityCoords(entity)
---@param entity Entity
---@return vector3
function Chest_Client:GetEntityCoords(entity)
    return GetEntityCoords(entity)
end

---SetNewCoords
---@param id number
---@param coords vector3
---@return void
function Chest_Client:SetNewCoords(id, coords)
    local chest = Chest_Client:GetById(id)
    if chest ~= nil then
        Chest_Client:SetCoords(chest.Entity, coords)
        Chest_Client:OnGroundProperly(chest.Entity)
    end
end

---SetNewPassword
---@param id number
---@param password string
---@return void
function Chest_Client:SetNewPassword(id, password)
    local chest = Chest_Client:GetById(id)
    if chest ~= nil then
        chest.Password = password
    end
end

---SetNewCapacity
---@param id number
---@param capacity number
---@return void
function Chest_Client:SetNewCapacity(id, capacity)
    local chest = Chest_Client:GetById(id)
    if chest ~= nil then
        chest.Capacity = capacity
    end
end

---SetNewServerId
---@param id number
---@param server_id number
---@return void
function Chest_Client:SetNewServerId(id, server_id)
    local chest = Chest_Client:GetById(id)
    if chest ~= nil then
        chest.Server_id = server_id
    end
end

---SetNewType
---@param id number
---@param type string
---@return void
function Chest_Client:SetNewType(id, type)
    local chest = Chest_Client:GetById(id)
    if chest ~= nil then
        chest.Type = type
    end
end

---DeleteChestById
---@param id number
---@return void
function Chest_Client:DeleteChestById(id)
    local chest = Chest_Client:GetById(id)
    if chest ~= nil then
        DeleteEntity(chest.Entity)
        Chest_Client.AllChest[id] = nil
    end
end

---DeleteChestByServerId
---@param server_id number
---@return void
function Chest_Client:DeleteChestByServerId(server_id)
    local chest = Chest_Client:GetByServerId(server_id)
    if chest ~= nil then
        Chest_Client:DeleteAllChest()
        Chest_Client:DeleteAllDetail()
        Chest_Client:OnReady()
    end
end

---DeleteAllDetail
---@return void
function Chest_Client:DeleteAllDetail(id)
    for k, v in pairs(Chest_Client.AllChest) do
        if v.server_id == id then
            Chest_Client.AllChest[k] = nil
        end
    end
end

---DeleteChestByModel
---@param model string
---@return void
function Chest_Client:DeleteChestByModel(model)
    local chest = Chest_Client:GetByModel(model)
    if chest ~= nil then
        DeleteEntity(chest.Entity)
        Chest_Client.AllChest[chest.Id] = nil
    end
end


---DeleteChestByCapacity
---@param capacity number
---@return void
function Chest_Client:DeleteChestByCapacity(capacity)
    local chests = Chest_Client:GetByCapacity(capacity)
    for k, v in pairs(chests) do
        DeleteEntity(v.Entity)
        Chest_Client.AllChest[v.Id] = nil
    end
end

---DeleteChestByRadius
---@param coords vector3
---@param radius number
---@return void
function Chest_Client:DeleteChestByRadius(coords, radius)
    local chests = Chest_Client:GetByCoordsRadius(coords, radius)
    for k, v in pairs(chests) do
        DeleteEntity(v.Entity)
        Chest_Client.AllChest[v.Id] = nil
    end
end

---ReplaceAllchestOnGround
---@return void
function Chest_Client:ReplaceAllchestOnGround()
    for k, v in pairs(Chest_Client.AllChest) do
        Chest_Client:OnGroundProperly(v.Entity)
    end
end

---SetChestNewCoordsAndRot
---@param id number
---@param coords vector3
---@param rot number
---@return void
function Chest_Client:SetChestNewCoordsAndRot(id, rot, coords)
    local chest = Chest_Client:GetById(id)
    if chest ~= nil then
        Chest_Client:SetCoords(chest.Entity, coords)
        Chest_Client:SetRot(chest.Entity, rot)
        Chest_Client:OnGroundProperly(chest.Entity)
    end
end

---SetChestNewEntityModel
---@param id number
---@param model string
---@return void
function Chest_Client:SetChestNewEntityModel(id, model)
    local chest = Chest_Client:GetById(id)
    if chest ~= nil then
        Chest_Client:DeleteChestById(id)
        Chest_Client:SpawnChest(model, chest.Position, chest.Rotation, chest.Capacity, chest.Password, chest.Server_id, chest.Type)
    end
end

---GetEntityRotation
---@param entity number
---@return number
function Chest_Client:GetEntityRotation(entity)
    local heading = GetEntityHeading(entity)
    local x = math.cos(math.rad(heading))
    local y = math.sin(math.rad(heading))
    return x, y
end

---SetEntityRotation
---@param entity number
---@param rot number
---@param x number
---@param y number
---@return void
function Chest_Client:SetEntityRotation(entity, rot)
    local x, y = Chest_Client:GetEntityRotation(entity)
    SetEntityHeading(entity, math.deg(math.atan2(y, x)) + rot)
end

---onResourceStop
---Delete all chest
AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    Chest_Client:DeleteAllChest()
end)

---DrawText3D
---@param x number
---@param y number
---@param z number
---@param text string
DrawText3D = function(x, y, z, text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end