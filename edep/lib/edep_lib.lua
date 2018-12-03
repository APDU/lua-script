local path = package.path;
lfs.chdir(__DIR__);
package.path = path..string.format(";..\\config\\?.lua")

require("edep_config");

function pad(str)
	str = str.."80"
	while(string.len(str)%16 ~=0)
	do
		str = str.."0"
	end	
	return str;
end

function Reset () 
	local res = reset();
	if(res == nil)
	then
		error("reset throw exception");
		return;
	end
end

function Send (apdu,sw)
	local res = send_apdu(apdu,"");
	if(res == nil)
	then
		error("send_apdu throw exception");
		return "";
	elseif(string.sub(res,1,2)=="6C")
	then
		res = send_apdu(string.sub(apdu,1,8)..string.sub(res,3,4),sw);	
		if(res == nil)
		then
			error("send_apdu throw exception");
			return "";
		end
	elseif(string.sub(res,1,2)=="61")
	then
		res = send_apdu("00C00000"..string.sub(res,3,4),sw);
		if(res == nil)
		then
			error("send_apdu throw exception");
			return "";
		end
	end
	
	if(string.sub(res,-4) ~= sw)
	then
		error("Expected SW: "..sw);
		return "";
	end	
	return res;	
end

function Select(aid, sw)
	aid = string.gsub(aid," ","");
	local p1='04';
	if(string.len(aid)==4)
	then
		p1='00';
	end
	local res = Send("00A4" ..p1 .. "00" .. string.format("%02X",string.len(aid)/2) .. aid, sw);
					
	if (res  == nil)
	then
		error("select "..aid.." throw exception");			
	end		
end

function Send_Mac (apdu, key, sw)
	local rand = Send ("0084000008","9000");
	rand = string.sub(rand,1,16);
	apdu = string.gsub(apdu," ","");
	key = string.gsub(key," ","");
	apdu = string.sub(apdu, 1, 8) .. string.format("%02X",string.len(apdu)/2-1) .. string.sub(apdu, 11);
	local mac = triple_des_mac(pad(apdu), key, rand);
	mac = string.sub(mac,1,8);
	Send (apdu..mac,sw);
end

function Send_Cipher_Mac (apdu, key, sw)
	apdu = string.gsub(apdu," ","");
	
	local apdu_data = string.format("%02X",string.len(apdu)/2-5) .. string.sub(apdu, 11);
	
	if(string.len(apdu_data)%16 ~=0)
	then
		apdu_data = pad(apdu_data);
	end
	
	local cipher = triple_des_ecb_encrypt(apdu_data, key);
	
	if (cipher  == nil)
	then
		error("triple_des_ecb_encrypt throw exception");
		return;
	end	
	
	apdu = string.sub(apdu, 1, 8) .. string.format("%02X", string.len(cipher)/2) .. cipher;
	
	Send_Mac(apdu, key, sw);
end

function Ext_Auth (p1p2, key, sw)
	local rand = Send ("0084000008","9000");
	rand = string.sub(rand,1,16);
	local mac = triple_des_ecb_encrypt(rand, key);
	local apdu = '0082' .. p1p2 .. '08' ..mac;
	Send(apdu,sw);
end

