local _gp = {
}           -- 局部的变量
_gp.__index = _gp

--keyVer = "00";
--securityLevel = "01";
ENC = "404142434445464748494A4B4C4D4E4F"
MAC = "404142434445464748494A4B4C4D4E4F"
DEK = "404142434445464748494A4B4C4D4E4F"
SW9000 = "9000"
gp_ver = "00"
gp_sl = "01"
counter=0;
isd="";

FOR_PERSONALIZATION = 32;
FOR_EXTRADITION = 16;
FOR_MAKE_SELECTABLE = 8;
FOR_INSTALL = 4;
FOR_INSTALL_SELECTABLE = 12;
FOR_LOAD = 2;
FOR_REGISTRY_UPDATE = 64;


function _gp:new()
	local o = {};
	setmetatable(o, _gp);
	set_security_domain_key(ENC,MAC,DEK);
	return o;
end

function pad(str)
	str = str.."80"
	while(string.len(str)%16 ~=0)
	do
		str = str.."00"
	end	
	return str;
end

function secAPDU(APDU,EXPECT)
	local apdu = string.gsub(APDU," ","");
	local expect = string.gsub(EXPECT," ","");	
	local res = send_apdu_gp(apdu);
	if(res == nil)
	then
		error("send_apdu_gp throw exception");
		return;
	end
	local sw = string.sub(res,-4,-1);
	
	if(string.sub(res,1,2)=="6C")
	then
		res = send_apdu_gp(string.sub(apdu,1,8)..string.sub(res,3,4));	
		if(res == nil)
		then
			error("send_apdu_gp throw exception");
			return;
		end
		sw = string.sub(res,-4,-1);
	elseif(string.sub(res,1,2)=="61")
	then
		res = send_apdu_gp("00C00000"..string.sub(res,3,4));
		if(res == nil)
		then
			error("send_apdu_gp throw exception");
		return;
	end
		sw = string.sub(res,-4,-1);
	end		
	
	if(expect == "")
	then	return;
	end
	
	if( string.len(expect)==4 )
	then
		if( expect ~= sw )
		then error("Expected SW:"..EXPECT);
		end
	elseif( expect ~= res )
	then error("Expected Data:"..EXPECT);
	end	
	
end

function _gp:reset()
  counter=0;
  local res = reset();
  if(res == nil)
	then
		error("reset throw exception");
		return;
	end
end

function _gp:setKey(enc,mac,dek)
  set_security_domain_key(enc,mac,dek);
end

function _gp:init(keyVer)
  local res = initialize_update(keyVer)
  if(res == nil)
	then
		error("initialize_update throw exception");
		return;		
	end
	
	local sw = string.sub(res,-4,-1);
	if(sw ~= "9000")
	then
		error("initialize_update failed");
	end
	
	
end

function _gp:ext(securityLevel)
  local res = external_authenticate(securityLevel)
  if(res == nil)
	then
		error("external_authenticate throw exception");
		return;
	end
	local sw = string.sub(res,-4,-1);
	if(sw ~= "9000")
	then
		error("external_authenticate failed");
	end
end

function _gp:apdu(apdu,sw)
  local res = send_apdu_gp(apdu,sw);
  if(res == nil)
	then
		error("send_apdu_gp throw exception");
		return;
	end
end

function _gp:getDekSK()
   local res = get_session_key_dek();
   if(res == nil)
	then
		error("send_apdu_gp throw exception");
		return;
	end
	return res;
end



function _gp:store_data(P1, DGI)
    local dgi = string.gsub(DGI," ","");
	local p1 = P1;
    local p2 = counter;

    dgi4 = string.sub(dgi,1,4)
    if(dgi4=="8201" or dgi4=="8202" or dgi4=="8203" or dgi4=="8204" or dgi4=="8205")
	then
        data = string.sub(dgi,7,-1)
		data = pad(data);
        dgi = dgi4..string.format("%02X",string.len(data)/2)..data;
    end

    if ( bit_and(P1,0x60) == 0x60)
	then
        dgi6 = string.sub(dgi,1,6)
        data = string.sub(dgi,7,-1)
        dgi = dgi6..triple_des_ecb_encrypt(data, _gp:getDekSK());
    end

    secAPDU("80E2"..string.format("%02X",p1)..string.format("%02X",p2)..string.format("%02X",string.len(dgi)/2)..dgi,"9000");
    counter = counter + 1;
    if ( bit_and(P1,0x80) == 0x80) 
	then
		counter = 0;
	end
	
