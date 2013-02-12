local lfs = require("lfs")

LOG = false
--------------------------------------------
-- predefined functions
function printUsage()
	print("Usage:")
	print("lua replace.lua [-l] file/folder pattern replacement")
	print("Options:")
	print("-l", "show log")
end

function log(...)
	if LOG == true then
		print(...)
	end
end

function processFile(path, pattern, repl)
	newpath = string.gsub(path, pattern, repl)
	if newpath ~= path then
		log("change file name from", path)
		log("to", newpath)
		os.execute("mv -f "..path.." "..newpath)
		path = newpath
	end

	log("processing file:", path)
	local fi = io.open(path, "r")
	local content = fi:read("*all")
	fi:close()

	content = string.gsub(content, pattern, repl)

	local fo = io.open(path, "w+")
	fo:write(content)
	fo:close()
end

function processDir(path, pattern, repl)
	newpath = string.gsub(path, pattern, repl)
	if newpath ~= path then
		log("change path name from", path)
		log("to", newpath)
		os.execute("mv -f "..path.." "..newpath)
		path = newpath
	end

	log("processing directory:", path)
	for file in lfs.dir(path) do
		if file ~= "." and file ~= ".." then
            local f = path..'/'..file
            local attr = lfs.attributes (f)
            assert (type(attr) == "table")
            if attr.mode == "directory" then
                processDir(f, pattern, repl)
            elseif attr.mode == "file" then
                processFile(f, pattern, repl)
            else
            	log("skip:", f)
            end
        end
	end
end
--------------------------------------------
-- main program starts here

-- get the arguments
local arg = {...}

if #arg < 3 then
	printUsage()
	return
end

local argIndexBase = 0
for i = 1, #arg do 
	if string.sub(arg[i], 1, 1) == "-" then
		local arg = string.sub(arg[i], 2, #arg[i])
		if arg == "l" then
			LOG = true
		end
		argIndexBase = i
	end
end

local path = arg[argIndexBase+1]
local pattern = arg[argIndexBase+2]
local repl = arg[argIndexBase+3]

local attr = lfs.attributes(path)
if attr == nil then
	print("Can't open path:", path)
	return
end


if attr.mode == "file" then
	processFile(path, pattern, repl)
elseif attr.mode == "directory" then
	processDir(path, pattern, repl)
else
	printUsage()
end

print("Replacement task DONE!")