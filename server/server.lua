local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-rental:attemptPurchase', function(car, price, rentMinute, fee)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local cash = Player.PlayerData.money.cash

    local total = price + fee
    if cash >= price then
        Player.Functions.RemoveMoney("cash", total, "rentals")
        TriggerClientEvent('qb-rental:vehiclespawn', source, car, rentMinute)
        TriggerClientEvent('QBCore:Notify', src, car .. " has been rented for $" .. price .. ", return it in order to receive 50% of the total costs.", "success")
    else
        TriggerClientEvent('qb-rental:attemptvehiclespawnfail', source)
    end
end)

RegisterServerEvent('qb-rental:giverentalpaperServer', function(model, plateText)
    local src = source
    local PlayerData = QBCore.Functions.GetPlayer(src)
    local info = {
        label = plateText, 
    }
    PlayerData.Functions.AddItem('rentalpapers', 1, false, info)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['rentalpapers'], "add")
end)

RegisterServerEvent('qb-rental:server:payreturn', function(model)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    for k,v in pairs(Config.vehicleList) do 
        if string.lower(v.model) == model then
            local payment = v.price / 2
            Player.Functions.RemoveItem('rentalpapers', 1)
            Player.Functions.AddMoney("cash",payment,"rental-return")
            TriggerClientEvent('QBCore:Notify', src, "You have returned your rented vehicle and received $" .. payment .. " in return.", "success")
        end
    end
end)

RegisterServerEvent('qb-rental:server:notimereturn', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('rentalpapers', 1)
    TriggerClientEvent('QBCore:Notify', src, "Your rental time has been finished, your car was impounded by the Government", "error")
end)

QBCore.Functions.CreateCallback('qb-rental:server:hasrentalpapers', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local Item = Player.Functions.GetItemByName("rentalpapers")
    if Item ~= nil then
        cb(true)
    else
        cb(false)
    end
end)