package.path = package.path..string.format(";%s\\lib\\?.lua", __DIR__)..string.format(";%s\\config\\?.lua", __DIR__)

require("edep_lib")
require("edep_config")

Reset();
Select('ADF1', '9000');

Transaction_Amount = '00000001';
EP_Purchase('01', DPK[1], DTK[1]);

EP_Purchase('01', DPK[1], '');
