local QBCore = exports['qb-core']:GetCoreObject()

local weapons = {
	'WEAPON_KNIFE',
	'WEAPON_NIGHTSTICK',
	'WEAPON_BREAD',
	'WEAPON_KATANA',
	'WEAPON_HAMMER',
	'WEAPON_BAT',
	'WEAPON_GOLFCLUB',
	'WEAPON_CROWBAR',
	'WEAPON_BOTTLE',
	'WEAPON_DAGGER',
	'WEAPON_HATCHET',
	'WEAPON_MACHETE',
	'WEAPON_BATTLEAXE',
	'WEAPON_POOLCUE',
	'WEAPON_WRENCH',
	'WEAPON_PISTOL',
	'WEAPON_PISTOL_MK2',
	'WEAPON_COMBATPISTOL',
	'WEAPON_APPISTOL',
	'WEAPON_PISTOL50',
	'WEAPON_REVOLVER',
	'WEAPON_SNSPISTOL',
	'WEAPON_HEAVYPISTOL',
	'WEAPON_VINTAGEPISTOL',
	'WEAPON_MICROSMG',
	'WEAPON_SMG',
	'WEAPON_ASSAULTSMG',
	'WEAPON_MINISMG',
	'WEAPON_MACHINEPISTOL',
	'WEAPON_COMBATPDW',
	'WEAPON_PUMPSHOTGUN',
	'WEAPON_SAWNOFFSHOTGUN',
	'WEAPON_ASSAULTSHOTGUN',
	'WEAPON_BULLPUPSHOTGUN',
	'WEAPON_HEAVYSHOTGUN',
	'WEAPON_ASSAULTRIFLE',
	'WEAPON_CARBINERIFLE',
	'WEAPON_ADVANCEDRIFLE',
	'WEAPON_SPECIALCARBINE',
	'WEAPON_BULLPUPRIFLE',
	'WEAPON_COMPACTRIFLE',
	'WEAPON_MG',
	'WEAPON_COMBATMG',
	'WEAPON_GUSENBERG',
	'WEAPON_SNIPERRIFLE',
	'WEAPON_HEAVYSNIPER',
	'WEAPON_HEAVYSNIPER_MK2',
	'WEAPON_MARKSMANRIFLE',
	'WEAPON_GRENADELAUNCHER',
	'WEAPON_RPG',
	'WEAPON_STINGER',
	'WEAPON_MINIGUN',
	'WEAPON_GRENADE',
	'WEAPON_STICKYBOMB',
	'WEAPON_SMOKEGRENADE',
	'WEAPON_BZGAS',
	'WEAPON_MOLOTOV',
	'WEAPON_DIGISCANNER',
	'WEAPON_FIREWORK',
	'WEAPON_MUSKET',
	'WEAPON_STUNGUN',
	'WEAPON_HOMINGLAUNCHER',
	'WEAPON_PROXMINE',
	'WEAPON_FLAREGUN',
	'WEAPON_MARKSMANPISTOL',
	'WEAPON_RAILGUN',
	'WEAPON_DBSHOTGUN',
	'WEAPON_AUTOSHOTGUN',
	'WEAPON_COMPACTLAUNCHER',
	'WEAPON_PIPEBOMB',
	'WEAPON_DOUBLEACTION',
	'WEAPON_CERAMICPISTOL',
	'WEAPON_BROWNING',
	'WEAPON_DP9',
	'WEAPON_LTL',
	'WEAPON_NAVYREVOLVER',
	'WEAPON_GADGETPISTOL',
	'WEAPON_MILITARYRIFLE',
	'WEAPON_HEAVYRIFLE',
	'WEAPON_TACTICALRIFLE',
	'WEAPON_PRECISIONRIFLE',
}


local holsterableWeapons = {
	'WEAPON_STUNGUN',
	'WEAPON_PISTOL',
	'WEAPON_PISTOL_MK2',
	'WEAPON_COMBATPISTOL',
	'WEAPON_APPISTOL',
	'WEAPON_PISTOL50',
	'WEAPON_REVOLVER',
	'WEAPON_SNSPISTOL',
	'WEAPON_HEAVYPISTOL',
	'WEAPON_VINTAGEPISTOL',
	'WEAPON_CERAMICPISTOL',
	'WEAPON_NAVYREVOLVER',
	'WEAPON_GADGETPISTOL',
	
}

local holstered = true
local canFire = true
local currWeapon = GetHashKey('WEAPON_UNARMED')
local currentHoldster = nil

RegisterNetEvent('weapons:ResetHolster')
AddEventHandler('weapons:ResetHolster', function()
	holstered = true
	canFire = true
	currWeapon = GetHashKey('WEAPON_UNARMED')
	currentHoldster = nil
end)

