ESX.RegisterServerCallback("zLocation:canRentVehicle", function(source, cb, vehModel)
    local xPlayer = ESX.GetPlayerFromId(source)
    local veh = GetVehicleByModel(vehModel)
    if xPlayer.getMoney() >= veh.price then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent("zLocation:rentVehicle", function(vehModel)
    local veh = GetVehicleByModel(vehModel)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeMoney(veh.price)
end)

function GetVehicleByModel(model)
    for _,v in pairs(Config.CarRental) do
        if v.model == model then
            return v
        end
    end
    return nil
end