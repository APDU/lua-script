local path = package.path;
lfs.chdir(__DIR__);
package.path = path..string.format(";..\\config\\?.lua")

require("pboc_config");

function getBytes (str, start, length)
	return string.sub(str,start,start+length-1);
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

function selectPPSE ()
	local res = Send("00A404000E325041592E5359532E4444463031","9000");
		
	local offset = string.find (res,"4F");

	if (offset == nil) 
	then	
		error("tag4F not founded");
		return;
	else 
		local len = getBytes(res, offset+2, 2);	
		len = tonumber(len,16);
		AID = getBytes(res, offset+4, len*2);
		--print("AID:"..AID);
	end
end


function selectPSE ()
	local res = Send("00A404000E315041592E5359532E4444463031","9000");
		
	local offset = string.find (res,"88");

	if (offset == nil) 
	then	
		error("tag88 not founded");
		return;
	else 
		temp = getBytes(res, offset+4, 2);
		local itemp = tonumber(temp,16)	
		res = Send("00B201"..string.format("%02X",lshift(itemp,3)+4).."00","9000");
		offset = string.find (res,"4F");
		if (offset == nil) 
		then	
			error("tag4F not founded");
			return;
		else 
			local len = getBytes(res, offset+2, 2);	
			len = tonumber(len,16);
			AID = getBytes(res, offset+4, len*2);
		--print("AID:"..AID);
		end
	
	end
end


function selectPBOC ()
	local res = Send("00A40400" .. string.format("%02X",string.len(AID)/2) .. AID,"9000");
					
	local offset = string.find (res,"9F38");
	if (offset  == nil)
	then
		error("TAG9F38 not founded");			
	else  
		local len = getBytes(res, offset+4, 2);	
		len = tonumber(len,16);
		TAG9F38 = getBytes(res, offset+6, len*2);
		--print("PDOL:"..TAG9F38);
	end
		
end

function  getTag (tag)

	tag = string.gsub(tag," ","");
	
	if(tag == "9F66")
	then	
		return TAG9F66
	elseif(tag == "9F02")
	then			
		return TAG9F02
	elseif(tag == "9F03")
	then	
		return TAG9F03
	elseif(tag == "9F1A")
	then
		return TAG9F1A
	elseif(tag == "95")
	then	
		return TAG95
	elseif(tag == "5F2A")
	then	
		return TAG5F2A
	elseif(tag == "9A")
	then	
		return TAG9A
	elseif(tag == "9F21")
	then	
		return TAG9F21
	elseif(tag == "9C")
	then	
		return TAG9C
	elseif(tag == "9F37")
	then	
		return TAG9F37
	elseif(tag == "9F33")
	then	
		return TAG9F33
	elseif(tag == "DF60")
	then	
		return TAGDF60
	elseif(tag == "8A")
	then	
		return TAG8A	
	elseif(tag == "9F4E")
	then	
		return TAG9F4E
	elseif(tag == "9F7A")
	then	
		return TAG9F7A
	elseif(tag == "DF69")
	then	
		return TAGDF69
	else 
			error  "tag not founded"
			return ""
		
	end
	
end



function MakeDOL (dol)

	dol = string.gsub(dol," ","");

	local i = 1
	local res = ""
	local flag = 0
	while (i < string.len(dol) )
	do
		local temp = string.sub(dol,i,i+1);
		local itemp = tonumber(temp,16)		
		if ( bit_and(itemp,0x1f) == 0x1f ) 
		then  flag = 1
		else
			 flag = 0
		end
		
		local tag = string.sub(dol,i,i+2*flag+1);		
		local data = getTag(tag)
		--print(tag.." "..data)
		
		i = i+4+flag*2;
		
		res = res..data;
	end
	return res
end

function  getTLV (data,tag)

	data = string.gsub(data," ","");
	tag = string.gsub(tag," ","");
	
	local i = 1
	local ftag = ""
	local flen = ""
	local fdata = ""
	while (i < string.len(data) )
	do
		local temp = string.sub(data,i,i+1);
		local itemp = tonumber(temp,16)		
		if ( bit_and(itemp,0x1f) == 0x1f ) 
		then  
			ftag = string.sub(data,i,i+3);
			i = i+4;
		else
			ftag = string.sub(data,i,i+1);
			i = i+2;
		end
		
		local lenbyte = string.sub(data,i,i+1);
		if(lenbyte == "81")
		then i = i+2;
		end

		flen =  string.sub(data,i,i+1);
		local iflen = tonumber(flen,16)	
		i = i+2;

		fdata = string.sub(data,i,i+iflen+iflen-1);
		i = i+iflen+iflen
		
		if(ftag == tag)
		then		
			return fdata;
		end
	end
	
	return ""
end


function  ReadAFL (tag_94)

	tag_94 = string.gsub(tag_94," ","");
	
	local i = 1;
	local afl = tag_94;
	local data70 = "";
	while (i < string.len(afl) )
	do
		local sfi = string.sub(afl,i,i+1);
		local snum = string.sub(afl,i+2,i+3);
		local enum = string.sub(afl,i+4,i+5);
		
		local isfi = tonumber(sfi,16);	
		sfi =  string.format("%02X",isfi+4)
		
		local isnum = tonumber(snum,16);	
		local ienum = tonumber(enum,16);	
		
		while (isnum <= ienum )
		do
			local data = Send("00B2"..string.format("%02X",isnum)..sfi.."00","9000");
			isnum = isnum+1;
			
			if((TAG8C == "") or (TAG8D == "") )
			then			
				data70 = getTLV(data,"70");
				if(TAG8C == "" )
				then				
					TAG8C = getTLV(data70,"8C");	
				end		
				if(TAG8D == "" )
				then					
					TAG8D = getTLV(data70,"8D");
				end	
			end			
				
					
		end
		i = i+8;
	end
	
