Config = {}
Config.Car = 'mower'
Config.Grasses = {
    [1] = {
        ['chwast'] = `prop_veg_grass_01_d`,
    },  
    [2] = {
        ['chwast'] = `prop_veg_grass_01_b`,
    },  

}
Config.Jobname = 'grasser'
Config.Kaucja = 10000
Config.Szatnia = vector3(-1358.94, 120.56, 55.43)
Config.SpawnCarcoords = vector3(-1351.268, 132.5616, 56.24826)
Config.Locations = {
    [1] = {
        ['coords'] = vector3(-1283.498, 180.278, 58.0),
        ['object'] = nil,
        ['egzist'] = false,
        ['amount'] = 1000,
    },
    [2] = {
        ['coords'] = vector3(-1118.767, 233.5087, 64.3),
        ['object'] = nil,
        ['egzist'] = false,
        ['amount'] = 2000,
    },
    [3] = {
        ['coords'] = vector3(-1106.559, 166.0472, 60.92316),
        ['object'] = nil,
        ['egzist'] = false,
        ['amount'] = 3000,
    },
    [4] = {
        ['coords'] = vector3(-1174.575, 101.6169, 56.74961),
        ['object'] = nil,
        ['egzist'] = false,
        ['amount'] = 3000,
    },
    [5] = {
        ['coords'] = vector3(-1093.678, 63.17353, 51.68025),
        ['object'] = nil,
        ['egzist'] = false,
        ['amount'] = 3000,
    },
    [6] = {
        ['coords'] = vector3(-1123.599, -73.8623, 41.38954),
        ['object'] = nil,
        ['egzist'] = false,
        ['amount'] = 3000,
    },
    [7] = {
        ['coords'] = vector3(-1264.171, -29.99249, 45.38148),
        ['object'] = nil,
        ['egzist'] = false,
        ['amount'] = 3000,
    },
    [8] = {
        ['coords'] = vector3(-1309.572, 26.73006, 51.18765),
        ['object'] = nil,
        ['egzist'] = false,
        ['amount'] = 3000,
    },
    [9] = {
        ['coords'] = vector3(-1236.055, 105.2121, 54.73634),
        ['object'] = nil,
        ['egzist'] = false,
        ['amount'] = 3000,
    },
    [10] = {
        ['coords'] = vector3(-1198.768, 156.42, 59.72283),
        ['object'] = nil,
        ['egzist'] = false,
        ['amount'] = 3000,
    },
    [11] = {
        ['coords'] = vector3(-1055.212, -129.8043, 39.18953),
        ['object'] = nil,
        ['egzist'] = false,
        ['amount'] = 3000,
    },
    [12] = {
        ['coords'] = vector3(-1104.664, 158.4026, 61.04041),
        ['object'] = nil,
        ['egzist'] = false,
        ['amount'] = 3000,
    },
    [13] = {
        ['coords'] = vector3(-1337.598, 28.17246, 51.54181),
        ['object'] = nil,
        ['egzist'] = false,
        ['amount'] = 3000,
    },
    [14] = {
        ['coords'] = vector3(-1375.461, -8.303722, 51.75838),
        ['object'] = nil,
        ['egzist'] = false,
        ['amount'] = 3000,
    },
    [15] = {
        ['coords'] = vector3(-1394.055, 2.053863, 51.22115),
        ['object'] = nil,
        ['egzist'] = false,
        ['amount'] = 3000,
    },
    [16] = {
        ['coords'] = vector3(-1385.261, 59.83957, 51.87772),
        ['object'] = nil,
        ['egzist'] = false,
        ['amount'] = 3000,
    },
    [17] = {
        ['coords'] = vector3(-1400.485, 114.5577, 51.87067),
        ['object'] = nil,
        ['egzist'] = false,
        ['amount'] = 3000,
    },
    [18] = {
        ['coords'] = vector3(-1069.892, -122.4884, 39.23672),
        ['object'] = nil,
        ['egzist'] = false,
        ['amount'] = 3000,
    },
    [19] = {
        ['coords'] = vector3(-1009.949, -18.46276, 44.75943),
        ['object'] = nil,
        ['egzist'] = false,
        ['amount'] = 3000,
    },
    [20] = {
        ['coords'] = vector3(-1269.022, 17.63568, 46.08694),
        ['object'] = nil,
        ['egzist'] = false,
        ['amount'] = 3000,
    },
}


Config.Uniforms = {
	worker = {
		male = {
			tshirt_1 = 12,  tshirt_2 = 2,
			torso_1 = 12,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 12,
			pants_1 = 5,   pants_2 = 0,
			shoes_1 = 4,   shoes_2 = 0,
			helmet_1 = 2,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
}


--[[


RegisterCommand("ezz", function()
    for k, v in pairs(Config.Locations) do
        Config.Locations[k].object = CreateObject(Config.Grasses[1].chwast, Config.Locations[k].coords.x, Config.Locations[k].coords.y, Config.Locations[k].coords.z, false, false, false)        
        Config.Locations[k].object = CreateObject(Config.Grasses[2].chwast, Config.Locations[k].coords.x, Config.Locations[k].coords.y, Config.Locations[k].coords.z, false, false, false)        
        addblip(Config.Locations[k].coords)
    end
end)

test blipem lokalizacji by dobrze i równo ułożyć




]]