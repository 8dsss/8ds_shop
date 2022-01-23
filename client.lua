ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

Item = {
    Nourritures = {
    {Label = "Pain", Name = "bread", Price = 20},
    },

    Boissons = {
    {Label = "Eau", Name = "water", Price = 20},
    },

    Autres = {
    {Label = "Téléphone", Name = "phone", Price = 250}
    }
}

function OpenShop()
  local Shop = RageUI.CreateMenu("Supérette", "ARTICLE(S)")
  local ShopNourritures = RageUI.CreateSubMenu(Shop, "Supérette", "Nourritures")
  local ShopBoissons = RageUI.CreateSubMenu(Shop, "Supérette", "Boissons")
  local ShopAutres = RageUI.CreateSubMenu(Shop, "Supérette", "Autres")

  RageUI.Visible(Shop, not RageUI.Visible(Shop))

  while Shop do
      Citizen.Wait(0)
      RageUI.IsVisible(Shop, true, true, true, function()
 
            RageUI.ButtonWithStyle("Nourritures", nil,  {}, true, function(Hovered, Active, Selected)
            end, ShopNourritures)

            RageUI.ButtonWithStyle("Boissons", nil,  {}, true, function(Hovered, Active, Selected)
            end, ShopBoissons)

            RageUI.ButtonWithStyle("Autres", nil,  {}, true, function(Hovered, Active, Selected)
            end, ShopAutres)

    end)

    RageUI.IsVisible(ShopNourritures, true, true, true, function()
        for k,v in pairs(Item.Nourritures) do
            RageUI.ButtonWithStyle(v.Label, nil, {RightLabel = "~b~"..(v.Price).."$"}, true, function(Hovered, Active, Selected)
              if (Selected) then
                  TriggerServerEvent('8ds:shop', v.Name, v.Price)
                end
            end)
        end
    end)

    RageUI.IsVisible(ShopBoissons, true, true, true, function()
        for k,v in pairs(Item.Boissons) do
            RageUI.ButtonWithStyle(v.Label, nil, {RightLabel = "~b~"..(v.Price).."$"}, true, function(Hovered, Active, Selected)
              if (Selected) then
                  TriggerServerEvent('8ds:shop', v.Name, v.Price)
                end
            end)
        end
    end)

    RageUI.IsVisible(ShopAutres, true, true, true, function()
       for k,v in pairs(Item.Autres) do
          RageUI.ButtonWithStyle(v.Label, nil, {RightLabel = "~b~"..(v.Price).."$"}, true, function(Hovered, Active, Selected)
            if (Selected) then
                TriggerServerEvent('8ds:shop', v.Name, v.Price)
              end
           end)
       end
    end)

  if not RageUI.Visible(Shop) and not RageUI.Visible(ShopAutres) and not RageUI.Visible(ShopNourritures) and not RageUI.Visible(ShopBoissons) then
      Shop = RMenu:DeleteType("Shop", true)
    end
end
end

local position = {
        {x = 373.875,   y = 325.896,  z = 103.566},
		{x = 2557.458,  y = 382.282,  z = 108.622},
		{x = -3038.939, y = 585.954,  z = 7.908},
		{x = -3241.927, y = 1001.462, z = 12.830},
		{x = 547.431,   y = 2671.710, z = 42.156},
		{x = 1961.464,  y = 3740.672, z = 32.343},
		{x = 2678.916,  y = 3280.671, z = 55.241},
        {x = 1729.216,  y = 6414.131, z = 35.037},
        {x = 1135.808,  y = -982.281,  z = 46.415},
		{x = -1222.915, y = -906.983,  z = 12.326},
		{x = -1487.553, y = -379.107,  z = 40.163},
		{x = -2968.243, y = 390.910,   z = 15.043},
		{x = 1166.024,  y = 2708.930,  z = 38.157},
        {x = -48.519,   y = -1757.514, z = 29.421},
		{x = 1163.373,  y = -323.801,  z = 69.205},
		{x = -707.501,  y = -914.260,  z = 19.215},
		{x = -1820.523, y = 792.518,   z = 138.118},
		{x = 1698.388,  y = 4924.404,  z = 42.063},
        {x = 25.82,  y = -1345.22,  z = 29.5}
    }    

Citizen.CreateThread(function()
    for k, v in pairs(position) do
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, 52)
        SetBlipScale (blip, 0.6)
        SetBlipColour(blip, 18)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Supérette')
        EndTextCommandSetBlipName(blip)
    end
end)    
    
 Citizen.CreateThread(function()
    while true do
        local sleep = 500
            for k in pairs(position) do
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
                    if dist <= 1.0 then
                    sleep = 0
                    RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour ouvrir la supérette", time_display = 1 })
                    if IsControlJustPressed(1,51) then
                        OpenShop()
                    end
                end
            end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "mp_m_shopkeep_01", -1221.95, -908.37, 11.32, 30.46, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "mp_m_shopkeep_01", 372.55, 326.46, 102.56, 255.32, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "mp_m_shopkeep_01", 2557.26, 380.84, 107.62, 357.69, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "mp_m_shopkeep_01", -3038.93, 584.49, 6.90, 15.98, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "mp_m_shopkeep_01", -3242.22, -999.95, 11.83, 351.49, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "mp_m_shopkeep_01", 549.07, 2671.31, 41.15, 92.73, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "mp_m_shopkeep_01", 1960.03, 3739.97, 11.83, 295.98, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "mp_m_shopkeep_01", 2678.02, 3279.34, 54.24, 330.89, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "mp_m_shopkeep_01", -1727.77, 6415.19, 34.03, 244.97, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "mp_m_shopkeep_01", 1134.17 -982.49, 45.41, 275.33, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "mp_m_shopkeep_01", -1486.31, -378.00, 39.16, 131.38, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "mp_m_shopkeep_01", -2966.37, 390.81, 14.04, 78.88, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "mp_m_shopkeep_01", 1165.89, 2710.87, 37.15, 175.80, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "mp_m_shopkeep_01", -47.34, -1758.62, 28.42, 45.84, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "mp_m_shopkeep_01", 1164.90, -914.55, 18.21, 91.95, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "mp_m_shopkeep_01", -1819.48, 793.58, 137.08, 132.15, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "mp_m_shopkeep_01", 1697.45, 4923.39, 41.06, 324.42, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "mp_m_shopkeep_01", 24.49, -13455.52, 28.49, 266.81, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)
