package.path = package.path..string.format(";%s\\gp\\lib\\?.lua", get_dir(__DIR__,-1))..string.format(";%s\\config\\?.lua", __DIR__)

local gplib = require("gp_lib");
require("edep_config");
local gp = gplib:new();
--local key = "404142434445464748494A4B4C4D4E4F";
--gp:setKey(key,key,key);

--gp:reset();
--gp:select("","9000");
--gp:init(gp_ver);
--gp:ext(gp_sl);
--gp:delete_instance("A0000003330101","");
--gp:install(FOR_INSTALL_SELECTABLE, 0, "06 A00000033301 07 A0000003330101 07 A0000003330101 0100 02 C90000", SW9000);
	