function Load(p2, loadkey_index, load_key, tac_key)
	tac_key = string.gsub(tac_key," ","");
	local apdu = '8050 00' .. p2 .. '0B' .. loadkey_index .. Transaction_Amount .. Terminal_Name;
	local res = Send(apdu, '9000');
	local sessionkey;
	local data;
	if (res  == nil)
	then
		error("Initialize_For_Load throw exception");
		return;
	elseif (string.sub(res,-4) == '9000')
	then
		local balance = string.sub(res,1,8);
		local atc = string.sub(res,9,12);
		local key_version = string.sub(res,13,14);
		local key_id = string.sub(res,15,16);
		local rand = string.sub(res,17,24);
		local mac1 = string.sub(res,25,32);
		
		data = rand .. atc .. '8000';
		
		sessionkey = triple_des_ecb_encrypt(data, load_key);
		--print(sessionkey);
		if(sessionkey == nil)
		then
			error('Session DLK is nil');
			return;
		end
		
		if(p1 == ED)
		then
			ED_Balance = balance;
			ED_Online_ATC = atc;
			data = balance .. Transaction_Amount .. '01' .. Terminal_Name;
		else
			EP_Balance = balance;
			EP_Online_ATC = atc;
			data = balance .. Transaction_Amount .. '02' .. Terminal_Name;			
		end
		
		data = pad(data);
		
		local mac = des_mac(data, sessionkey);
		mac = string.sub(mac,1,8);
		if(mac1 ~= mac)
		then
			error('Mac1 Expected:', mac);
			return;
		end
		
	end	
	
	if(p1 == ED)
	then
		data = Transaction_Amount .. '01' .. Terminal_Name .. Transaction_Date .. Transaction_Time;
	else
		data = Transaction_Amount .. '02' .. Terminal_Name .. Transaction_Date .. Transaction_Time;			
	end
	
	data = pad(data);
	
	local mac2 = des_mac(data, sessionkey);
	mac2 = string.sub(mac2,1,8);
	apdu = '8052 0000 0B' .. Transaction_Date .. Transaction_Time .. mac2;
	
	res = Send(apdu, '9000');
	if (res  == nil)
	then
		error("Credit_For_Load throw exception");
		return;
	elseif (string.sub(res,-4) == '9000')
	then

		local amount;
		if(p1 == ED)
		then
			amount = big_num_add(ED_Balance,Transaction_Amount,16);
			while(string.len(amount)<8)
			do
				amount = "0"..amount;
			end	
			amount = string.sub(amount,-8);
			ED_Balance = amount;
		else
			amount = big_num_add(EP_Balance,Transaction_Amount,16);
			while(string.len(amount)<8)
			do
				amount = "0"..amount;
			end	
			amount = string.sub(amount,-8);
			EP_Balance = amount;
		end
	
		if(string.len(tac_key) == 32)
		then
			tac_key = xor(string.sub(tac_key,1,16), string.sub(tac_key,17));
			local tac = string.sub(res,1,8);
		
			if(p1 == ED)
			then
				data = ED_Balance .. ED_Online_ATC .. Transaction_Amount .. '01' .. Terminal_Name .. Transaction_Date .. Transaction_Time;
			else
				data = EP_Balance .. EP_Online_ATC .. Transaction_Amount .. '02' .. Terminal_Name .. Transaction_Date .. Transaction_Time;			
			end
		
			data = pad(data);

			local mac = des_mac(data, tac_key);
			mac = string.sub(mac,1,8);
			if(tac ~= mac)
			then
				error('TAC Expected:', mac);
				return;
			end
		else
			print('TAC Not Verify')
		end
		
	end
end



function Purchase(p2, purchase_key_index, purchase_key, tac_key)
	tac_key = string.gsub(tac_key," ","");
	local apdu = '8050 01' .. p2 .. '0B' .. purchase_key_index .. Transaction_Amount .. Terminal_Name;
	local res = Send(apdu, '9000');
	local sessionkey;
	local data;
	if (res  == nil)
	then
		error("Initialize_For_Purchase throw exception");
		return;
	elseif (string.sub(res,-4) == '9000')
	then
		local balance = string.sub(res,1,8);
		local atc = string.sub(res,9,12);
		local overdrawn = string.sub(res,13,18);
		local key_version = string.sub(res,19,20);
		local key_id = string.sub(res,21,22);
		local rand = string.sub(res,23,30);	
		
		data = rand .. atc .. string.sub(Terminal_ATC,-4);;
		
		sessionkey = triple_des_ecb_encrypt(data, purchase_key);
		--print(sessionkey);
		if(sessionkey == nil)
		then
			error('Session DPK is nil');
			return;
		end
		
		if(p1 == ED)
		then
			ED_Balance = balance;
			ED_Offline_ATC = atc;
			data = Transaction_Amount .. '05' .. Terminal_Name .. Transaction_Date .. Transaction_Time;
		else
			EP_Balance = balance;
			EP_Offline_ATC = atc;
			data = Transaction_Amount .. '06' .. Terminal_Name .. Transaction_Date .. Transaction_Time;			
		end
				
		data = pad(data);
		
		local mac1 = des_mac(data, sessionkey);
		mac1 = string.sub(mac1,1,8);
		
		apdu = '8054 0100 0F' .. Terminal_ATC .. Transaction_Date .. Transaction_Time .. mac1;
		res = Send(apdu, '9000');
			
		if (res  == nil)
		then
			error("Debit_For_Purchase throw exception");
			return;
		elseif (string.sub(res,-4) == '9000')
		then
			local amount;
			local tac = string.sub(res,1,8);
			local mac2 = string.sub(res,9,16);
			
			local mac = des_mac(pad(Transaction_Amount), sessionkey);
			mac = string.sub(mac,1,8);
			if(mac2 ~= mac)
			then
				error('Mac2 Expected:', mac);
				return;
			end
			
			
			if(p1 == ED)
			then
				amount = big_num_subtract(ED_Balance,Transaction_Amount,16);
				while(string.len(amount)<8)
				do
					amount = "0"..amount;
				end	
				amount = string.sub(amount,-8);
				ED_Balance = amount;
			else
				amount = big_num_subtract(EP_Balance,Transaction_Amount,16);
				while(string.len(amount)<8)
				do
				amount = "0"..amount;
				end	
				amount = string.sub(amount,-8);
				EP_Balance = amount;
			end
	
			if(string.len(tac_key) == 32)
			then
				tac_key = xor(string.sub(tac_key,1,16), string.sub(tac_key,17));
				local tac = string.sub(res,1,8);
		
				if(p1 == ED)
				then
					data = Transaction_Amount .. '05' .. Terminal_Name .. Terminal_ATC .. Transaction_Date .. Transaction_Time;
				else
					data = Transaction_Amount .. '06' .. Terminal_Name .. Terminal_ATC .. Transaction_Date .. Transaction_Time;			
				end
		
				data = pad(data);

				mac = des_mac(data, tac_key);
				mac = string.sub(mac,1,8);
				if(tac ~= mac)
				then
					error('TAC Expected:', mac);
				return;
				end
			else
				print('TAC Not Verify')
			end	
		end	

		Terminal_ATC = big_num_add(Terminal_ATC,'1',16);
		while(string.len(Terminal_ATC)<8)
		do
			Terminal_ATC = "0"..Terminal_ATC;
		end	
		
		Terminal_ATC = string.sub(Terminal_ATC,-8);
	end		