end

function _gp:select (AID,SW)
	counter=0;
	local aid = string.gsub(AID," ","");
	local sw = string.gsub(SW," ","");
	secAPDU("00A40400"..string.format("%02X",string.len(aid)/2)..aid,sw);
end

function delete(P2,DATA,SW)
	local data = string.gsub(DATA," ","");
	local sw = string.gsub(SW," ","");
	secAPDU("80E400"..string.format("%02X",P2)..string.format("%02X",string.len(data)/2)..data,sw);
end

function _gp:delete_instance(AID,SW)
	AID = string.gsub(AID," ","");
	delete(0,"4F"..string.format("%02X",string.len(AID)/2)..AID,SW)
end

function _gp:delete_package(AID,SW)
	AID = string.gsub(AID," ","");
	delete(0x80,"4F"..string.format("%02X",string.len(AID)/2)..AID,SW)
end

function _gp:install(p1, p2, DATA, SW) 
	local data = string.gsub(DATA," ","");
    secAPDU("80E6"..string.format("%02X",p1)..string.format("%02X",p2)..string.format("%02X",string.len(data)/2)..data, SW);
end

function _gp:get_data(tag,SW)
	secAPDU("80CA"..tag.."00",SW);
end

function _gp:put_des_key_set(ver, key1, key2, key3, SW) 
	local temp1 = string.sub(triple_des_ecb_encrypt("0000000000000000",key1),1,6); 
	local temp2 = string.sub(triple_des_ecb_encrypt("0000000000000000",key2),1,6);
	local temp3 = string.sub(triple_des_ecb_encrypt("0000000000000000",key3),1,6);
	local data = ver.."8010"..triple_des_ecb_encrypt(key1,_gp:getDekSK()).."03"..temp1..
					  "8010"..triple_des_ecb_encrypt(key2,_gp:getDekSK()).."03"..temp2..
					  "8010"..triple_des_ecb_encrypt(key3,_gp:getDekSK()).."03"..temp3
	data = string.format("%02X",string.len(data)/2)..data
	
    secAPDU("80D80081"..data, SW);
end

function _gp:replace_des_key_set(ver_old,ver, key1, key2, key3, SW) 
	local temp1 = string.sub(triple_des_ecb_encrypt("0000000000000000",key1),1,6); 
	local temp2 = string.sub(triple_des_ecb_encrypt("0000000000000000",key2),1,6);
	local temp3 = string.sub(triple_des_ecb_encrypt("0000000000000000",key3),1,6);
	local data = ver.."8010"..triple_des_ecb_encrypt(key1,_gp:getDekSK()).."03"..temp1..
					  "8010"..triple_des_ecb_encrypt(key2,_gp:getDekSK()).."03"..temp2..
					  "8010"..triple_des_ecb_encrypt(key3,_gp:getDekSK()).."03"..temp3
	data = string.format("%02X",string.len(data)/2)..data
	
    secAPDU("80D8"..ver_old.."81"..data, SW);
end

function _gp:put_des_key(ver, key1, SW) 
	local temp1 = string.sub(triple_des_ecb_encrypt("0000000000000000",key1),1,6); 	
	local data = ver.."8010"..triple_des_ecb_encrypt(key1,_gp:getDekSK()).."03"..temp1;
					
	data = string.format("%02X",string.len(data)/2)..data
	
    secAPDU("80D80001"..data, SW);
end

function _gp:put_rsa_key(ver, n, e, SW) 
	local data = ver.."A1"..string.format("%02X",string.len(n)/2)..n.."A0"..string.format("%02X",string.len(e)/2)..e;
	--local data = ver.."A1"..string.format("%02X",string.len(n)/2)..n.."A0"..string.format("%02X",string.len(e)/2)..e.."00";				
	data = string.format("%02X",string.len(data)/2)..data
	
    secAPDU("80D80001"..data, SW);
end


return _gp
