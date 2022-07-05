local shopIsIn = {}

Citizen.CreateThread(function()
    for _,v in pairs(Config.Location) do
        local blip = AddBlipForCoord(v.npcLocation.xyz)
		SetBlipSprite(blip, 171)
		SetBlipScale(blip, 0.9)
		SetBlipDisplay(blip, 4)
		SetBlipColour(blip, 46)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Location")
		EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    for _,v in pairs(Config.Location) do
        local modelHash = GetHashKey(Config.PedModel)
        if not IsModelInCdimage(modelHash) then return end
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Citizen.Wait(10)
        end
        local ped = CreatePed(1, modelHash, v.npcLocation, false, true)
        SetEntityAsMissionEntity(ped, true, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        Wait(1500)
        FreezeEntityPosition(ped, true)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 750
        for k,v in pairs(Config.Location) do
            local pPos = GetEntityCoords(PlayerPedId()) 
            local dist = #(pPos - v.npcLocation.xyz)
            if dist <= 1.5 then
                sleep = 0
                ESX.ShowHelpNotification("Appyer sur ~INPUT_CONTEXT~ pour louer un véhicule")
                if IsControlJustPressed(0, 51) then
                    SendNUIMessage({
                        type = 'open'
                    })                    
                    SetNuiFocus(true, true)
                    shopIsIn = v
                end
            end
        end
        Wait(sleep)
    end
end)

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('rentVeh', function(data, cb)
    local veh = data.vehModel
    ESX.TriggerServerCallback('zLocation:canRentVehicle', function(success)
        if success then
            for i = 1, #shopIsIn.spawnLocation do
                if ESX.Game.IsSpawnPointClear(shopIsIn.spawnLocation[i].xyz, 1.0) then
                    ESX.Game.SpawnVehicle(veh, shopIsIn.spawnLocation[i].xyz, shopIsIn.spawnLocation[i].w, function(vehicle) 
                        SetEntityAsMissionEntity(vehicle, true, true)
                        SetVehicleHasBeenOwnedByPlayer(vehicle, true)
                        TriggerServerEvent("zLocation:rentVehicle", veh)
                    end, true)
                    cb(true)
                    break
                end
                if i == #shopIsIn.spawnLocation then 
                    ESX.ShowNotification("Pas d'emplacement") 
                    cb(false)
                end
            end
            SendNUIMessage({
                type = 'close'
            })  
            SetNuiFocus(false, false)
        else
            cb(false)
        end
    end, veh)
end)