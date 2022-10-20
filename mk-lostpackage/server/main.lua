ESX.RegisterServerCallback('mk:check', function(source, cb, k)
	cb(Config.Locations[k].var)
end)

RegisterNetEvent('mk:use')
AddEventHandler('mk:use', function(k, tryb, amount)
    Config.Locations[k].var = tryb
    local xPlayer = ESX.GetPlayerFromId(source, k)
    if math.random(1,100) < Config.PercentCash then 
        xPlayer.addMoney(math.random(Config.MoneyMin, Config.MoneyMax), "Drugs Sold")
    else
        xPlayer.addInventoryItem(Config.Reward[math.random(#Config.Reward)], amount)
     end
end)


