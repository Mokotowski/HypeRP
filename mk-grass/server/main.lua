ESX.RegisterServerCallback('mk:grassmoneycheck', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() >= Config.Kaucja then 
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('mk:paycar')
AddEventHandler('mk:paycar', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeMoney(Config.Kaucja)
    TriggerClientEvent('mk:givecarstartwork', source)
end)

RegisterServerEvent('mk:payforgrass')
AddEventHandler('mk:payforgrass', function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addMoney(amount)
	TriggerClientEvent('esx:showNotification', xPlayer.source, ('Gotowe!! ~g~$' .. ESX.Math.GroupDigits(amount) .. '~s~ dostałeś ~y~gotówką~s~'))
end)
