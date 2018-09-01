local data = "3B8027BFA8E9CA4F09F291B9867AB1487EB38852DCC8DEA87D3F9DE9B971A92F846346A2654B78D7F52582330AE034CA797E5F5C9FD2C9AC5A1901ACA34DD89E3B8027BFA8E9CA4F09F291B9867AB1487EB38852DCC8DEA87D3F9DE9B971A92F846346A2654B78D7F52582330AE034CA797E5F5C9FD2C9AC5A1901ACA34DD89E";
local key = "11223344556677889900"
local ret = "";

ret = hmac_sha1(key, data);

if(ret ~= "3A5E041B71EA6DA293D8C3F12B1E906774A70861")
then
	error("hmac_sha1 fail");
	print(ret);
else
	print("hmac_sha1 pass");
end


ret = hmac_sha224(key, data);

if(ret ~= "E32ABE7CF86241CEFC5B3FD3C770D212831BAB2FC6699D3E438D4307")
then
	error("hmac_sha224 fail");
	print(ret);
else
	print("hmac_sha224 pass");
end


ret = hmac_sha256(key, data);

if(ret ~= "1B1C37B30F9BEB4C9951C8190F1856F2CD6E5F58021714640FCE3A15BDD86130")
then
	error("hmac_sha256 fail");
	print(ret);
else
	print("hmac_sha256 pass");
end


ret = hmac_sha384(key, data);

if(ret ~= "0F11BC44761AEC003CC73C528EB4165A3DF08DC6BA96FA44518081F3B17A006C5E0F8037B800CF9161E1AA8B8F2EA31D")
then
	error("hmac_sha384 fail");
	print(ret);
else
	print("hmac_sha384 pass");
end


ret = hmac_sha512(key, data);

if(ret ~= "28D73AD84C6444A81B0021A020AED00740E157DA34BA02C6946F5AF07FFB78A2E96D682F39AFFE77CB677EA85BC5DC8A72305DA890A36BBC28707B90F3911322")
then
	error("hmac_sha512 fail");
	print(ret);
else
	print("hmac_sha512 pass");
end


ret = hmac_md5(key, data);

if(ret ~= "032FA957C50B38F4BEE2ACCD15F82AAA")
then
	error("hmac_md5 fail");
	print(ret);
else
	print("hmac_md5 pass");
end
