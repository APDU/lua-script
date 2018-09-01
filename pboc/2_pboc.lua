package.path = package.path..string.format(";%s\\lib\\?.lua", __DIR__)..string.format(";%s\\config\\?.lua", __DIR__)

require("pboc_lib")
require("pboc_config")
--AID = "A0000003330101";
--AID = "A000000632010106";

Reset();
selectPSE();
selectPBOC();
--TAG9F66 = "A6000000"
GPO();
--VerifyPIN("123456");
GAC1("80");
IssuerAuth ("3030")
GAC2("40");
Script("04DA 9F79 0A 000000011000");

