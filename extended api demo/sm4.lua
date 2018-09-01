local data = "5C75E9AD1428EEB86C5C93393EFD8BE1082499ED22ABF19556DF0A1329100858";
local key = "201AE29EC4E5FC3251BEA3D3A1A5AB46";
local iv = "A2A7B6E2A133BC6AB0379C36489AB142";
local ret;

ret = sm4_ecb_encrypt(data, key);

if(ret ~= "30B1D604D290D04FA462DAECC33DB1A21A23139BF71D55CC530941530D1F7CEC")
then
	error("sm4_ecb_encrypt fail");
	print(ret);
else
	print("sm4_ecb_encrypt pass");
end


ret = sm4_ecb_decrypt(data, key);

if(ret ~= "50E7AA6E37FD5304825622F2F1CFE2BBFCAF4581D84A6B6D910EB238E1E4AC3A")
then
	error("sm4_ecb_decrypt fail");
	print(ret);
else
	print("sm4_ecb_decrypt pass");
end


ret = sm4_cbc_encrypt(data, key);

if(ret ~= "30B1D604D290D04FA462DAECC33DB1A2B53322BC705C5FFAE677725797CEDBEB")
then
	error("sm4_cbc_encrypt fail");
	print(ret);
else
	print("sm4_cbc_encrypt pass");
end


ret = sm4_cbc_decrypt(data, key);

if(ret ~= "50E7AA6E37FD5304825622F2F1CFE2BBA0DAAC2CCC6285D5FD522101DF1927DB")
then
	error("sm4_cbc_decrypt fail");
	print(ret);
else
	print("sm4_cbc_decrypt pass");
end


ret = sm4_cbc_encrypt(data, key, iv);

if(ret ~= "EB1FCA32AE21391762B6752CB04C18AD0104F9A4252605E5B6D8CF1BFD385189")
then
	error("sm4_cbc_encrypt iv fail");
	print(ret);
else
	print("sm4_cbc_encrypt iv pass");
end


ret = sm4_cbc_decrypt(data, key, iv);

if(ret ~= "F2401C8C96CEEF6E3261BEC4B95553F9A0DAAC2CCC6285D5FD522101DF1927DB")
then
	error("sm4_cbc_encrypt iv fail");
	print(ret);
else
	print("sm4_cbc_encrypt iv pass");
end


ret = sm4_mac(data, key);

if(ret ~= "B53322BC705C5FFAE677725797CEDBEB")
then
	error("sm4_mac fail");
	print(ret);
else
	print("sm4_mac pass");
end


ret = sm4_mac(data, key, iv);

if(ret ~= "0104F9A4252605E5B6D8CF1BFD385189")
then
	error("sm4_mac iv fail");
	print(ret);
else
	print("sm4_mac iv pass");
end
