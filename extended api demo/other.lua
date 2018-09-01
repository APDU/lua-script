local dir = "D://GitHub//lua-script//extended api demo";

print(get_dir(dir,-1));
print(get_dir(dir,-2));

local a = 0x57;
local b = true;
local c = "1234";
local d = {6,7,8,9};

print(a,b,c,d);
print("int ",a, " bool ", b, " string ", c,d);
print(table.concat(d));


local t1 = get_time();

for i=100,1,-1 do
    print(i)
end

local t2 = get_time();

print(t1,"\n",t2);

local t = time_subtract(t1,t2);

print(t/100," ms");


