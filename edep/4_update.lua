package.path = package.path..string.format(";%s\\lib\\?.lua", __DIR__)..string.format(";%s\\config\\?.lua", __DIR__)

require("edep_lib")
require("edep_config")

Reset();
Select('ADF1', '9000');
Send_Mac("04D69500 1E 000000000000000000000000000000000000000000000000000000000000", "11223344556677881122334455667788", "9000");

