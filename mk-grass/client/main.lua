local blipgrass
local blipszatnie 
local kosiarka
local inwork  = false 
local strefa = nil
local laststrefa = 1

local function addblip(coords)

    if blipgrass ~= nil then
        RemoveBlip(blipgrass)
    end

    blipgrass = AddBlipForCoord(coords.x, coords.y, coords.z)

    SetBlipSprite(blipgrass, 431)
    SetBlipDisplay(blipgrass, 4)
    SetBlipScale(blipgrass, 1.0)
    SetBlipAsShortRange(blipgrass, true)
    SetBlipColour(blipgrass, 52)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Zarośla do ścięcia")
    EndTextCommandSetBlipName(blipgrass)

end

function Grasserstart()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'grasser',
	{
		title    = "Ogrodnik",
		align    = 'right',
		elements = {
			{label = "Strój cywilny",                    value = 'cywilny'},
            {label = "Strój roboczy",                    value = 'roboczy'},
			{label = "Start Pracy",                      value = 'praca'},

		}
	}, function (data, menu)
		local action = data.current.value

		if action == 'cywilny' then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('esx_tattooshop:refreshTattoos')
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
            inwork = false 
        elseif action == 'roboczy' then
            setUniform()
            inwork = true 
        elseif action == 'praca' then
            ESX.TriggerServerCallback('mk:grassmoneycheck', function(f)
                if inwork then
                    if f then
                        TriggerServerEvent('mk:paycar')
                    else
                        ESX.ShowNotification('Nie masz wstarczająco gotówki przy sobie cena kaucji to 10k $.')
                    end
                else
                    ESX.ShowNotification('Nie jesteś w stroju do pracy')
                end
            end)            
		end

	end, function (data, menu)
		menu.close()

	end)

end

function isspawn()
    for k, v in pairs(Config.Locations) do
        if Config.Locations[k].egzist == true then
            return true 
        end
    end
    return false
end

function setUniform()
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject
		if skin.sex == 0 then
			uniformObject = Config.Uniforms["worker"].male
		else
			uniformObject = Config.Uniforms["worker"].female
		end
		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
		end
	end)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('mk:givecarstartwork')
AddEventHandler('mk:givecarstartwork', function()
    ESX.Game.SpawnVehicle(Config.Car, Config.SpawnCarcoords, 275, function(kosiarka)
        TaskWarpPedIntoVehicle(PlayerPedId(), kosiarka, -1)
        SetVehicleDirtLevel(kosiarka, 0)
        SetVehicleFuelLevel(kosiarka, 100.0)
        SetEntityAsMissionEntity(kosiarka, true, true) 
    end)
end)


CreateThread(function()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.Jobname then

    if blipszatnie ~= nil then
        RemoveBlip(blipszatnie)
    end

    blipszatnie = AddBlipForCoord(Config.Szatnia.x, Config.Szatnia.y)

    SetBlipSprite(blipszatnie, 801)
    SetBlipDisplay(blipszatnie, 4)
    SetBlipScale(blipszatnie, 1.0)
    SetBlipAsShortRange(blipszatnie, true)
    SetBlipColour(blipszatnie, 25)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Szatnia")
    EndTextCommandSetBlipName(blipszatnie)
    end
end)

CreateThread(function()
	while true do
		Wait(5)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.Jobname then
		local playerCoords, letSleep = GetEntityCoords(PlayerPedId()), true
		local distance = #(playerCoords - Config.Szatnia)
		if distance < 8 then
			letSleep = false
			DrawMarker(27, Config.Szatnia, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 500, false, true, 2, false, nil, nil, false)
            if IsControlJustReleased(0, 38) and distance < 2 then
                Grasserstart()
            end
		end
		if letSleep then
			Wait(2500)
		end
        end
	end
end)


CreateThread(function()
    while true  do 
        if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.Jobname then

        if inwork then 
            if not isspawn() then 
                strefa = math.random(#Config.Locations)
                while strefa == laststrefa do 
                    strefa = math.random(#Config.Locations)
                end
                roslina = math.random(#Config.Grasses)
                Config.Locations[strefa].object = CreateObject(Config.Grasses[roslina].chwast, Config.Locations[strefa].coords.x, Config.Locations[strefa].coords.y, Config.Locations[strefa].coords.z, false, false, false)        
                addblip(Config.Locations[strefa].coords)
                SetNewWaypoint(Config.Locations[strefa].coords.x, Config.Locations[strefa].coords.y)
                Config.Locations[strefa].egzist = true
                laststrefa = strefa
            end
        end
        end
        Wait(1000)
    end
end)


CreateThread(function()
    while true do
		Wait(5)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.Jobname then

        if isspawn() then 
            local playerCoords, letSleep = GetEntityCoords(PlayerPedId()), true
            local distance = #(playerCoords - Config.Locations[strefa].coords)
            if distance < 15 then
                letSleep = false
            end
            if letSleep then
                Wait(500)
            end
            if distance < 2 then
                if IsControlJustReleased(0, 38) then
                    if IsPedInAnyVehicle(PlayerPedId(), false) and IsVehicleModel(GetVehiclePedIsIn(PlayerPedId(), false), GetHashKey(Config.Car)) then
                        RemoveBlip(blipgrass)
                        DeleteObject(Config.Locations[strefa].object)
                        Config.Locations[strefa].egzist = false
                        TriggerServerEvent('mk:payforgrass', Config.Locations[strefa].amount)
                    else
                        ESX.ShowNotification('Nie jesteś w kosiarce')
                    end
                end
            end
        else
            Wait(2500)            
        end
        end
	end
end)




