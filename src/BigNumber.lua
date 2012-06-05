--[==[
Copyright (C) 2012 Mohammed Eihab

Permission is hereby granted, free of charge, to any person obtaining a copy of this 
software and associated documentation files (the "Software"), to deal in the Software 
without restriction, including without limitation the rights to use, copy, modify, merge, 
publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons 
to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or 
substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING 
BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER 
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
OR OTHER DEALINGS IN THE SOFTWARE.
]==]

--[==[

UpdateLog:
	v0.02:
		Added copyright, changed functions to allow for different arguments and
		the result of such functions do not change the table's value.
	v0.01: 
		Added documentation, addition, multiplication, powers, and _tostring()
]==]
local lib = setmetatable({},
	{
		__tostring = function(self) return "hi" end;
	})
lib.__index = lib;
doc = {};

local _VERSION = 0.01;
local _PROJECTNAME = "BigNumber"
function lib.Version()
	return tostring(_VERSION);
end

doc["Version"] = [==[]
Method@
	Version ( )
		returns: string 'version'

		Returns the current version of the ]==].._PROJECTNAME..[==[ Library.
]==]

local function _new(var)
	local var = tostring(var) or "0";
	local array = {};
	for i = 1, string.len(var) do
		table.insert(array, string.sub(var, i, i))
	end
	return array;
end

doc["new"] = [==[
Method@
	new ( string 'number' )
		returns: table 'BigNumber'

	new ( number 'number' )
		returns: table 'BigNumber'

		Returns a BigNumber table.
]==]

function lib:new(var)
	local number = _new(var);

	local t = setmetatable(
		number, lib
		)
	return t;
end

doc["tostring"] = [==[
Metamethod@
	__tostring ( )
		returns: string 'BigNumber'

		Returns a string form of the BigNumber table.
]==]

function lib:__tostring()
	return table.concat(self)
end

doc["add"] = [==[
Metamethod@
	__add ( string 'number' )
		returns: table 'BigNumber'

	__add ( number 'number')
		returns: table 'BigNumber'

	__add ( table 'BigNumber')
		returns: table 'BigNumber'

	Returns a the resulting table of an addition between BigNumber 
	table and an inserted value.
]==]

function lib:__add(num)
	local decoy = lib:new(tostring(self));
	local tabLen = #decoy
	local numLen = string.len(tostring(num))
	num = tostring(num)
	if numLen < tabLen then
		for i = 1, tabLen - numLen do
			num = "0"..num
		end
	end
	if tabLen < numLen then
		for i = 1, numLen - tabLen do
			table.insert(decoy, 1, 0)
		end
	end
	numLen = string.len(tostring(num))
	tabLen = #decoy
	num = string.reverse(num)
	for i = tabLen, tabLen - numLen + 1, -1 do
		local subbedNum = tonumber(string.sub(num, numLen - i + 1, numLen - i + 1 ))
		if decoy[i] + subbedNum then
			decoy[i] = decoy[i] + subbedNum
		end
	end
	for i = #decoy, 1, -1 do
		if decoy[i] > 9 then
			decoy[i] = decoy[i] - 10
			if decoy[i - 1] ~= nil then
				decoy[i - 1] = decoy[i - 1] + 1
			elseif decoy[i - 1] == nil then
				table.insert(decoy, 1, 1)
			end
		end
	end
	return decoy
end

doc["multiply"] = [==[
Metamethod@
	__mul ( string 'number' )
		returns: table 'BigNumber'

	__mul ( number 'number' )
		returns: table 'BigNumber'

	__mul ( table 'number' )
		returns: table 'BigNumber'

	Returns a BigNumber table from the product of
	a BigNumber table and the inputted value.
]==]

function lib:__mul(num)
	local decoy = lib:new(tostring(self))
	local ex = tostring(self)
	for i = 2, tonumber(tostring(num)) do
	decoy = decoy + ex
	end
	return decoy
end

doc["power"] = [==[
Metamethod@
	__pow ( string 'number' )
		returns: table 'BigNumber'

	__pow ( number 'number' )
		returns: table 'BigNumber'

	__pow ( table 'number' )
		returns: table 'BigNumber'

	Returns a BigNumber table from the power of
	a BigNumber table and the inputted value.
]==]

function lib:__pow(num)
	local decoy = lib:new(tostring(self))
	local ex = tostring(self)
	for i = 2, tonumber(tostring(num)) do
		decoy = decoy * ex;
	end
	return decoy
end

_G[_PROJECTNAME] = lib;
print(("Loaded %s library. Current build version: %s"):format(_PROJECTNAME, _VERSION))

--[==[
	Contact details:
		Mohammed Eihab
		E-Mail: MohammedEihabMail@gmail.com
]==]