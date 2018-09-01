
local data = "846346A2654B78D7F52582330AE034CA797E5F5C9FD2C9AC5A1901ACA34DD89E";
local key8 = "7CEC84A81BFEEB13";
local iv = "574D65D24B998B5C";
local key16 = "B378D5B5ED287588AB84C47C069CA4FA";
local key24 = "6AAD87BB1D6FCAB169399C53F91795385242BB5E48CD9B5A";
local ret = "";

ret = des_ecb_encrypt(data, key8);

if(ret ~= "DBE27C123764D18685F64BF4C742CCBE2EEF0E1510519CEFD71D8C601BE82D91")
then
	error("des_ecb_encrypt fail");
	print(ret);
else
	print("des_ecb_encrypt pass");
end


ret = des_ecb_decrypt(data, key8);

if(ret ~= "E99B67D8A1B254E7D812E9D9A4776FE92D432CD0DE2755E5DE616DB0D4474CA5")
then
	error("des_ecb_decrypt fail");
	print(ret);
else
	print("des_ecb_decrypt pass");
end


ret = des_cbc_encrypt(data, key8);

if(ret ~= "DBE27C123764D1862FAEAFE96FB3CD8F1C661376CA2E199C83D8EBB60D50546B")
then
	error("des_cbc_encrypt fail");
	print(ret);
else
	print("des_cbc_encrypt pass");
end


ret = des_cbc_decrypt(data, key8);

if(ret ~= "E99B67D8A1B254E75C71AF7BC13C173ED866AEE3D4C7612FA71F32EC4B958509")
then
	error("des_cbc_decrypt fail");
	print(ret);
else
	print("des_cbc_decrypt pass");
end


ret = des_cbc_encrypt(data, key8, iv);

if(ret ~= "3C4EF69318E130DC157A924D0E90B387472BB0A8153C08DC7410289E92AF6AF3")
then
	error("des_cbc_encrypt iv fail");
	print(ret);
else
	print("des_cbc_encrypt iv pass");
end

ret = des_cbc_decrypt(data, key8, iv);

if(ret ~= "BED6020AEA2BDFBB5C71AF7BC13C173ED866AEE3D4C7612FA71F32EC4B958509")
then
	error("des_cbc_decrypt iv fail");
	print(ret);
else
	print("des_cbc_decrypt iv pass");
end






ret = triple_des_ecb_encrypt(data, key16);

if(ret ~= "362CD071D04F980A947C2973C6F79F55897CE835FFF75D9FCBC15C4129B3601F")
then
	error("triple_des_ecb_encrypt key16 fail");
	print(ret);
else
	print("triple_des_ecb_encrypt key16 pass");
end


ret = triple_des_ecb_decrypt(data, key16);

if(ret ~= "C57711F210185ED29F59B193F8CA49D3EEF70C98F01AA85C26D2E636F7E44320")
then
	error("triple_des_ecb_decrypt key16 fail");
	print(ret);
else
	print("triple_des_ecb_decrypt key16 pass");
end


ret = triple_des_ecb_encrypt(data, key24);

if(ret ~= "4FC98CBAA87E4A47B9DE310CD33E59AB8FA3FB0533599F2A03703C8A5B207EE5")
then
	error("triple_des_ecb_encrypt key24 fail");
	print(ret);
else
	print("triple_des_ecb_encrypt key24 pass");
end


ret = triple_des_ecb_decrypt(data, key24);

if(ret ~= "189B60BAAA1CB5FED1389693043DD2C1BA9DA8AA72A0028009B9C9F53EC102B1")
then
	error("triple_des_ecb_decrypt key24 fail");
	print(ret);
else
	print("triple_des_ecb_decrypt key24 pass");
end


ret = triple_des_cbc_encrypt(data, key16);

if(ret ~= "362CD071D04F980A020C9C3F90FF464176AD01FAA356A1232636E4AB0446658A")
then
	error("triple_des_cbc_encrypt key16 fail");
	print(ret);
else
	print("triple_des_cbc_encrypt key16 pass");
end


ret = triple_des_cbc_decrypt(data, key16);

if(ret ~= "C57711F210185ED21B3AF7319D8131041BD28EABFAFA9C965FACB96A68368A8C")
then
	error("triple_des_cbc_decrypt key16 fail");
	print(ret);
else
	print("triple_des_cbc_decrypt key16 pass");
end


ret = triple_des_cbc_encrypt(data, key24);

if(ret ~= "4FC98CBAA87E4A4777E2E541E4F5357A7F97CA155E53947FF0A617CB6A2EE9F3")
then
	error("triple_des_cbc_encrypt key24 fail");
	print(ret);
else
	print("triple_des_cbc_encrypt key24 pass");
end


ret = triple_des_cbc_decrypt(data, key24);

if(ret ~= "189B60BAAA1CB5FE555BD0316176AA164FB82A997840364A70C796A9A113CB1D")
then
	error("triple_des_cbc_decrypt key24 fail");
	print(ret);
else
	print("triple_des_cbc_decrypt key24 pass");
end


ret = triple_des_cbc_encrypt(data, key16, iv);

if(ret ~= "3C93FD51CE8E879F6207AE50A165B1E8F83FF1DC9AE1D4413E55555F150D3CE1")
then
	error("triple_des_cbc_encrypt key16 fail");
	print(ret);
else
	print("triple_des_cbc_encrypt key16 pass");
end


ret = triple_des_cbc_decrypt(data, key16, iv);

if(ret ~= "923A74205B81D58E1B3AF7319D8131041BD28EABFAFA9C965FACB96A68368A8C")
then
	error("triple_des_cbc_decrypt key16 fail");
	print(ret);
else
	print("triple_des_cbc_decrypt key16 pass");
end


ret = triple_des_cbc_encrypt(data, key24, iv);

if(ret ~= "D62DBC06C6D2982E689DCE20B2FC7E8097D2C688AEB61BAE87A482A2E4A92DB4")
then
	error("triple_des_cbc_encrypt key24 fail");
	print(ret);
else
	print("triple_des_cbc_encrypt key24 pass");
end


ret = triple_des_cbc_decrypt(data, key24, iv);

if(ret ~= "4FD60568E1853EA2555BD0316176AA164FB82A997840364A70C796A9A113CB1D")
then
	error("triple_des_cbc_decrypt key24 fail");
	print(ret);
else
	print("triple_des_cbc_decrypt key24 pass");
end

ret = des_mac(data.."8000000000000000", key8);

if(ret ~= "8C0D5462AF15FD42")
then
	error("des_mac key fail");
	print(ret);
else
	print("des_mac key pass");
end

ret = des_mac(data.."8000000000000000", key8, iv);

if(ret ~= "AD8C4938D1649AA4")
then
	error("des_mac key iv fail");
	print(ret);
else
	print("des_mac key iv pass");
end

ret = triple_des_mac(data.."8000000000000000", key16);

if(ret ~= "5DA936E819D365E5")
then
	error("triple_des_mac key16 fail");
	print(ret);
else
	print("triple_des_mac key16 pass");
end

ret = triple_des_mac(data.."8000000000000000", key16, iv);

if(ret ~= "9FB3E8FF54D52073")
then
	error("triple_des_mac key16 iv fail");
	print(ret);
else
	print("triple_des_mac key16 iv pass");
end
