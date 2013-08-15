local lfs = require("lfs")
local config = require("config")

LOG = false
COMPILE = true
--------------------------------------------
-- predefined functions
function printUsage()
	print("Usage:")
	print("lua lua-compiler [-l|-s] <input folder> <output folfer>")
	print("Options:")
	print("-l", "show log")
	print("-s", "no lua compilation, use source code")
end

function log(...)
	if LOG == true then
		print(...)
	end
end

function matchPackage(package)
	if config == nil then
		return true
	end 

	local folders = config["SOURCE FOLDER"]

	if folders == nil then
		return true
	end

	print(folders)

	local ret = false
	for i, folder in ipairs(folders) do 
		if string.match(package, "^"..folder.."%.") ~= nil then 
			ret = true
			break
		end 
	end 

	return ret
end

function processFile(inputPath, outputPath)
	log("processing file:", inputPath)
	local cmd = "luac -o "..outputPath.." "..inputPath

	local ext = string.sub(inputPath, #inputPath-2, #inputPath)
	if  ext ~= "lua" or not COMPILE then
		cmd = "cp -f "..inputPath.." "..outputPath
	end

	-- log(pattern)
	if ext == "lua" then
		local package = string.gsub(inputPath, pattern.."/", "")
		package = string.gsub(package, "%.lua", "")
		package = string.gsub(package, "/", "%.")
		log("updating lua source path: ", package, string.match(package, "^data%."))
		-- if package ~= "AppDelegate" and package ~= "init" and 
		-- 	(
		-- 	nil ~= string.match(package, "^data%.") or 
		-- 	nil ~= string.match(package, "^utils%.") or
		-- 	nil ~= string.match(package, "^ui%.") 
		-- 	) then 
		if matchPackage(package) then
			listFile:write("require(\""..package.."\")\n")	
		end
	end

	os.execute(cmd)
end

function processDir(inputPath, outputPath)
	log("processing directory:", inputPath)
	local outputAttr = lfs.attributes(outputPath)
	if outputAttr == nil then
		lfs.mkdir(outputPath)
	end

	for file in lfs.dir(inputPath) do
		if file ~= "." and file ~= ".." then
            local f = inputPath.."/"..file
            local attr = lfs.attributes (f)
            assert (type(attr) == "table")
            if attr.mode == "directory" then
                processDir(inputPath.."/"..file, outputPath.."/"..file)
            elseif attr.mode == "file" then
                processFile(inputPath.."/"..file, outputPath.."/"..file)
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

if #arg < 2 then
	printUsage()
	return
end

local argIndexBase = 0
for i = 1, #arg do 
	if string.sub(arg[i], 1, 1) == "-" then
		local arg = string.sub(arg[i], 2, #arg[i])
		if arg == "l" then
			LOG = true
		elseif arg == "s" then
			COMPILE = false
		end
		argIndexBase = i
	end
end

local inputRoot = arg[argIndexBase+1]
local outputRoot = arg[argIndexBase+2]

pattern = inputRoot
pattern = string.gsub(pattern, "%%", "%%%")
pattern = string.gsub(pattern, "%-", "%%-")
pattern = string.gsub(pattern, "%.", "%%.")
pattern = string.gsub(pattern, "%*", "%%*")
pattern = string.gsub(pattern, "%+", "%%+")
pattern = string.gsub(pattern, "%?", "%%?")

local attr = lfs.attributes(inputRoot)
if attr == nil then
	print("Can't open path:", inputRoot)
	return
end

-- create list file
listFile = io.open(outputRoot.."/list.lua", "w")

if attr.mode == "file" then
	processFile(inputRoot, outputRoot)
elseif attr.mode == "directory" then
	processDir(inputRoot, outputRoot)
else
	printUsage()
end

listFile:close()
print("compile task DONE!")