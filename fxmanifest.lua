fx_version "cerulean"
game "gta5"
lua54 "yes"
use_fxv2_oal "yes"

shared_scripts {
    "@es_extended/imports.lua",
    "config.lua"
}

server_scripts {
    "server/*.lua"
}

client_scripts {
    "client/*.lua"
}

ui_page "web/index.html"
files {
    "web/index.html",
    "web/script.js",
    "web/style.css",
    "web/img/*"
}