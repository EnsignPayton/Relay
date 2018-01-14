--------------------------------------------------------------------------------
-- Initialization
--

Relay = LibStub("AceAddon-3.0"):NewAddon("Relay", 
	"AceConsole-3.0", "AceComm-3.0", "AceEvent-3.0")
Relay.Title = GetAddOnMetadata("Relay", "Title")
Relay.Notes = GetAddOnMetadata("Relay", "Notes")
Relay.Author = GetAddOnMetadata("Relay", "Author")
Relay.Version = GetAddOnMetadata("Relay", "Version")
Relay.Locale = LibStub("AceLocale-3.0"):GetLocale("Relay", true)

local L = Relay.Locale

function Relay:OnInitialize()
	--self.db = LibStub("AceDB-3.0"):New("RelayDB")
	self:InitializeOptions()
	self:RegisterComm("Relay")
	self:RegisterChatCommand("relay", "SlashCommand")
	self:RegisterEvent("CHAT_MSG_GUILD_ACHIEVEMENT", "AutoGrats")
end

function Relay:OnEnable()
end

function Relay:OnDisable()
end


--------------------------------------------------------------------------------
-- Slash Command Handling
--

-- Respond to slash commands "/relay input"
function Relay:SlashCommand(input)
	local command, remainder = self:SplitFirst(input)
	if (command == "echo" and remainder ~= "") then
		self:EchoCommand(remainder)
	elseif (command == "time") then
		self:PlayTimeRequest()
	elseif (command == "exp") then
		self:ExperienceRequest()
	elseif (command == "achiev" and remainder == "points") then
		self:AchievementPointsRequest()
	elseif (command == "achiev") then
		self:AchievementStatusRequest(remainder)
	elseif (command == "gear") then
		self:GearRequest(type)
	else
		self:PrintHelp()
	end
end

-- Command descriptions for help message
Relay.CmdList = {
	echo = L["Echo Desc"],
	time = L["Time Desc"],
	exp = L["Exp Desc"],
	achiev = L["Achiev Desc"],
	gear = L["Gear Desc"]
}

-- Print help message
function Relay:PrintHelp()
	local helpMessage = Relay.Notes
	for key, value in pairs(Relay.CmdList) do
		helpMessage = helpMessage .. "\n|cffffff78" .. key .. "|r - " .. value
	end
	self:Print(helpMessage)
end

--------------------------------------------------------------------------------
-- Commands
--

-- Guild Member Echo Command
function Relay:EchoCommand(message)
	self:SendCommMessage("Relay", "Echo " .. message, "GUILD")
	self:Print(L["Echo Conf 1"] .. message .. L["Echo Conf 2"])
end

-- Guild Member Info Queries
function Relay:PlayTimeRequest()
	self:SendCommMessage("Relay", "TimeQ", "GUILD")
	self:Print(L["Time Conf"])
end

function Relay:ExperienceRequest()
	self:SendCommMessage("Relay", "ExpQ", "GUILD")
	self:Print(L["Exp Conf"])
end

function Relay:AchievementPointsRequest()
	self:SendCommMessage("Relay", "ApsQ", "GUILD")
	self:Print(L["Aciev Conf"])
end

function Relay:AchievementStatusRequest(achievementId)
	self:SendCommMessage("Relay", "AchQ " .. achievementId, "GUILD")
	self:Print(L["Achiev Conf"])
end

function Relay:GearRequest(type)
	if (type ~= "GS" or type ~= "IL") then
		self:Print(L["Gear Error 1"] .. type .. L["Gear Error 2"])
		return
	end

	self:SendCommMessage("Relay", "GearQ " .. type, "GUILD")
	self:Print(L["Gear Conf"])
end

--------------------------------------------------------------------------------
-- Message Handling
--

function Relay:OnCommReceived(prefix, message, distribution, sender)
	-- Only listen on GUILD and ignore our own messages
	if (distribution ~= "GUILD" or sender == UnitName("player")) then return end

	local command, remainder = self:SplitFirst(message)

	if (command == "Echo") then
		self:EchoRespond(remainder)
	elseif (command == "TimeQ") then
		self:PlayTimeRespond()
	elseif (command == "ExpQ") then
		self:ExperienceRespond()
	elseif (command == "ApsQ") then
		self:AchievementPointsRespond()
	elseif (command == "AchQ") then
		self:AchievementStatusRespond(remainder)
	elseif (command == "GearQ") then
		self:GearRespond(remainder)
	end

end

-- Automatic Grats Message
function Relay:AutoGrats()
	SendChatMessage("Grats!", "GUILD")
end

-- Command / Request Responses
function Relay:EchoRespond(message)
	SendChatMessage(message, "GUILD")
end

function Relay:PlayTimeRespond()
	-- TODO: Get play time
end

function Relay:ExperienceRespond()
	local level = UnitLevel("player")
	local currentXp = UnitXP("player")
	local maxXp = UnitXPMax("player")
	self:SendCommMessage("Relay", level .. " " .. currentXp .. " " .. maxXp, "GUILD")
end

function Relay:AchievementPointsRespond()
	local points = GetTotalAchievementPoints()
	self:SendCommMessage("Relay", points, "GUILD")
end

function Relay:AchievementStatusRespond(achievementId)
	local id, name, points, completed = GetAchievementInfo(achievementId)
	self:SendCommMessage("Relay", completed, "GUILD")
end

function Relay:GearRespond(type)
	local result = "????"
	self:SendCommMessage("Relay", result, "GUILD")
end

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