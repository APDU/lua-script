package.path = package.path..string.format(";%s\\lib\\?.lua", __DIR__)..string.format(";%s\\config\\?.lua", __DIR__)

require("edep_lib")
require("edep_config")

Reset();
Select('ADF1', '9000');
Send("0020000003123456", "9000");
Transaction_Amount = '00000010';
EP_Load('01', DLK[1], DTK[1]);

EP_Load('01', DLK[1], "");
