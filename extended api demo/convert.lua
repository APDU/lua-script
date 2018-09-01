local ret;

ret = string2ascii("PBOC Debit");
if(ret ~= "50424F43204465626974")
then
	error("string2ascii, failed");
else
	print("string2ascii, pass");
end
	
ret = ascii2string("50424F43204465626974");
if(ret ~= "PBOC Debit")
then
	error("ascii2string, failed");
else
	print("ascii2string, pass");
end

ret = base64_encode("PBOC Debit");
if(ret ~= "UEJPQyBEZWJpdA==")
then
	error("base64_encode, failed");
else
	print("base64_encode, pass");
end
	
ret = base64_decode("UEJPQyBEZWJpdA==");
if(ret ~= "PBOC Debit")
then
	error("base64_decode, failed");
else
	print("base64_decode, pass");
end

ret = base58_encode("11AAFFEE");
if(ret ~= "TCE8m")
then
	error("base58_encode, failed");
else
	print("base58_encode, pass");
end
	
ret = base58_decode("TCE8m");
if(ret ~= "11AAFFEE")
then
	error("base58_decode, failed");
else
	print("base58_decode, pass");
end
	
ret = base58_encode("11AAFFEE", true);
if(ret ~= "3xQHNaiLmms")
then
	error("base58_encode checksum, failed");
else
	print("base58_encode checksum, pass");
end
	
ret = base58_decode("3xQHNaiLmms", true);
if(ret ~= "11AAFFEE")
then
	error("base58_decode checksum, failed");
else
	print("base58_decode checksum, pass");
end

ret = base58_encode_ripple("11AAFFEE");
if(ret ~= "TUN3m")
then
	error("base58_encode_ripple, failed");
else
	print("base58_encode_ripple, pass");
end
	
ret = base58_decode_ripple("TUN3m");
if(ret ~= "11AAFFEE")
then
	error("base58_decode_ripple, failed");
else
	print("base58_decode_ripple, pass");
end
	
ret = base58_encode_ripple("11AAFFEE", true);
if(ret ~= "sxQH425Lmm1")
then
	error("base58_encode_ripple checksum, failed");
else
	print("base58_encode_ripple checksum, pass");
end
	
ret = base58_decode_ripple("sxQH425Lmm1", true);
if(ret ~= "11AAFFEE")
then
	error("base58_decode_ripple checksum, failed");
else
	print("base58_decode_ripple checksum, pass");
end
