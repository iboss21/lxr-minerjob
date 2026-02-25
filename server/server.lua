--[[
    🐺 wolves.land — The Land of Wolves | LXR Miner Job
    Server Script — Multi-Framework
    Developer: iBoss21 / The Lux Empire
    © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
]]

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ FRAMEWORK BRIDGE (SERVER) █████████████████████████████
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
        print(('[lxr-minerjob] Server framework detected: %s'):format(FrameworkName))
    end
end

-- ─── Server → Client Notification Bridge ─────────────────────────────────────
local function SendNotification(source, msg, duration, notifType)
    duration  = duration  or 5000
    notifType = notifType or 'inform'

    if FrameworkName == 'vorp_core' then
        TriggerClientEvent('vorp:TipRight', source, msg, duration)
    elseif FrameworkName == 'lxr-core' or FrameworkName == 'rsg-core' then
        -- Relay to client for ox_lib / framework notify
        TriggerClientEvent('lxr-minerjob:client:notify', source, msg, duration, notifType)
    else
        -- RedEM:RP / standalone fallback
        TriggerClientEvent("redemrp_notification:start", source, msg, math.floor(duration / 1000))
    end
end

-- ─── Get Player Job ───────────────────────────────────────────────────────────
local function GetPlayerJob(source, callback)
    if FrameworkName == 'lxr-core' then
        local Player = exports['lxr-core']:GetPlayer(source)
        if Player then
            callback(Player.PlayerData.job.name)
        else
            callback(nil)
        end

    elseif FrameworkName == 'rsg-core' then
        local Player = exports['rsg-core']:GetPlayer(source)
        if Player then
            callback(Player.PlayerData.job.name)
        else
            callback(nil)
        end

    elseif FrameworkName == 'vorp_core' then
        local User = exports.vorp_core:GetUser(source)
        if User then
            local Character = User.getUsedCharacter
            if Character then
                callback(Character.job)
            else
                callback(nil)
            end
        else
            callback(nil)
        end

    elseif FrameworkName == 'redem_roleplay' then
        TriggerEvent('redemrp:getPlayerFromId', source, function(user)
            if user then
                callback(user.getJob())
            else
                callback(nil)
            end
        end)

    else
        -- Standalone: no job check — allow all
        callback(Config.JobName)
    end
end

-- ─── Add Money ────────────────────────────────────────────────────────────────
local function AddMoney(source, amount)
    if FrameworkName == 'lxr-core' then
        local Player = exports['lxr-core']:GetPlayer(source)
        if Player then Player.Functions.AddMoney('cash', amount) end

    elseif FrameworkName == 'rsg-core' then
        local Player = exports['rsg-core']:GetPlayer(source)
        if Player then Player.Functions.AddMoney('cash', amount) end

    elseif FrameworkName == 'vorp_core' then
        local User = exports.vorp_core:GetUser(source)
        if User then
            local Character = User.getUsedCharacter
            if Character then Character.addCurrency(0, amount) end
        end

    elseif FrameworkName == 'redem_roleplay' then
        TriggerEvent('redemrp:getPlayerFromId', source, function(user)
            if user then user.addMoney(amount) end
        end)

    else
        -- Standalone: log reward only
        if Config.Debug then
            print(('[lxr-minerjob] Standalone: would pay source %d amount $%d'):format(source, amount))
        end
    end
end

-- ─── Add XP ───────────────────────────────────────────────────────────────────
local function AddXP(source, amount)
    -- XP is only natively supported by RedEM:RP; ignored on other frameworks
    if FrameworkName == 'redem_roleplay' then
        TriggerEvent('redemrp:getPlayerFromId', source, function(user)
            if user then user.addXP(amount) end
        end)
    else
        if Config.Debug then
            print(('[lxr-minerjob] XP reward (%d) skipped — not supported by framework: %s'):format(amount, FrameworkName))
        end
    end
end

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ INIT ██████████████████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        InitFramework()
    end
end)

InitFramework()

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ SERVER EVENTS █████████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

-- Player requests to start the mining job
RegisterServerEvent('lxr-minerjob:server:startJob')
AddEventHandler('lxr-minerjob:server:startJob', function()
    local src = source
    GetPlayerJob(src, function(job)
        if job == Config.JobName then
            TriggerClientEvent('lxr-minerjob:client:jobStart', src)
            SendNotification(src, Language.translate[Config.Lang]['gopos'], 5000, 'inform')
        else
            SendNotification(src, Language.translate[Config.Lang]['nojob'], 5000, 'error')
        end
    end)
end)

-- Player collects payment after delivery
RegisterServerEvent('lxr-minerjob:server:collectPay')
AddEventHandler('lxr-minerjob:server:collectPay', function(dinero, xp)
    local src = source

    -- Basic server-side sanity check
    if type(dinero) ~= 'number' or type(xp) ~= 'number' then return end
    if dinero < 0 or dinero > Config.Money.max * 2 then return end
    if xp    < 0 or xp    > Config.XP.max    * 2 then return end

    AddMoney(src, dinero)
    AddXP(src, xp)
end)
