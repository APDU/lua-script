package.path = package.path..string.format(";%s\\gp\\lib\\?.lua", get_dir(__DIR__,-1))..string.format(";%s\\config\\?.lua", __DIR__)

local gplib = require("gp_lib");
require("pboc_config");

p = "D0BAD286ED4E1CBE6CED5391A9696ED58F317E4A52D0E37C755C01225F676AB712A15D1B953BD67FB8DFB610655965352583B46B260E481661DF74FE85C20AC1";
q = "C1960C87E0333FCBB1C2BBEB787019D6080B33C8F5039C2BD55CC1D247398AA5DBD47FA4E1FF85F425D214B4B32A341E72C1F9FF6765D1155963BEC02E8958D9";
dp = "3D25ADCD0731EDEBBF3F5B4EFDC13C4DE5D00AFE3CFAA2D9F00B8EED81E36AF8CCC566E050BCA1DEF2CADEAC38F492589A6FD5E7D9D32F3D1758FE0E1E233541";
dq = "5A2479BF4799F5A9EF236387F9341203C5091A5B08245F33560DF43EEB6592F73A8F0FC5026B8EBFAA60D1BD76F43F02B2A33ABB40357C0FB9E92568AE02CCB9";
pq = "0EB41A42801F08D5C16EE593800E16C42894639D1D16FCD366FE4D80A4154B15FB25AC5C24D7607848B55F022230FE4FAD4913AD526CB928A762F183625D775B";

local gp = gplib:new();

gp:setKey(ENC,MAC,DEK);

gp:reset();
gp:select("","9000");
gp:init(gp_ver);
gp:ext(gp_sl);
gp:delete_instance("A0000003330101","");
gp:delete_instance("A000000333010101","");
gp:delete_instance("A000000333010102","");
gp:delete_instance("325041592E5359532E4444463031","");
gp:delete_instance("315041592E5359532E4444463031","");

gp:install(FOR_INSTALL_SELECTABLE, 0, "05 315041592E 0E 315041592E5359532E4444463031 0E 325041592E5359532E4444463031010002C90000", SW9000);
gp:install(FOR_INSTALL_SELECTABLE, 0, "05 315041592E 0E 315041592E5359532E4444463031 0E 315041592E5359532E4444463031010002C90000", SW9000);
gp:install(FOR_INSTALL_SELECTABLE, 0, "06 A00000033301 07 A0000003330101 07 A0000003330101 0100 02 C90000", SW9000);
	
gp:select("325041592E5359532E4444463031",SW9000);
gp:init(gp_ver);
gp:ext(gp_sl);
gp:store_data(0x80,"910220A51EBF0C1B61194F07A0000003330101500B50424F4320437265646974870101",SW9000);

gp:select("315041592E5359532E4444463031",SW9000);
gp:init(gp_ver);
gp:ext(gp_sl);
gp:store_data(0,"910214A5128801015F2D084343422050424F439F110101",SW9000);
gp:store_data(0x80,"01012C702A61284F07A0000003330101500B50424F43204372656469749F120F4341524420494D4147452030303335",SW9000);


