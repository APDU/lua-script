package.path =string.format("%s\\?.lua", __DIR__);

print("aes.lua\n");
require("aes");
print("\ndes.lua\n");
require("des");

print("\nhash.lua\n");
require("hash");

print("\nhmac.lua\n");
require("hmac");

print("\nrsa.lua\n");
require("rsa");

print("\nsm2.lua\n");
require("sm2");

print("\nsm3.lua\n");
require("sm3");

print("\nsm4.lua\n");
require("sm4");

print("\necdsa.lua\n");
require("ecdsa");
