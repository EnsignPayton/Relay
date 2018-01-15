--------------------------------------------------------------------------------
-- Utility Functions
--

function Relay:SplitString(input, delimiter)
	if (delimiter == nil) then
		delimiter = "%s"
	end
	local t = {}
	local i = 1
	for str in string.gmatch(input, "([^"..delimiter.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

function Relay:SplitFirst(input)
	local split = self:SplitString(input, " ")
	local first = ""
	local rest = ""
	for i, str in ipairs(split) do
		if i == 1 then
			first = str
		else
			if rest ~= "" then
				rest = rest .. " "
			end
			rest = rest .. str
		end
	end
	return first, rest;
end

function Relay:Printf(...)
	self:Print(string.format(...))
end