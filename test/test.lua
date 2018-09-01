package.path = string.format("%s\\?.lua", __DIR__);

local square = require "lib" 

local s1 = square:new(1, 2)
local s2 = square:new(2, 2)
local s3 = square:new()
print(s1:get_square())   
print(s2:get_square())       
print(s3:get_square())  