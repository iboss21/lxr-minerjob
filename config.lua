--[[
    ██╗     ██╗  ██╗██████╗       ███╗   ███╗██╗███╗   ██╗███████╗██████╗
    ██║     ╚██╗██╔╝██╔══██╗      ████╗ ████║██║████╗  ██║██╔════╝██╔══██╗
    ██║      ╚███╔╝ ██████╔╝█████╗██╔████╔██║██║██╔██╗ ██║█████╗  ██████╔╝
    ██║      ██╔██╗ ██╔══██╗╚════╝██║╚██╔╝██║██║██║╚██╗██║██╔══╝  ██╔══██╗
    ███████╗██╔╝ ██╗██║  ██║      ██║ ╚═╝ ██║██║██║ ╚████║███████╗██║  ██║
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝

     ██╗ ██████╗ ██████╗
     ██║██╔═══██╗██╔══██╗
     ██║██║   ██║██████╔╝
██   ██║██║   ██║██╔══██╗
╚█████╔╝╚██████╔╝██████╔╝
 ╚════╝  ╚═════╝ ╚═════╝

    🐺 LXR Core - Miner Job System

    This configuration file controls the miner job system for RedM.
    Players with the miner job can complete a multi-stage mining run,
    collect ore, load a cart, and deliver it for pay and XP rewards.

    ═══════════════════════════════════════════════════════════════════════════════
    SERVER INFORMATION
    ═══════════════════════════════════════════════════════════════════════════════

    Server:      The Land of Wolves 🐺
    Tagline:     Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!
    Description: ისტორია ცოცხლდება აქ! (History Lives Here!)
    Type:        Serious Hardcore Roleplay
    Access:      Discord & Whitelisted

    Developer:   iBoss21 / The Lux Empire
    Website:     https://www.wolves.land
    Discord:     https://discord.gg/CrKcWdfd3A
    GitHub:      https://github.com/iBoss21
    Store:       https://theluxempire.tebex.io
    Server:      https://servers.redm.net/servers/detail/8gj7eb

    ═══════════════════════════════════════════════════════════════════════════════

    Version: 2.0.0
    Performance Target: Optimized for minimal server overhead and client FPS impact

    Tags: RedM, Georgian, SeriousRP, Whitelist, MinerJob, Economy, Work

    Framework Support:
    - LXR Core (Primary)
    - RSG Core (Primary)
    - VORP Core (Supported / Legacy)
    - RedEM:RP (Optional / Legacy)
    - Standalone (Fallback)

    ═══════════════════════════════════════════════════════════════════════════════
    CREDITS
    ═══════════════════════════════════════════════════════════════════════════════

    Script Author:   iBoss21 / The Lux Empire for The Land of Wolves
    Original Author: PokeSerGG (poke_minerjob)
    Refactored by:   iBoss21 — wolves.land LXR style

    © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
]]

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 RESOURCE NAME PROTECTION - RUNTIME CHECK
-- ═══════════════════════════════════════════════════════════════════════════════

local REQUIRED_RESOURCE_NAME = "lxr-minerjob"
local currentResourceName = GetCurrentResourceName()

if currentResourceName ~= REQUIRED_RESOURCE_NAME then
    error(string.format([[

        ═══════════════════════════════════════════════════════════════════════════════
        ❌ CRITICAL ERROR: RESOURCE NAME MISMATCH ❌
        ═══════════════════════════════════════════════════════════════════════════════

        Expected: %s
        Got:      %s

        This resource is branded and must maintain the correct name.
        Rename the folder to "%s" to continue.

        🐺 wolves.land - The Land of Wolves

        ═══════════════════════════════════════════════════════════════════════════════

    ]], REQUIRED_RESOURCE_NAME, currentResourceName, REQUIRED_RESOURCE_NAME))
end