gp:select("A0000003330101",SW9000);
gp:init(gp_ver);
gp:ext(gp_sl);
gp:store_data(0,"910356A554500B50424F43204372656469748701019F38189F66049F02069F03069F1A0295055F2A029A039C019F37045F2D084343422050424F439F1101019F120F4341524420494D4147452030303335BF0C059F4D020B0A",SW9000);
gp:store_data(0,"910244A542500B50424F43204372656469748701019F38069F33039F4E145F2D084343422050424F439F1101019F120F4341524420494D4147452030303335BF0C059F4D020B0A",SW9000);
gp:store_data(0,"01012E702C57116228000100001117D301220101234567899F1F1630313032303330343035303630373038303930413042",SW9000);
gp:store_data(0,"01022770255F200F46554C4C2046554E4354494F4E414C9F631011223344556677880000000000000000",SW9000);
gp:store_data(0,"0201B37081B0908180229103A5E3120F2D2862091176AA2BD4E24D69E7EEF7B9195C91EA0088AECFF47EDFA0BEEF7C391DF3B05F717DCC06FFC8EEFF90BA14212B8A52AD48B33277B2E230D40B3E76DC59778926F1D8739E106CD741DE06A7423DFBA25E02F12E543D13D1B471806526024981B7D26B4BF6E5558604CCC289F59E8A802F45FB3D9E679F32010392248B643D1EAF2EA784AC205303C90E745EA2EFA5CBF02CC47D47833BB7B27ECC6962385A4B8F0180",SW9000);
gp:store_data(0,"020286708183938180817B58E992D032B7F0C0B5E0AA146F53FDD20DE1B3BFD9BFD28D0D7B5D4B69A62E1442847EC0FCED37C41A653AC8AEFF680704607E7D6EDBB683FDF8AE3CBA63FD2FB93845D9DA06F5B6CC09E807A0B69D5CF6FAFFDEC65A3E00C560947E4822FD74D0A4994493C9D5E92F83634C1EE77BC805F838A9A79E114787B65F6B74B9",SW9000);
gp:store_data(0,"0203BA7081B79F468180875F85F08A89F4B500FA8C1A55407D88322710E3B885390D945422A73A0AB876F4C4FBC9C49C3083F38C9EFE6C7B21F6541050BF11642A28329C65D8831C80CC0D753D412112800FF2FA12ECC83B318A26EE44E313BD5D1C45C806787387DB91D259D75D350F9CD18B34C635A94EF343A2E88F8A4162D83BC900EA2CF55928209F47030100019F482A518B0EA3ABA9343F1778545FFB49EE840BBCEA457DBAABBFD755BA0F943A08A59CFFB6066B4084767599",SW9000);
gp:store_data(0,"02049470819190818E12622800011220000001040011409F483BF2CC71C5093728318061E3F768EA7C170F82DD8C4B979FBD8C76A129F93FB5746E96F5E49B987FFB521E473B25E1B017C30BE3FC638BA14D5FA4AADC1673DF81BF5CC82AABB7CF3C9165EDEEA2EC0CCC56AB19F1661E012CD33D4BFBEC55A88990EB25B4A4058C8E4B11C1F9EA2055E403CA76AC8A991DE80A35BED348",SW9000);
gp:store_data(0,"02054A70488F0157934313DAC1173A31DD681C6F8FE3BA6C354AD3924A4ADFD15EB0581BC1B37A1EB1C88DA29B47155F62FCF4CCCD201B134351A049D77E81F6A6C66E9CB32664F41348DA11F6",SW9000);
gp:store_data(0,"02069B7081989F468194146228000100001117FFFF122000000304001140C3AC12B81B9D175936B5BF72BB8FE3A2266BC013B2E94F5837F16AA1C01AA7323B75626AB64D02AED20CC6F440841F10EE6873BCBEA3F41D6869D0FEADD71154C3AC12B81B9D175936B5BF72BB8FE3A2266BC013B2E94F5837F16AA1C01AA7323B75626AB64D02AED20CC6F440841F10EE6873BCBEA3F41D6869D0FEADD71154",SW9000);
gp:store_data(0,"03011D701B5A0862280001000011175F24033012315F25039507019F08020030",SW9000);
gp:store_data(0,"03024270408C189F02069F03069F1A0295055F2A029A039F21039C019F37048D1A8A029F02069F03069F1A0295055F2A029A039F21039C019F37049F420201565F30020201",SW9000);
gp:store_data(0,"030310700E5F3401015F280201569F0702FFC0",SW9000);
gp:store_data(0,"03042E702C8E120000000000000000410342035E0343031F009F0D05F0200400009F0E0500508800009F0F05F020049800",SW9000);
gp:store_data(0,"03051570135A0862280001000011175F3401019F08020030",SW9000);
gp:store_data(0,"04010B70099F7406454343313131",SW9000);
gp:store_data(0,"0D01359F5801039F5901079F5301039F7201009F54060000000070009F4F199A039F21039F02069F03069F1A025F2A029F4E149C019F3602",SW9000);
gp:store_data(0,"0E018C9F510201569F520282409F5601809F570201569F760200009F77060000000150009F78060000000010009F79060000000100009F6D060000000015009F6804411020009F6C0230009F6B060000000011009F5D06000000000001DF71020344DF7906000000020000DF7706000000030000DF7806000000002000DF7606000000003000DF7206000000000500",SW9000);
gp:store_data(0,"91041282025C00940C080102001001030018010401",SW9000);
gp:store_data(0,"92071F82027000940C1001030018010101200101009F100A07010103000000010A01",SW9000);
gp:store_data(0,"92000B9F10080701010300000001",SW9000);
gp:store_data(0x60,DGI8000,SW9000);
gp:store_data(0,DGI9000,SW9000);

gp:store_data(0,DGIA001,SW9000);
gp:store_data(0x60,DGI8020,SW9000);
gp:store_data(0,DGI9020,SW9000);
gp:store_data(0x60,DGI8010,SW9000);
gp:store_data(0,DGI9010,SW9000);

gp:store_data(0x60,"8201"..string.format("%02X",string.len(p)/2)..pq,SW9000);
gp:store_data(0x60,"8202"..string.format("%02X",string.len(p)/2)..dq,SW9000);
gp:store_data(0x60,"8203"..string.format("%02X",string.len(p)/2)..dp,SW9000);
gp:store_data(0x60,"8204"..string.format("%02X",string.len(p)/2)..q,SW9000);
gp:store_data(0xE0,"8205"..string.format("%02X",string.len(p)/2)..p,SW9000);




