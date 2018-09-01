local tt = {
 width=0,
 height=0,
} 
tt.__index = tt


function tt:new(width, height)
	local o = {}
	setmetatable(o, tt)
	if(width==nil or height ==nil)
	then
		o.width=3;
		o.height=3;
	else
		o.width=width;
		o.height=height;
	end

	return o
end

function tt:get_square()
    return self.width * self.height
end

function tt:get_circumference()
    return (self.width + self.height) * 2
end

return tt