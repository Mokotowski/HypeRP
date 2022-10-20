local standard = `xm_prop_x17_chest_closed`
local open = `xm_prop_x17_chest_open`


for k,v in pairs(Config.Locations) do
    ESX.TriggerServerCallback('mk:check', function(var)
        if var then 
            Config.Locations[k].object = CreateObject(standard, Config.Locations[k].coords.x, Config.Locations[k].coords.y, Config.Locations[k].coords.z- 1, false, false, false)
        else
            Config.Locations[k].object = CreateObject(open, Config.Locations[k].coords.x, Config.Locations[k].coords.y, Config.Locations[k].coords.z- 1, false, false, false)
        end
    end, k)
end

RegisterNetEvent('mk:afteruse')
AddEventHandler('mk:afteruse', function(k)
    ESX.TriggerServerCallback('mk:check', function(var)
        if var then
            TriggerServerEvent('mk:use', k, false, 1)
            DeleteObject(Config.Locations[k].object)  
            Config.Locations[k].object = CreateObject(open, Config.Locations[k].coords.x, Config.Locations[k].coords.y, Config.Locations[k].coords.z- 1, false, false, false)
            else
            ESX.ShowNotification("Ktoś już otworzył tą skrzynie")
        end
    end, k)
end)

CreateThread(function()
	while true do
        for k,v in pairs(Config.Locations) do
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = #(playerCoords - v.coords)
            if distance < 2 then 
                if(IsControlJustReleased(0, 54)) then
                    TriggerEvent('mk:afteruse', k)
                end
            end
        end
		Wait(5)
	end
end)


