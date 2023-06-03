local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('QBCore:Client:UpdateObject', function() QBCore = exports['qb-core']:GetCoreObject() end)
Peds = {}
Targets = {}

--==== [ FUNCTIONS ] ====--
function loadAnimDict(dict)	
  if Config.Debug then 
      print("^5Debug^7: ^2Loading Anim Dictionary^7: '^6"..dict.."^7'") 
  end 
  while not HasAnimDictLoaded(dict) do 
      RequestAnimDict(dict) Wait(5) 
  end 
end

function unloadAnimDict(dict) 
  if Config.Debug then 
      print("^5Debug^7: ^2Removing Anim Dictionary^7: '^6"..dict.."^7'") 
  end 
  RemoveAnimDict(dict) 
end

function loadModel(entity)
  if Config.Debug then 
      print("^5Debug^7: ^2Loading Model^7: '^6"..entity.."^7'") 
  end 
  while not HasModelLoaded(entity) do
      RequestModel(entity) Wait(5) 
  end
end

function unloadModel(entity) 
  if Config.Debug then 
      print("^5Debug^7: ^2Removing Model^7: '^6"..entity.."^7'") 
  end 
  SetModelAsNoLongerNeeded(entity) 
end

function setPed(model, coords, freeze, collision, scenario, anim)
	loadModel(model)
	local ped = CreatePed(0, model, coords.x, coords.y, coords.z-1.03, coords.w, false, false)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, freeze or true)
    if collision then SetEntityNoCollisionEntity(ped, PlayerPedId(), false) end
    if scenario then TaskStartScenarioInPlace(ped, scenario, 0, true) end
    if anim then
        loadAnimDict(anim[1])
        TaskPlayAnim(ped, anim[1], anim[2], 1.0, 1.0, -1, 1, 0.2, 0, 0, 0)
    end
	if Config.Debug then print("^5Debug^7: ^6Ped ^2Created for location^7: '^6"..model.."^7'") end
    return ped
end

local countdownActive = false

function StartRentalCountdown(rentalTime)
  if countdownActive then
    return
  end
  countdownActive = true

  remainingTime = tonumber(rentalTime) * 60

  while remainingTime > 0 do
    Citizen.Wait(1000)
    remainingTime = remainingTime - 1

    exports['qb-core']:DrawText('Remaining time: ' .. remainingTime .. ' seconds', 'right')
  end

  -- Rental time expired, perform any necessary actions here
  countdownActive = false
  exports['qb-core']:HideText()
  TriggerEvent("qb-rental:noRemainingTime")
end

function StopRentalCountdown()
  remainingTime = 0
  countdownActive = false
  exports['qb-core']:HideText()
end

--==== [ END FUNCTIONS ] ====--

--==== [ EVENTS ] ====--
RegisterNetEvent("qb-rental:vehiclelist", function()
  for i = 1, #Config.vehicleList do
    if Config.Debug then print("^5Debug^7: ^6Vehicle ^2Created for location^7: '^6"..Config.vehicleList[i].model.."^7'") end
      if Config.setupMenu == 'nh-context' then
        TriggerEvent('nh-context:sendMenu', {
          {
            id = Config.vehicleList[i].model,
            header = Config.vehicleList[i].name,
            txt = "$"..Config.vehicleList[i].price..".00",
            params = {
              event = "qb-rental:attemptvehiclespawn",
              args = {
                id = Config.vehicleList[i].model,
                price = Config.vehicleList[i].price,
              }
            }
          },
        })
      elseif Config.setupMenu == 'qb-menu' then
        	local MenuOptions = {
        		{
        			header = "Vehicle Rental",
        			isMenuHeader = true
        		},
        	}
        	for k, v in pairs(Config.vehicleList) do
          
          
        		MenuOptions[#MenuOptions+1] = {
        			header = "<h8>"..v.name.."</h>",
              txt = "$"..v.price..".00",
        			params = {
                event = "qb-rental:attemptvehiclespawn",
                args = {
                  id = v.model,
                  price = v.price
                }
        			}
        		}
        	end
        	exports['qb-menu']:openMenu(MenuOptions)
      end
    end
end)

RegisterNetEvent("qb-rental:attemptvehiclespawn", function(vehicle)
  for i, v in ipairs(Config.vehicleSpawn) do
    if DoesEntityExist(GetClosestVehicle(v.workSpawn.coords.x, v.workSpawn.coords.y, v.workSpawn.coords.z, 3.0, 0, 70)) then
      QBCore.Functions.Notify("There is a vehicle nearby, please move it.", "error")
      return
    end
  end

  local dialog = exports['qb-input']:ShowInput({
    header = "REDEMTION CITY REBORN",
    submitText = "Rent Now",
    inputs = {
      {
        text = "Choose Rental Time",
        name = "carrentaltime",
        type = "select",
        options = Config.rentalTimes,
        default = 1,
      }
    },
  })
  
  if dialog ~= nil then
    local selectedValue = tonumber(dialog.carrentaltime)
    local selectedOption = nil
  
    for _, option in ipairs(Config.rentalTimes) do
      if option.value == selectedValue then
        selectedOption = option
        break
      end
    end
  
    if selectedOption ~= nil then
      local selectedFee = selectedOption.fees
      TriggerServerEvent("qb-rental:attemptPurchase", vehicle.id, vehicle.price, selectedValue, selectedFee)
    else
      print("Invalid rental time selected.")
    end
  else
    print("Rental dialog was canceled.")
  end
  
end)

