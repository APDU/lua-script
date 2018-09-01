
function getpathes(rootpath, pathes)
    pathes = pathes or {}
    for entry in lfs.dir(rootpath) do
        if entry ~= '.' and entry ~= '..' then
            local path = rootpath .. '\\' .. entry
            local attr = lfs.attributes(path)
            assert(type(attr) == 'table')
            
            if attr.mode == 'directory' then
                getpathes(path, pathes)
            else
                table.insert(pathes, path)
            end
        end
    end
    return pathes
end


local pathes = {}
getpathes(__DIR__, pathes);

for key, path in pairs(pathes) do  
	print(path)
end