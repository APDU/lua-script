package.path = package.path..string.format(";%s\\lib\\?.lua", __DIR__)..string.format(";%s\\config\\?.lua", __DIR__)

require("pboc_lib")
require("pboc_config")

--AID = "A0000003330101";
--AID = "A000000632010106";

Reset();
selectPPSE();
selectPBOC();
tag9F66 = "A6000000"
GPO();


