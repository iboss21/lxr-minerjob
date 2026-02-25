--[[
    🐺 wolves.land — The Land of Wolves | LXR Miner Job
    Client Script — Multi-Framework
    Developer: iBoss21 / The Lux Empire
    © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
]]

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ FRAMEWORK BRIDGE (CLIENT) █████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

local FrameworkName = nil

local function InitFramework()
    if Config.Framework ~= 'auto' then
        FrameworkName = Config.Framework
        return
    end
    if GetResourceState('lxr-core') == 'started' then
        FrameworkName = 'lxr-core'
    elseif GetResourceState('rsg-core') == 'started' then
        FrameworkName = 'rsg-core'
    elseif GetResourceState('vorp_core') == 'started' then
        FrameworkName = 'vorp_core'
    elseif GetResourceState('redem_roleplay') == 'started' then
        FrameworkName = 'redem_roleplay'
    else
        FrameworkName = 'standalone'
    end
    if Config.Debug then
        print(('[lxr-minerjob] Client framework detected: %s'):format(FrameworkName))
    end
end

-- ─── Notification Bridge ──────────────────────────────────────────────────────
local function Notify(msg, duration, notifType)
    duration  = duration  or 5000
    notifType = notifType or 'inform'

    if FrameworkName == 'lxr-core' or FrameworkName == 'rsg-core' then
        if GetResourceState('ox_lib') == 'started' then
            lib.notify({ title = Config.ServerInfo.name, description = msg, type = notifType, duration = duration })
        else
            TriggerEvent("redemrp_notification:start", msg, math.floor(duration / 1000))
        end
    elseif FrameworkName == 'vorp_core' then
        TriggerEvent('vorp:TipRight', msg, duration)
    else
        -- RedEM:RP / standalone fallback
        TriggerEvent("redemrp_notification:start", msg, math.floor(duration / 1000))
    end
end

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ JOB STATE ████████████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

local dinero       = math.random(Config.Money.min, Config.Money.max)
local xp           = math.random(Config.XP.min,    Config.XP.max)
local PrimeraMina  = false
local Mina1        = false
local Mina2        = false
local Mina3        = false
local Mina4        = false
local FinMina      = false
local Entrega      = false
local spawncar     = nil
local blip, blip2, blip3, blip4, blip5, blip6

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ HELPERS ███████████████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

local function L(key)
    local lang = Language.translate[Config.Lang] or Language.translate['en']
    return lang[key] or key
end

local function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local s = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    Citizen.InvokeNative(0xADA9255D, 1)
    DisplayText(s, x, y)
end

function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ ANIMATIONS ███████████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

local function animacion()
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_PICKAXE_WALL'), Config.Timers.miningDuration, true, false, false, false)
    exports['progressBars']:startUI(Config.Timers.miningDuration, L('mining'))
    Wait(Config.Timers.miningDuration)
    ClearPedTasksImmediately(PlayerPedId())
end

local function animacion2()
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('PROP_HUMAN_SACK_STORAGE_IN'), Config.Timers.loadDuration, true, false, false, false)
    exports['progressBars']:startUI(Config.Timers.loadDuration, L('placing'))
    Wait(Config.Timers.loadDuration)
    ClearPedTasksImmediately(PlayerPedId())
