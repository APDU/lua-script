

set_security_domain_key("404142434445464748494A4B4C4D4E4F","404142434445464748494A4B4C4D4E4F","404142434445464748494A4B4C4D4E4F");

reset();
send("00A4040000","");
send_apdu("00A4040000","");
initialize_update("00");
external_authenticate("01")

print( get_session_key_dek());

local ret = send_apdu_gp("80CA00E000");
ret = send_apdu("80CA00E000","");
ret = send("80CA00E000","");
print(ret);