RegisterNetEvent("qb-rental:attemptvehiclespawnfail", function()
  QBCore.Functions.Notify("Not enough money.", "error")
end)

local PlayerName = nil

RegisterNetEvent("qb-rental:returnvehicle", function()
  local car = GetVehiclePedIsIn(PlayerPedId(),true)

  if car ~= 0 then
    local plate = GetVehicleNumberPlateText(car)
    local vehname = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(car)))
    if string.find(tostring(plate), Config.RentalPlateMark) then
      QBCore.Functions.TriggerCallback('qb-rental:server:hasrentalpapers', function(HasItem)
        if HasItem then
          TriggerServerEvent('qb-rental:server:payreturn',vehname)
          QBCore.Functions.DeleteVehicle(car)
          StopRentalCountdown()
        else
          QBCore.Functions.Notify("I cannot take a vehicle without its papers.", "error")
        end
      end)
    else
      QBCore.Functions.Notify("This is not a rented vehicle.", "error")
    end

  else
    QBCore.Functions.Notify("I don't see any rented vehicle, make sure its nearby.", "error")
  end
end)

RegisterNetEvent('qb-rental:noRemainingTime', function()
  local car = GetVehiclePedIsIn(PlayerPedId(), true)

  if car ~= 0 then
    local plate = GetVehicleNumberPlateText(car)
    if string.find(tostring(plate), Config.RentalPlateMark) then
      QBCore.Functions.TriggerCallback('qb-rental:server:hasrentalpapers', function(HasItem) 
        if HasItem then
          TriggerServerEvent('qb-rental:server:notimereturn')
          QBCore.Functions.DeleteVehicle(car)
          StopRentalCountdown()
        end
      end)
    end
  end
end)

RegisterNetEvent("qb-rental:vehiclespawn", function(data, minute)
  local model = data

  local closestDist = 10000
  local closestSpawn = nil
  local pcoords = GetEntityCoords(PlayerPedId())
  local CurrentPlate = nil

  for i, v in ipairs(Config.vehicleSpawn) do
    local dist = #(v.workSpawn.coords - pcoords)
  
    if dist < closestDist then
        closestDist = dist
        closestSpawn = v.workSpawn
    end
  end

  RequestModel(model)
  while not HasModelLoaded(model) do
      Citizen.Wait(0)
  end
  SetModelAsNoLongerNeeded(model)

  QBCore.Functions.SpawnVehicle(model, function(veh)
    SetVehicleNumberPlateText(veh, Config.RentalPlateMark..tostring(math.random(1000, 9999)))
    SetEntityHeading(veh, closestSpawn.heading)
    exports['LegacyFuel']:SetFuel(veh, 100.0)
    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
    SetEntityAsMissionEntity(veh, true, true)
    TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
    SetVehicleEngineOn(veh, true, true)
    CurrentPlate = QBCore.Functions.GetPlate(veh)
  end, closestSpawn.coords, true)

  TriggerServerEvent("qb-rental:giverentalpaperServer", model, CurrentPlate)
  StartRentalCountdown(minute)
  if Config.Debug then print("^5Debug^7: ^6Vehicle ^2Spawned^7: '^6"..model.."^7'".." ^6Plate^7: '^6"..CurrentPlate.."^7'") end
  local timeout = 10
  while not NetworkDoesEntityExistWithNetworkId(veh) and timeout > 0 do
      timeout = timeout - 1
      Wait(1000)
  end
end)

--==== [ END OF EVENTS ] ====--

--==== [ THREADS ] ====--
CreateThread(function()
  for _, rental in pairs(Config.Locations["rentalstations"]) do
    if Config.Debug then print("^5Debug^7: ^6Blip ^2Created for location^7: '^6"..rental.label.."^7'") end
    if Config.Blip then
      local blip = AddBlipForCoord(rental.coords.x, rental.coords.y, rental.coords.z)
      SetBlipSprite(blip, 326)
      SetBlipAsShortRange(blip, true)
      SetBlipScale(blip, 0.5)
      SetBlipColour(blip, 5)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(rental.label)
      EndTextCommandSetBlipName(blip)
    end
  end
end)

CreateThread(function()
  for _, rental in pairs(Config.Locations["rentalstations"]) do
    Peds[#Peds+1] = setPed(rental.model, rental.coords, true, false, rental.scenario)
    if Config.Debug then print("^5Debug^7: ^6Ped ^2Created for location^7: '^6"..rental.label.."^7'") end
    Targets['rental'.._] = exports['qb-target']:AddCircleZone("rental".._, rental.coords, 1.0, {
      name = "rental".._,
      debugPoly = Config.Debug,
      useZ = true,
      }, {
        options = {
            {
                event = "qb-rental:vehiclelist",
                icon = "fas fa-circle",
                label = "Rent vehicle",
            },
            {
                event = "qb-rental:returnvehicle",
                icon = "fas fa-circle",
                label = "Return Vehicle (Receive Back 50% of original price)",
            },
        },
      distance = 3.5
    })
  end
end)

--==== [ END OF THREADS ] ====--

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then end
    for k in pairs(Peds) do DeleteEntity(Peds[k]) end
    for k in pairs(Targets) do exports['qb-target']:RemoveZone(k) end
    exports['qb-core']:HideText()
end)