end

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ INIT BLIP ████████████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Citizen.CreateThread(function()
    InitFramework()
    blip = N_0x554d9d53f696d002(1664425300, Config.Zones['init'].x, Config.Zones['init'].y, Config.Zones['init'].z)
    SetBlipSprite(blip, -1852063472, 1)
end)

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ MAIN INTERACTION LOOP █████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local pos = GetEntityCoords(PlayerPedId())

        -- Start job zone
        if Vdist(pos.x, pos.y, pos.z, Config.Zones['init'].x, Config.Zones['init'].y, Config.Zones['init'].z) < 3.0 then
            if Mina1 == false then
                DrawTxt(L('press'), 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    TriggerServerEvent('lxr-minerjob:server:startJob')
                end
            end
        end

        -- Mine spot 1
        if PrimeraMina == true then
            if Vdist(pos.x, pos.y, pos.z, Config.Zones['Miner1'].x, Config.Zones['Miner1'].y, Config.Zones['Miner1'].z) < 3.0 then
                DrawTxt(L('press'), 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    animacion()
                    Notify(L('goto'), 5000)
                    RemoveBlip(blip)
                    blip2 = N_0x554d9d53f696d002(203020899, Config.Zones['Miner2'].x, Config.Zones['Miner2'].y, Config.Zones['Miner2'].z)
                    SetBlipSprite(blip2, -570710357, 1)
                    PrimeraMina = false
                    Mina2 = true
                end
            end

        -- Mine spot 2
        elseif Mina2 == true then
            if Vdist(pos.x, pos.y, pos.z, Config.Zones['Miner2'].x, Config.Zones['Miner2'].y, Config.Zones['Miner2'].z) < 3.0 then
                DrawTxt(L('press'), 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    animacion()
                    Notify(L('goto'), 5000)
                    RemoveBlip(blip2)
                    blip3 = N_0x554d9d53f696d002(203020899, Config.Zones['Miner3'].x, Config.Zones['Miner3'].y, Config.Zones['Miner3'].z)
                    SetBlipSprite(blip3, -570710357, 1)
                    Mina2 = false
                    Mina3 = true
                end
            end

        -- Mine spot 3
        elseif Mina3 == true then
            if Vdist(pos.x, pos.y, pos.z, Config.Zones['Miner3'].x, Config.Zones['Miner3'].y, Config.Zones['Miner3'].z) < 3.0 then
                DrawTxt(L('press'), 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    animacion()
                    Notify(L('goto'), 5000)
                    RemoveBlip(blip3)
                    blip4 = N_0x554d9d53f696d002(203020899, Config.Zones['Miner4'].x, Config.Zones['Miner4'].y, Config.Zones['Miner4'].z)
                    SetBlipSprite(blip4, -570710357, 1)
                    Mina3 = false
                    Mina4 = true
                end
            end

        -- Mine spot 4 — load vehicle
        elseif Mina4 == true then
            if Vdist(pos.x, pos.y, pos.z, Config.Zones['Miner4'].x, Config.Zones['Miner4'].y, Config.Zones['Miner4'].z) < 3.0 then
                DrawTxt(L('press'), 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    animacion()
                    Notify(L('load'), 5000)
                    RemoveBlip(blip4)
                    blip5 = N_0x554d9d53f696d002(203020899, Config.Zones['Vehicle'].x, Config.Zones['Vehicle'].y, Config.Zones['Vehicle'].z)
                    SetBlipSprite(blip5, -570710357, 1)
                    TriggerEvent('lxr-minerjob:client:spawnVehicle')
                    Mina4 = false
                    FinMina = true
                end
            end

        -- Vehicle load zone
        elseif FinMina == true then
            if Vdist(pos.x, pos.y, pos.z, Config.Zones['Vehicle'].x, Config.Zones['Vehicle'].y, Config.Zones['Vehicle'].z) < 3.0 then
                DrawTxt(L('pressc'), 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    animacion2()
                    Notify(L('carry'), 5000)
                    RemoveBlip(blip5)
                    blip6 = N_0x554d9d53f696d002(203020899, Config.Zones['Entrega'].x, Config.Zones['Entrega'].y, Config.Zones['Entrega'].z)
                    SetBlipSprite(blip6, -570710357, 1)
                    FinMina = false
                    Entrega = true
                    TriggerEvent('lxr-minerjob:client:startTimer')
                end
            end

        -- Delivery zone
        elseif Entrega == true then
            if Vdist(pos.x, pos.y, pos.z, Config.Zones['Entrega'].x, Config.Zones['Entrega'].y, Config.Zones['Entrega'].z) < 3.0 then
                DrawTxt(L('pressf'), 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    if IsPedInAnyVehicle(PlayerPedId(), true) then
                        DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                        Notify(L('completejob') .. dinero .. '$ | ' .. xp .. 'XP', 5000, 'success')
                        RemoveBlip(blip6)
                        TriggerServerEvent('lxr-minerjob:server:collectPay', dinero, xp)
                        Entrega = false
                        Mina1   = false
                    else
                        Notify(L('noveh'), 5000, 'error')
                    end
                end
            end
        end
    end
end)

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ NET EVENTS ████████████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

RegisterNetEvent('lxr-minerjob:client:jobStart')
AddEventHandler('lxr-minerjob:client:jobStart', function()
    dinero = math.random(Config.Money.min, Config.Money.max)
    xp     = math.random(Config.XP.min,    Config.XP.max)
    blip = N_0x554d9d53f696d002(203020899, Config.Zones['Miner1'].x, Config.Zones['Miner1'].y, Config.Zones['Miner1'].z)
    SetBlipSprite(blip, -570710357, 1)
    PrimeraMina = true
    Mina1       = true
end)

RegisterNetEvent('lxr-minerjob:client:notify')
AddEventHandler('lxr-minerjob:client:notify', function(msg, duration, notifType)
    Notify(msg, duration, notifType)
end)

-- Local event: spawn vehicle at vehicle zone
RegisterNetEvent('lxr-minerjob:client:spawnVehicle')
AddEventHandler('lxr-minerjob:client:spawnVehicle', function()
    local jugador  = PlayerPedId()
    local vehiculo = GetHashKey(Config.Vehiculo)
    RequestModel(vehiculo)
    while not HasModelLoaded(vehiculo) do
        Citizen.Wait(0)
    end
    spawncar = CreateVehicle(vehiculo, Config.Zones['Vehicle'].x, Config.Zones['Vehicle'].y, Config.Zones['Vehicle'].z, Config.Zones['Vehicle'].heading, true, false)
    SetVehicleOnGroundProperly(spawncar)
    SetModelAsNoLongerNeeded(vehiculo)
end)

-- Local event: delivery countdown timer
RegisterNetEvent('lxr-minerjob:client:startTimer')
AddEventHandler('lxr-minerjob:client:startTimer', function()
    local timer = Config.Timers.deliveryTimer

    Citizen.CreateThread(function()
        while timer > 0 and Entrega do
            Citizen.Wait(1000)
            if timer > 0 then timer = timer - 1 end
        end
    end)

    Citizen.CreateThread(function()
        while Entrega do
            Citizen.Wait(0)
            DrawTxt(L('temp') .. timer .. L('seconds'), 0.4, 0.92, 0.4, 0.4, true, 255, 255, 255, 150, false)
            if timer < 1 then
                Notify(L('lose'), 5000, 'error')
                Mina1, Mina2, Mina3, Mina4, FinMina, Entrega, PrimeraMina = false, false, false, false, false, false, false
                if spawncar then DeleteVehicle(spawncar) end
                RemoveBlip(blip6)
                SetEntityCoords(PlayerPedId(), Config.Zones['Vehicle'].x, Config.Zones['Vehicle'].y, Config.Zones['Vehicle'].z)
            end
        end
    end)
end)
