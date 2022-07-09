fx_version 'cerulean'
games { 'gta5' }
author 'gunware'

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
    "config.lua",
    "zones/**.lua",
    "client/*.lua",
}


client_scripts {
    'client/**.lua'

}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/**.lua'
}

shared_scripts {
    'shared/**.lua'
}