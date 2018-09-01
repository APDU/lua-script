local a = 0x57;
local b = 0x8C;

local ret;

ret = bit_xor(a, b)

if(ret ~= 0xDB)
then
	error("bit_xor fail");
	print(string.format("%02X",ret));
else
	print("bit_xor pass");
end


ret = bit_and(a, b)

if(ret ~= 0x4)
then
	error("bit_and fail");
	print(string.format("%02X",ret));
else
	print("bit_and pass");
end


ret = bit_or(a, b)

if(ret ~= 0xDF)
then
	error("bit_or fail");
	print(string.format("%02X",ret));
else
	print("bit_or pass");
end


ret = lshift(a, 1)

if(ret ~= 0xae)
then
	error("lshift fail");
	print(string.format("%02X",ret));
else
	print("lshift pass");
end

ret = rshift(a, 1)

if(ret ~= 0x2b)
then
	error("rshift fail");
	print(string.format("%02X",ret));
else
	print("rshift pass");
end


ret = xor("1122334455667788", "9988776655443322");

if(ret ~= "88AA4422002244AA")
then
	error("xor fail");
	print(ret);
else
	print("xor pass");
end



a = "999999999999";
b = "1";
local add = big_num_add(a,b,10);
local subtract = big_num_subtract(a,b,10)
if(big_num_compare(add,"1000000000000",10)==0)
then
	print("big_num_add, big_num_compare base10 pass");	
else
	error("big_num_add base10 fail");
end

if(big_num_compare(subtract,"999999999998",10)==0)
then
	print("big_num_subtract, big_num_subtract base10 pass");	
else
	error("big_num_subtract base10 fail");
end

a = "FFFFFFFFFFFF";
b = "1";
add = big_num_add(a,b,16);
subtract = big_num_subtract(a,b,16)
if(big_num_compare(add,"1000000000000",16)==0)
then
	print("big_num_add, big_num_add base16 pass");	
else
	error("big_num_add base16 fail");
end

if(big_num_compare(subtract,"FFFFFFFFFFFE",16)==0)
then
	print("big_num_subtract, big_num_subtract base16 pass");	
else
	error("big_num_subtract base16 fail");
end