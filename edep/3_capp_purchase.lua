package.path = package.path..string.format(";%s\\lib\\?.lua", __DIR__)..string.format(";%s\\config\\?.lua", __DIR__)

require("edep_lib")
require("edep_config")

Reset();
Select('ADF1', '9000');

Transaction_Amount = '00000001';
local cmd_80dc = {};
cmd_80dc[1] = '80DC01BC 30 092E 10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000';
cmd_80dc[2] = '80DC02BC 20 011E 100000000000000000000000000000000000000000000000000000000000';

EP_CAPP_Purchase(cmd_80dc, '01', DPK[1], DTK[1])
EP_CAPP_Purchase(cmd_80dc, '01', DPK[1], '')
