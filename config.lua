Config = {}

Config.setupMenu = 'qb-menu' -- qb-menu / nh-context
Config.Debug = false -- Debug Mode
Config.Blip = false -- Blip on Map
Config.RentalPlateMark = "TC" -- This is a Prefix for the Plate of the Vehicle

-- List of vehicles that can be rented
--@param name = The name of the vehicle, this will be displayed in the menu
--@param model = The model of the vehicle (https://wiki.rage.mp/index.php?title=Vehicles)
--@param price = The price of the vehicle
--@description = You can add as many vehicles as you want, just make sure you add a comma after the last bracket.
Config.vehicleList = {
    { name = "Bison", model = "bison", price = 300 },
    { name = "Futo", model = "Futo", price = 250 },
    { name = "Coach", model = "coach", price = 400 },
    { name = "Tour bus", model = "tourbus", price = 600 },
    { name = "Taco", model = "taco", price = 420 },
    { name = "Limo", model = "stretch", price = 1250 },
    { name = "Hearse", model = "romero", price = 1300 },
    { name = "Clown Car", model = "speedo2", price = 2850 },
    { name = "Festival Bus", model = "pbus2", price = 4500 },
}

-- Set the rental times and additonal fees
--@param value = The value of the rental time
--@param text = The text of the rental time, this will be displayed in the menu
--@param fees = The additional fees for the rental time
--@description = You can add as many rental times as you want, just make sure you add a comma after the last bracket.
Config.rentalTimes = {
    { value = 1, text = '1 Minute', fees = 100 },
    { value = 5, text = '5 Minutess', fees = 250 },
    { value = 10, text = '10 Minutes', fees = 380 },
    { value = 15, text = '15 Minutes', fees = 400 },
    { value = 25, text = '25 Minutes', fees = 550 },
}

-- Set the locations for the rental stations
--@param label = The name of the rental station, this will be displayed on the map
--@param coords = The coords of the rental station
--@param model = The model of the ped (https://docs.fivem.net/docs/game-references/ped-models/)
--@param scenario = The scenario of the ped (https://pastebin.com/raw/6mrYTdQv)
--@description = You can add as many locations as you want, just make sure you add a comma after the last bracket. 
Config.Locations = {
    ["rentalstations"] = {
        [1] = { label = "Rental Stations", coords = vector4(-1042.35, -2727.65, 20.17, 334.69), model = `cs_carbuyer`, scenario = "WORLD_HUMAN_CLIPBOARD"},
        [2] = { label = "Rental Stations", coords = vector4(462.75, -1676.62, 29.29, 5.02), model = `cs_carbuyer`, scenario = "WORLD_HUMAN_CLIPBOARD"},
        [3] = { label = "Rental Stations", coords = vector4(-1442.49, -673.65, 26.53, 288.07), model = `cs_carbuyer`, scenario = "WORLD_HUMAN_CLIPBOARD"},
    },
}

-- Set the locations for the vehicle spawn points
--@param workSpawn = The coords of the vehicle spawn point
--@param heading = The heading of the vehicle spawn point
Config.vehicleSpawn = {
    --- Los Santos International Airport
	[1] = { 
		workSpawn = {
			coords = vector3(-1040.9, -2725.05, 20.12),
			heading = 239.44,
		},
	},
    -- Davis Avenue
    [2] = { 
        workSpawn = {
            coords = vector3(460.1, -1699.62, 29.3),
            heading = 323.94,
        },
    },
    -- Marathon Avenue
    [3] = { 
        workSpawn = {
            coords = vector3(-1444.12, -680.25, 26.39),
            heading = 122.5,
        },
    },
}