end

function  GPO ()
	local pdolData = MakeDOL(TAG9F38);
	
	local pdolDataLen = string.len(pdolData)/2;	
	local data = Send("80A80000"..string.format("%02X",pdolDataLen+2).."83"..string.format("%02X",pdolDataLen)..pdolData ,"9000");
				
	local firstbyte = string.sub(data,1,2); 
	
	if (firstbyte  == "80")
	then
		TAG82 = string.sub(data,5,8);	
		TAG94 = string.sub(data,9,-5);	
		print("PBOC GPO");
	else  
		data77 = getTLV(data,"77");
		TAG82 = getTLV(data77,"82");
		TAG94 = getTLV(data77,"94");
		print("qPBOC GPO");	
	end	
	
	ReadAFL(TAG94);	
end


function  GPO_NoReadAFL ()
	local pdolData = MakeDOL(TAG9F38);
	
	local pdolDataLen = string.len(pdolData)/2;	
	local data = Send("80A80000"..string.format("%02X",pdolDataLen+2).."83"..string.format("%02X",pdolDataLen)..pdolData ,"9000");
				
	local firstbyte = string.sub(data,1,2); 
	
	if (firstbyte  == "80")
	then
		TAG82 = string.sub(data,5,8);	
		TAG94 = string.sub(data,9,-5);	
		print("PBOC GPO");
	else  
		data77 = getTLV(data,"77");
		TAG82 = getTLV(data77,"82");
		TAG94 = getTLV(data77,"94");
		print("qPBOC GPO");	
	end	
end


function  AppendRecord (apdu, key)
	local res = Send('80CA9F3600',"9000")
	TAG9F36 = getTLV(res,"9F36");
	apdu = string.gsub(apdu," ","");
	local head4 = string.sub(apdu,1,8)
	local data = string.sub(apdu,11,-1)
	local len = string.format("%02X",string.len(data)/2+4);
	local cipherkey = triple_des_ecb_encrypt(string.sub(data, 1, 32), key);
	data = cipherkey .. string.sub(data, 33);
	local res = triple_des_mac(pad(head4..len..data),key,"000000000000"..TAG9F36);	
	local mac = string.sub(res,0,8);	
	Send(head4..len..data..mac,"9000");
end


function  Updata_CAPP_Data_Cache (apdu, key)
	apdu = string.gsub(apdu," ","");
	local head4 = string.sub(apdu,1,8)
	local data = string.sub(apdu,11,-1)
	local len = string.format("%02X",string.len(data)/2+4);
	local res = triple_des_mac(pad(head4..len..data),key,"000000000000"..TAG9F36);	
	local mac = string.sub(res,0,8);	
	Send(head4..len..data..mac,"9000");
end


function  GAC1 (p1)
	local cdolData =  MakeDOL(TAG8C);
	local data = Send("80AE"..p1.."00"..string.format("%02X",string.len(cdolData)/2)..cdolData,"9000");	
	TAG9F36 = string.sub(data,7,10);	
	TAGAC1 = string.sub(data,11,26);
	--print(TAG9F36)
	--print(TAGAC1)
end


function  GAC2 (p1)
	local cdolData =  MakeDOL(TAG8D);
	Send("80AE"..p1.."00"..string.format("%02X",string.len(cdolData)/2)..cdolData,"9000");	
end


function  VerifyPIN (pin)

	pin = string.gsub(pin," ","");
	
	local len = string.len(pin);
	local temp = len..pin.."FFFFFFFFFFFFFFFF";
	temp = string.sub(temp,1,15)
	Send("0020 0080 08 2"..temp,"9000");
end


function  IssuerAuth (arc)
	local in_sk = "000000000000"..TAG9F36.."000000000000"..xor(TAG9F36,"FFFF");		
	local sk = triple_des_ecb_encrypt(in_sk,UDK)
	local data1 = arc.."000000000000"
		
	local d1 = xor(data1,TAGAC1)
	local arpc = triple_des_ecb_encrypt(d1, sk)
	Send("00820000 0A"..arpc..arc,"9000");
end

function pad(str)
	str = str.."80"
	while(string.len(str)%16 ~=0)
	do
		str = str.."00"
	end	
	return str;
end

function  Script (apdu)
	apdu = string.gsub(apdu," ","");
	local head4 = string.sub(apdu,1,8)
	local data = string.sub(apdu,11,-1)
	local len = string.format("%02X",string.len(data)/2+4)
	local in_sk = "000000000000"..TAG9F36.."000000000000"..xor(TAG9F36,"FFFF");		
	local sk = triple_des_ecb_encrypt(in_sk,MAC_UDK)

	local res = triple_des_mac(pad(head4..len..TAG9F36..TAGAC1..data),sk,"0000000000000000")	
	local mac = string.sub(res,0,8);	
	Send(head4..len..data..mac,"9000")
	
end
