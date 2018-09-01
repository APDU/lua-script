
local data = "846346A2654B78D7F52582330AE034CA797E5F5C9FD2C9AC5A1901ACA34DD89E";
local iv = "574D65D24B998B5C7CEC84A81BFEEB13";
local key16 = "B378D5B5ED287588AB84C47C069CA4FA";
local key24 = "6AAD87BB1D6FCAB169399C53F91795385242BB5E48CD9B5A";
local key32 = "52A2E3453A35E23D512EF8DC18DDADC39E676E2364C27B001A5DCFCF47B58D5D";
local ret = "";

ret = aes_ecb_encrypt(data, key16);

if(ret ~= "45787658F142CB8BAEC50428E503440C22C97BA4876BFF65CB91168112CD5408")
then
	error("aes_ecb_encrypt key16 fail");
	print(ret);
else
	print("aes_ecb_encrypt key16 pass");
end

ret = aes_ecb_decrypt(data, key16);

if(ret ~= "2F2EE07EFA8CE852092A15355105354A2FD42F20100A0747E6FDA4DA4B9232BB")
then
	error("aes_ecb_decrypt key16 fail");
	print(ret);
else
	print("aes_ecb_decrypt key16 pass");
end


ret = aes_ecb_encrypt(data, key24);

if(ret ~= "5993FD8295851A2109C4964B2B71C103FCEAF866B77C6568E5103398FCD3A5E2")
then
	error("aes_ecb_encrypt key24 fail");
	print(ret);
else
	print("aes_ecb_encrypt key24 pass");
end

ret = aes_ecb_decrypt(data, key24);

if(ret ~= "F004EF6996DBF61D5F1C82F2B1091C21AB3B0F946AB267AF9511970704CBC924")
then
	error("aes_ecb_decrypt key24 fail");
	print(ret);
else
	print("aes_ecb_decrypt key24 pass");
end

ret = aes_ecb_encrypt(data, key32);

if(ret ~= "459590EA4A4F8CE8DBF204C1BC4B559CBDF3E49A638CA13F053842C536CB2005")
then
	error("aes_ecb_encrypt key32 fail");
	print(ret);
else
	print("aes_ecb_encrypt key32 pass");
end

ret = aes_ecb_decrypt(data, key32);

if(ret ~= "83926E6ACE656D487A801FDA34343FDF1FD5AF912F8C34FD30E48B3FFDFBF52F")
then
	error("aes_ecb_decrypt key32 fail");
	print(ret);
else
	print("aes_ecb_decrypt key32 pass");
end



ret = aes_cbc_encrypt(data, key16);

if(ret ~= "45787658F142CB8BAEC50428E503440C956B0EF4B3BA672885452DAC1FC035C2")
then
	error("aes_cbc_encrypt key16 fail");
	print(ret);
else
	print("aes_cbc_encrypt key16 pass");
end

ret = aes_cbc_decrypt(data, key16);

if(ret ~= "2F2EE07EFA8CE852092A15355105354AABB7698275417F9013D826E941720671")
then
	error("aes_cbc_decrypt key16 fail");
	print(ret);
else
	print("aes_cbc_decrypt key16 pass");
end

ret = aes_cbc_encrypt(data, key16, iv);

if(ret ~= "2B5307C96F71150896A27D175EA99BE0D3C888BE39474446E1E28366B3F8C686")
then
	error("aes_cbc_encrypt key16 iv fail");
	print(ret);
else
	print("aes_cbc_encrypt key16 iv pass");
end

ret = aes_cbc_decrypt(data, key16, iv);

if(ret ~= "786385ACB115630E75C6919D4AFBDE59ABB7698275417F9013D826E941720671")
then
	error("aes_cbc_decrypt key16 iv fail");
	print(ret);
else
	print("aes_cbc_decrypt key16 iv pass");
end



ret = aes_cbc_encrypt(data, key24);

if(ret ~= "5993FD8295851A2109C4964B2B71C103DC6ADBC1C7D410B2A7AEB3CF8167F4DC")
then
	error("aes_cbc_encrypt key24 fail");
	print(ret);
else
	print("aes_cbc_encrypt key24 pass");
end

ret = aes_cbc_decrypt(data, key24);

if(ret ~= "F004EF6996DBF61D5F1C82F2B1091C212F5849360FF91F78603415340E2BFDEE")
then
	error("aes_cbc_decrypt key24 fail");
	print(ret);
else
	print("aes_cbc_decrypt key24 pass");
end

ret = aes_cbc_encrypt(data, key24, iv);

if(ret ~= "E6BA2C3D504A28A4D2B330B4E2C055845D7465753AF027E9485E9B9E6181A1AC")
then
	error("aes_cbc_encrypt key24 iv fail");
	print(ret);
else
	print("aes_cbc_encrypt key24 iv pass");
end

ret = aes_cbc_decrypt(data, key24, iv);

if(ret ~= "A7498ABBDD427D4123F0065AAAF7F7322F5849360FF91F78603415340E2BFDEE")
then
	error("aes_cbc_decrypt key24 iv fail");
	print(ret);
else
	print("aes_cbc_decrypt key24 iv pass");
end


ret = aes_cbc_encrypt(data, key32);

if(ret ~= "459590EA4A4F8CE8DBF204C1BC4B559CA2910804C572F660916BB84734D2B95D")
then
	error("aes_cbc_encrypt key32 fail");
	print(ret);
else
	print("aes_cbc_encrypt key32 pass");
end

ret = aes_cbc_decrypt(data, key32);

if(ret ~= "83926E6ACE656D487A801FDA34343FDF9BB6E9334AC74C2AC5C1090CF71BC1E5")
then
	error("aes_cbc_decrypt key32 fail");
	print(ret);
else
	print("aes_cbc_decrypt key32 pass");
end


ret = aes_cbc_encrypt(data, key32, iv);

if(ret ~= "E23BFB34CF1B8E25F2ACF3A29A1FC5B088A76482EF56CBD35FA9D65389E40BAE")
then
	error("aes_cbc_encrypt key32 iv fail");
	print(ret);
else
	print("aes_cbc_encrypt key32 iv pass");
end

ret = aes_cbc_decrypt(data, key32, iv);

if(ret ~= "D4DF0BB885FCE614066C9B722FCAD4CC9BB6E9334AC74C2AC5C1090CF71BC1E5")
then
	error("aes_cbc_decrypt key32 iv fail");
	print(ret);
else
	print("aes_cbc_decrypt key32 iv pass");
end