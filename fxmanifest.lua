fx_version 'adamant'

game 'gta5'

client_scripts {
	'Config.lua',
	'Client/*.lua'
}

server_scripts {
	'Config.lua',
	'@oxmysql/lib/MySQL.lua',
	'Server/*.lua'
}

exports {
	'OpenMainAnimationsMenu',
	'GetEmotes',
	'RequestLatestStyle',
	'EmoteStart'
}