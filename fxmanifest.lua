fx_version 'adamant'

game 'gta5'


client_scripts {
	'client.lua',
    'config.lua'
}
server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua',
    'config.lua'

}


ui_page "html/index.html"


files({
    'html/index.html',
    'html/index.js',
    'html/main.css',
    'html/img/background.png',
    'html/img/btn-cartel-hover.png',
    'html/img/btn-cartel.png',
    'html/img/btn-gang-hover.png',
    'html/img/btn-gang.png',
    'html/img/btn-mafia-hover.png',
    'html/img/btn-mafia.png',
    'html/img/close.png',
})