--[[
    🐺 wolves.land — The Land of Wolves | LXR Miner Job
    Developer: iBoss21 / The Lux Empire
    © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
]]

fx_version 'adamant'
lua54 'yes'

game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

name        'lxr-minerjob'
version     '2.0.0'
author      'iBoss21 / The Lux Empire'
description '🐺 LXR Miner Job — The Land of Wolves'
url         'https://www.wolves.land'

shared_scripts {
    'config.lua',
    'locales/language.lua'
}

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}

dependencies {
    'progressBars'
}