Citizen.CreateThread(function()
	while true do
		local elwsPlayer = QBCore.Functions.GetPlayerData(src)
	if elwsPlayer.job.type == "leo" then
--[[ PDLER İÇİN SİLAH ÇEKME ANİMASYONU BURADA ]]
		local ped = PlayerPedId()
		if DoesEntityExist(ped) and not IsEntityDead(ped) then
			if currWeapon ~= GetSelectedPedWeapon(ped) then
				pos = GetEntityCoords(ped, true)
				rot = GetEntityHeading(ped)

				local newWeap = GetSelectedPedWeapon(ped)
				SetCurrentPedWeapon(ped, currWeapon, true)
				loadAnimDict("rcmjosh4")
				loadAnimDict("reaction@intimidation@cop@unarmed")
				if CheckWeapon(newWeap) then
					if holstered then
							canFire = false
							TaskPlayAnimAdvanced(ped, "reaction@intimidation@cop@unarmed", "intro", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(400)
							SetCurrentPedWeapon(ped, newWeap, true)
							currWeapon = newWeap
							Citizen.Wait(400)
							ClearPedTasks(ped)
							holstered = false
							canFire = true
					elseif newWeap ~= currWeapon and CheckWeapon(currWeapon) then
							canFire = false
							TaskPlayAnimAdvanced(ped, "reaction@intimidation@cop@unarmed", "outro", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(400)
							SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
							TaskPlayAnimAdvanced(ped, "reaction@intimidation@cop@unarmed", "intro", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(400)
							SetCurrentPedWeapon(ped, newWeap, true)
							currWeapon = newWeap
							Citizen.Wait(400)
							ClearPedTasks(ped)
							holstered = false
							canFire = true
					else
							SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
							TaskPlayAnimAdvanced(ped, "reaction@intimidation@cop@unarmed", "intro", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(1400)
							SetCurrentPedWeapon(ped, newWeap, true)
							currWeapon = newWeap
							Citizen.Wait(400)
							ClearPedTasks(ped)
							holstered = false
							canFire = true
					end
				else
					if not holstered and CheckWeapon(currWeapon) then
							canFire = false
							TaskPlayAnimAdvanced(ped, "reaction@intimidation@cop@unarmed", "outro", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(400)
							SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
							ClearPedTasks(ped)
							SetCurrentPedWeapon(ped, newWeap, true)
							holstered = true
							canFire = true
							currWeapon = newWeap
					else
						SetCurrentPedWeapon(ped, newWeap, true)
						holstered = false
						canFire = true
						currWeapon = newWeap
					end
				end
			end
		else
			Citizen.Wait(250)
		end

		Citizen.Wait(5)
	else
--[[ SİVİLLER İÇİN SİLAH ÇEKME ANİMASYONU BURADA ]]
		local ped = PlayerPedId()
		if DoesEntityExist(ped) and not IsEntityDead(ped) then
			if currWeapon ~= GetSelectedPedWeapon(ped) then
				pos = GetEntityCoords(ped, true)
				rot = GetEntityHeading(ped)

				local newWeap = GetSelectedPedWeapon(ped)
				SetCurrentPedWeapon(ped, currWeapon, true)
				loadAnimDict("reaction@intimidation@1h")
				loadAnimDict("rcmjosh4")
				loadAnimDict("weapons@pistol@")
				if CheckWeapon(newWeap) then
					if holstered then
							canFire = false
							TaskPlayAnimAdvanced(ped, "reaction@intimidation@1h", "intro", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(1000)
							SetCurrentPedWeapon(ped, newWeap, true)
							currWeapon = newWeap
							Citizen.Wait(1400)
							ClearPedTasks(ped)
							holstered = false
							canFire = true
					elseif newWeap ~= currWeapon and CheckWeapon(currWeapon) then
							canFire = false
							TaskPlayAnimAdvanced(ped, "reaction@intimidation@1h", "outro", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(1600)
							SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
							TaskPlayAnimAdvanced(ped, "reaction@intimidation@1h", "intro", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(1000)
							SetCurrentPedWeapon(ped, newWeap, true)
							currWeapon = newWeap
							Citizen.Wait(1400)
							ClearPedTasks(ped)
							holstered = false
							canFire = true
					else
							SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
							TaskPlayAnimAdvanced(ped, "reaction@intimidation@1h", "intro", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(1000)
							SetCurrentPedWeapon(ped, newWeap, true)
							currWeapon = newWeap
							Citizen.Wait(1400)
							ClearPedTasks(ped)
							holstered = false
							canFire = true
					end
				else
					if not holstered and CheckWeapon(currWeapon) then
							canFire = false
							TaskPlayAnimAdvanced(ped, "reaction@intimidation@1h", "outro", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(1400)
							SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
							ClearPedTasks(ped)
							SetCurrentPedWeapon(ped, newWeap, true)
							holstered = true
							canFire = true
							currWeapon = newWeap
					else
						SetCurrentPedWeapon(ped, newWeap, true)
						holstered = false
						canFire = true
						currWeapon = newWeap
					end
				end
			end
		else
			Citizen.Wait(250)
		end

		Citizen.Wait(5)
	end
	end
end)

Citizen.CreateThread(function()
	while true do
		if not canFire then
			DisableControlAction(0, 25, true)
			DisablePlayerFiring(PlayerPedId(), true)
		else
			Citizen.Wait(250)
		end

		Citizen.Wait(3)
	end
end)

function CheckWeapon(newWeap)
	for i = 1, #weapons do
		if GetHashKey(weapons[i]) == newWeap then
			return true
		end
	end
	return false
end

function IsWeaponHolsterable(weap)
	for i = 1, #holsterableWeapons do
		if GetHashKey(holsterableWeapons[i]) == weap then
			return true
		end
	end
	return false
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end