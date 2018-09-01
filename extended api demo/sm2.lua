local data = "11";
local publicKey_x = "1C930C8C5B955C6FB5E4FC4AE9B1841F7ED8EB9EB37ECF7C484130CF5D96F3BD";
local publicKey_y = "8DFC2B46F01C3A4B205511BE84100588B214E5F5E3D2D87A4D15C2F78C3E0752";

local privateKey = "5C75E9AD1428EEB86C5C93393EFD8BE1082499ED22ABF19556DF0A1329100858";
local id = "31323334353637383132333435363738";
local ret_en, ret_de;

local ret_pub = {};
ret_pub = sm2_calc_public_key(privateKey);

if(ret_pub[0] ~= publicKey_x and ret_pub[1] ~= publicKey_y)
then
	error("sm2_calc_public_key fail");
	print(ret_pub[0]);
	print(ret_pub[1]);
else
	print("sm2_calc_public_key pass");
end

ret_en = sm2_encrypt(data, publicKey_x, publicKey_y);

ret_de = sm2_decrypt(ret_en, privateKey);

if(ret_de ~= data)
then
	error("sm2_encrypt or sm2_decrypt fail");
	print(ret_en);
	print(ret_de);
else
	print("sm2_encrypt & sm2_decrypt pass");
end

local ret_rs = {};
ret_rs = sm2_sign(data, privateKey, id);

ret_de = sm2_verify(data, ret_rs[0], ret_rs[1], publicKey_x, publicKey_y, id);

if(ret_de == false)
then
	error("sm2_sign or sm2_verify fail");
	print(ret_en);
else
	print("sm2_sign & sm2_verify pass");
end


local sm2_key = {};
sm2_key = sm2_generate_key();

if(sm2_key == nil)
then
	error("sm2_generate_key fail");
else
	privateKey = sm2_key[0];
	publicKey_x = sm2_key[1];
	publicKey_y = sm2_key[2];
	
	ret_rs = sm2_sign(data, privateKey);
	
	ret_de = sm2_verify(data, ret_rs[0], ret_rs[1], publicKey_x, publicKey_y);
	
	if(ret_de == false)
	then
		error("sm2_generate_key fail");
		print(ret_en);
	else
		print("sm2_generate_key pass");
	end
end