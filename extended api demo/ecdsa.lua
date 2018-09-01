
local curve_name = {};
curve_name [0] = "prime192v1";
curve_name [1] = "prime256v1";
curve_name [2] = "P-192";
curve_name [3] = "P-224";
curve_name [4] = "P-256";
curve_name [5] = "P-384";
curve_name [6] = "P-521";
curve_name [7] = "secp192k1";
curve_name [8] = "secp192r1";
curve_name [9] = "secp224k1";
curve_name [10] = "secp224r1";
curve_name [11] = "secp256k1";
curve_name [12] = "secp256r1";
curve_name [13] = "secp384r1";
curve_name [14] = "secp521r1";
local key = {};
local rs = {};
local e = sha256("11223344");
for key, curve in pairs(curve_name) do  
    --print(curve); 
	key = ecc_generate_key(curve);
	if(key == nil)
	then
		error(curve, ", ecc_generate_key fail");
	else	
		print(curve, ", ecc_generate_key pass");
		
		local ret_pub = {};
		ret_pub = ecc_calc_public_key(key[0], curve);

		if(ret_pub[0] ~= key[1] and ret_pub[1] ~= key[2])
		then
			error(curve, ", ecc_calc_public_key fail");
			print(ret_pub[0]);
			print(ret_pub[1]);
		else
			print(curve, ", ecc_calc_public_key pass");
		end
		
		rs = ecdsa_sign(e, key[0], curve);	
		if(rs == nil)
		then
			error(curve, ", ecdsa_sign fail");
		else	
			print(curve, ", ecdsa_sign pass");
			
			local ret = ecdsa_verify(e, rs[0], rs[1], key[1], key[2], curve );
			if(ret == false)
			then
			error(curve, ", ecdsa_verify fail");
			else
			print(curve, ", ecdsa_verify pass");
			end
		end		
	end
	print();
end 

