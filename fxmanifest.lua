fx_version 'cerulean'
games { 'gta5' };

dependency {
    'mysql-async',
    'vSql',
}

name 'LiteMySQL';

server_script {
    '@mysql-async/lib/MySQL.lua',
    '@vSql/vSql.lua',

    'LiteMySQL.lua',
    'helpers/*.lua',
    'query/*.lua',
    'clause/*.lua',
    'schema/*.lua',

    'testing.lua',
}