Config = {}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ SERVER BRANDING & INFO ████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.ServerInfo = {
    name        = 'The Land of Wolves 🐺',
    tagline     = 'Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!',
    description = 'ისტორია ცოცხლდება აქ!', -- History Lives Here!
    type        = 'Serious Hardcore Roleplay',
    access      = 'Discord & Whitelisted',

    -- Contact & Links
    website     = 'https://www.wolves.land',
    discord     = 'https://discord.gg/CrKcWdfd3A',
    github      = 'https://github.com/iBoss21',
    store       = 'https://theluxempire.tebex.io',

    -- Developer Info
    developer   = 'iBoss21 / The Lux Empire',

    -- Tags
    tags        = { 'RedM', 'Georgian', 'SeriousRP', 'Whitelist', 'MinerJob', 'Economy', 'Work' }
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ FRAMEWORK CONFIGURATION ███████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

--[[
    Framework Priority (in order):
    1. LXR-Core  (Primary)
    2. RSG-Core  (Primary)
    3. VORP Core (Supported / Legacy)
    4. RedEM:RP  (Optional / Legacy — auto-detected)
    5. Standalone (Fallback)
]]

Config.Framework = 'auto' -- 'auto' | 'lxr-core' | 'rsg-core' | 'vorp_core' | 'redem_roleplay' | 'standalone'

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ LANGUAGE CONFIGURATION ████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Lang = 'en' -- Supported: 'en', 'es', 'fr', 'ge'

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ JOB CONFIGURATION █████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.JobName = 'minero'   -- Job name in your framework database
Config.Vehiculo = 'CART06'  -- Vehicle model to spawn for ore delivery

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ REWARD CONFIGURATION ██████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Money = {
    min = 250,  -- Minimum cash reward for completing the job
    max = 500   -- Maximum cash reward for completing the job
}

Config.XP = {
    min = 15,   -- Minimum XP reward (RedEM:RP only; ignored on unsupported frameworks)
    max = 35    -- Maximum XP reward
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ TIMING CONFIGURATION ██████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Timers = {
    deliveryTimer  = 150, -- Seconds the player has to deliver after loading the cart
    miningDuration = 20000, -- ms — pickaxe animation duration per mine spot
    loadDuration   = 7000   -- ms — loading animation duration at vehicle
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ ZONE CONFIGURATION ████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Zones = {
    ['init']    = { x = 2750.79, y = 1325.35, z = 69.89 },
    ['Miner1']  = { x = 2760.95, y = 1310.22, z = 70.04 },
    ['Miner2']  = { x = 2756.18, y = 1301.95, z = 69.96 },
    ['Miner3']  = { x = 2713.48, y = 1307.92, z = 69.85 },
    ['Miner4']  = { x = 2759.86, y = 1302.19, z = 69.95 },
    ['Vehicle'] = { x = 2816.26, y = 1339.40, z = 70.33, heading = 269.01 },
    ['Entrega'] = { x = 2967.91, y = 470.07,  z = 48.61 }
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ DEBUG SETTINGS ████████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Debug = false -- Enable debug prints and extra logging

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ BACKWARD COMPATIBILITY ████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

-- Legacy aliases — do not edit
Config.lang   = Config.Lang
Config.money  = { ['min'] = Config.Money.min, ['max'] = Config.Money.max }
Config.xp     = { ['min'] = Config.XP.min,    ['max'] = Config.XP.max }
Config.Zonas  = Config.Zones

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ STARTUP BOOT BANNER ███████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

CreateThread(function()
    Wait(1000)
    print([[

        ═══════════════════════════════════════════════════════════════════════════════

            ██╗     ██╗  ██╗██████╗       ███╗   ███╗██╗███╗   ██╗███████╗██████╗
            ██║     ╚██╗██╔╝██╔══██╗      ████╗ ████║██║████╗  ██║██╔════╝██╔══██╗
            ██║      ╚███╔╝ ██████╔╝█████╗██╔████╔██║██║██╔██╗ ██║█████╗  ██████╔╝
            ██║      ██╔██╗ ██╔══██╗╚════╝██║╚██╔╝██║██║██║╚██╗██║██╔══╝  ██╔══██╗
            ███████╗██╔╝ ██╗██║  ██║      ██║ ╚═╝ ██║██║██║ ╚████║███████╗██║  ██║
            ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝

        ═══════════════════════════════════════════════════════════════════════════════
        🐺 MINER JOB SYSTEM - SUCCESSFULLY LOADED
        ═══════════════════════════════════════════════════════════════════════════════

        Version:    2.0.0
        Server:     ]] .. Config.ServerInfo.name .. [[

        Job Name:   ]] .. Config.JobName .. [[

        Vehicle:    ]] .. Config.Vehiculo .. [[

        Pay Range:  $]] .. Config.Money.min .. [[ - $]] .. Config.Money.max .. [[

        Delivery:   ]] .. Config.Timers.deliveryTimer .. [[ seconds
        Debug:      ]] .. (Config.Debug and 'ENABLED' or 'DISABLED') .. [[


        ═══════════════════════════════════════════════════════════════════════════════

        Developer:  iBoss21 / The Lux Empire
        Website:    https://www.wolves.land
        Discord:    https://discord.gg/CrKcWdfd3A

        ═══════════════════════════════════════════════════════════════════════════════

    ]])
end)