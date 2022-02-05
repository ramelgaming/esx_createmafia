ESX = nil 
local display = false
local isInMarker = false
local isCreating = false
local hasAlreadyEnteredMarker = false
local isMenuOpened = false
local meas = 0

local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(500)
	end

	while ESX.GetPlayerData().gang == nil do
		Citizen.Wait(500)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('esx:setGang')
AddEventHandler('esx:setGang', function(job)
  PlayerData.gang = gang
end)

RegisterNUICallback("exit", function(data)
    SetDisplay(false)
    isMenuOpened = false
end)


function SetDisplay(bool)
	ESX.TriggerServerCallback('exp:exp', function(cb)
		display = bool
		SetNuiFocus(bool, bool)
		SendNUIMessage({
			type = "ui",
			status = bool,
			experience = cb,
			gangmuch = Config.GangCriminalAmount,
		})
	end)
end

Citizen.CreateThread(function()
    Citizen.Wait(500)
    local model = GetHashKey('cs_fbisuit_01')
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(500)
    end
    Ped = CreatePed(1, model, 468.16, -728.86,27.37 -1, 141.0, false, true)

    FreezeEntityPosition(Ped, true)
    SetEntityCanBeDamaged(Ped, false)
    SetPedDefaultComponentVariation(Ped)
    SetPedStealthMovement(Ped,true,0)
    SetBlockingOfNonTemporaryEvents(Ped, true);
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)

		local coords = GetEntityCoords(PlayerPedId())
		isInMarker = false

		for k,v in pairs (Config.Location) do
            local marker = Config.Location.Marker
			local distance = GetDistanceBetweenCoords(coords, marker.Pos, true)

            if not(isMenuOpened) then

              if distance < (2.0) and not (isCreating) then
                 isInMarker = true
                ESX.ShowHelpNotification('Press ~y~E ~w~To ~r~Create A Family')
               end
            end

		end

        if IsControlJustReleased(0, 38) and isInMarker and not (isCreating) then
			MafiaCreationProcess()
			Citizen.Wait(500)
		end
	end
	Citizen.Wait(500)
end)

function MafiaCreationProcess()
	function MafiaCreationProcess()
		if PlayerData.job ~= nil and PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'ambulance' then 
			SetDisplay(not display) 
			isMenuOpened = true
		else
			ESX.ShowNotification("~r~Error: ~w~You can not create a Family because of your job")
		end
	end
end

function Draw3DText(x, y, z, scl_factor, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        SetTextScale(0.0, 0.4)
        SetTextFont(0)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

--[[function DisplayBlips()

    for k,v in pairs (Config.Location) do
		local blip = AddBlipForCoord(Config.Location.Blip.Pos)
		SetBlipSprite (blip, v.Sprite)
		SetBlipDisplay(blip, v.Display)
		SetBlipScale  (blip, Config.Location.Blip.Size)
		SetBlipColour (blip, Config.Location.Blip.Color)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName('Gunshop')
		EndTextCommandSetBlipName(blip)
	end

end--]]

RegisterNUICallback("gangmake", function(data)
    if not string.find(data.text, " ") then
		ESX.TriggerServerCallback('family:canhecreate', function(hecan)
			if hecan then
				ESX.TriggerServerCallback('hasmoney:create', function(hehas)
					if hehas then
						isCreating = true
						TriggerServerEvent("createfam:family", data.text, 'gang')
						TriggerServerEvent("Familygrades:ganggrades", data.text)
						TriggerServerEvent("familymake:bigsocities", data.text)
						Citizen.Wait(5000)
						TriggerServerEvent('esx:refreshgangs')
						Citizen.Wait(1000)
						TriggerServerEvent('createFamily:setplayercreatedjob', data.text, 4)
						SetDisplay(false)
						isCreating = false
					else
						ESX.ShowNotification("~r~Error: ~w~Not Enough Experience")
						SetDisplay(false)
						return
					end
				end, Config.GangAmount)
			end
		end, data.text)
	else
		ESX.ShowNotification('~r~Error: ~w~No Blank in your Gang Name!')
	end
end)

RegisterNUICallback("mafiamake", function(data)
    if not string.find(data.text, " ") then
		ESX.TriggerServerCallback('family:canhecreate', function(hecan)
			if hecan then
				ESX.TriggerServerCallback('hasmoney:create', function(hehas)
					if hehas then
						isCreating = true
						TriggerServerEvent("createfam:family", data.text, 'mafia')
						TriggerServerEvent("Familygrades:ganggrades", data.text)
						TriggerServerEvent("familymake:bigsocities", data.text)
						Citizen.Wait(5000)
						TriggerServerEvent('esx:refreshgangs')
						Citizen.Wait(1000)
						TriggerServerEvent('createFamily:setplayercreatedjob', data.text, 4)
						SetDisplay(false)
						isCreating = false
					else
						ESX.ShowNotification("~r~Error: ~w~Not Enough Experience")
						SetDisplay(false)
						return
					end
				end, Config.GangAmount)
			end
		end, data.text)
	else
		ESX.ShowNotification('~r~Error: ~w~No Blank in your Mafia Name!')
	end
end)

RegisterNUICallback("cartelmake", function(data)
    if not string.find(data.text, " ") then
		ESX.TriggerServerCallback('family:canhecreate', function(hecan)
			if hecan then
				ESX.TriggerServerCallback('hasmoney:create', function(hehas)
					if hehas then
						isCreating = true
						TriggerServerEvent("createfam:family", data.text, 'cartel')
						TriggerServerEvent("Familygrades:ganggrades", data.text)
						TriggerServerEvent("familymake:bigsocities", data.text)
						Citizen.Wait(5000)
						TriggerServerEvent('esx:refreshgangs')
						Citizen.Wait(1000)
						TriggerServerEvent('createFamily:setplayercreatedjob', data.text, 4)
						SetDisplay(false)
						isCreating = false
					else
						ESX.ShowNotification("~r~Error: ~w~Not Enough Experience")
						SetDisplay(false)
						return
					end
				end, Config.CartelAmount)
			end
		end, data.text)
	else
		ESX.ShowNotification('~r~Error: ~w~No Blank in your Cartel Name!')
	end
end)