end



function EP_CAPP_Purchase(cmd_80dc, purchase_key_index, purchase_key, tac_key)
	tac_key = string.gsub(tac_key," ","");
	local apdu = '8050 0302 0B' .. purchase_key_index .. Transaction_Amount .. Terminal_Name;
	local res = Send(apdu, '9000');
	local sessionkey;
	local data;
	if (res  == nil)
	then
		error("Initialize_For_CAPP_Purchase throw exception");
		return;
	elseif (string.sub(res,-4) == '9000')
	then
		local balance = string.sub(res,1,8);
		local atc = string.sub(res,9,12);
		local overdrawn = string.sub(res,13,18);
		local key_version = string.sub(res,19,20);
		local key_id = string.sub(res,21,22);
		local rand = string.sub(res,23,30);	
		
		if type(cmd_80dc) ~= "table" then
			error("cmd_80dc is not table");
			return;
		end
		
		for key, cmd in pairs(cmd_80dc) do  
			res = Send(cmd, '9000');
			if (res  == nil)
			then
				error("Update CAPP Data Cache throw exception");
				return;
			end
		end
		
		data = rand .. atc .. string.sub(Terminal_ATC,-4);;
		
		sessionkey = triple_des_ecb_encrypt(data, purchase_key);
		--print(sessionkey);
		if(sessionkey == nil)
		then
			error('Session DPK is nil');
			return;
		end
				
		EP_Balance = balance;
		EP_Offline_ATC = atc;
		data = Transaction_Amount .. '09' .. Terminal_Name .. Transaction_Date .. Transaction_Time;			
				
		data = pad(data);
		
		local mac1 = des_mac(data, sessionkey);
		mac1 = string.sub(mac1,1,8);
		
		apdu = '8054 0100 0F' .. Terminal_ATC .. Transaction_Date .. Transaction_Time .. mac1;
		res = Send(apdu, '9000');
			
		if (res  == nil)
		then
			error("Debit_For_CAPP_Purchase throw exception");
			return;
		elseif (string.sub(res,-4) == '9000')
		then
			local amount;
			local tac = string.sub(res,1,8);
			local mac2 = string.sub(res,9,16);
			
			local mac = des_mac(pad(Transaction_Amount), sessionkey);
			mac = string.sub(mac,1,8);
			if(mac2 ~= mac)
			then
				error('Mac2 Expected:', mac);
				return;
			end
						
			amount = big_num_subtract(EP_Balance,Transaction_Amount,16);
			while(string.len(amount)<8)
			do
				amount = "0"..amount;
			end	
			amount = string.sub(amount,-8);
			EP_Balance = amount;
	
			if(string.len(tac_key) == 32)
			then
				tac_key = xor(string.sub(tac_key,1,16), string.sub(tac_key,17));
				local tac = string.sub(res,1,8);
				
				data = Transaction_Amount .. '09' .. Terminal_Name .. Terminal_ATC .. Transaction_Date .. Transaction_Time;			
		
				data = pad(data);

				mac = des_mac(data, tac_key);
				mac = string.sub(mac,1,8);
				if(tac ~= mac)
				then
					error('TAC Expected:', mac);
				return;
				end
			else
				print('TAC Not Verify')
			end	
		end	

		Terminal_ATC = big_num_add(Terminal_ATC,'1',16);
		while(string.len(Terminal_ATC)<8)
		do
			Terminal_ATC = "0"..Terminal_ATC;
		end	
		
		Terminal_ATC = string.sub(Terminal_ATC,-8);
	end		

end

function EP_Load(index, loadkey, tackey)
	Load(EP, index, loadkey, tackey);
end

function ED_Load(index, loadkey, tackey)
	Load(ED, index, loadkey, tackey);
end

function EP_Purchase(index, loadkey, tackey)
	Purchase(EP, index, loadkey, tackey);
end

function ED_Purchase(index, loadkey, tackey)
	Purchase(ED, index, loadkey, tackey);
end
