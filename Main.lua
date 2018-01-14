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
	-- elseif (command == "time") then
	-- 	self:PlayTimeRequest()
	elseif (command == "exp") then
		self:ExperienceRequest()
	elseif (command == "rep") then
		self:ReputationRequest(remainder)
	elseif (command == "achiev" and remainder == "points") then
		self:AchievementPointsRequest()
	elseif (command == "achiev") then
		self:AchievementStatusRequest(remainder)
	-- elseif (command == "gear") then
	-- 	self:GearRequest(remainder)
	elseif (command == "config") then
		self:OpenConfig()
	elseif (command == "help") then
		self:PrintHelp()
	else
		self:PrintBanner()
	end
end

-- Command descriptions for help message
function Relay:GetCommandList()
	local list = {
		echo = L["Echo Desc"],
		-- time = L["Time Desc"],
		exp = L["Exp Desc"],
		rep = L["Rep Desc"],
		achiev = L["Achiev Desc"],
		-- gear = L["Gear Desc"],
		config = L["Config Desc"]
	}
	return list
end

-- Print help message
function Relay:PrintHelp()
	for key, value in pairs(self:GetCommandList()) do
		self:Print("|cffffff78" .. key .. "|r - " .. value)
	end
end

function Relay:PrintBanner()
	self:Print(Relay.Notes .. "\n|cffffff78" .. "help" .. "|r - " .. L["Help Desc"])
end

-- Open options
function Relay:OpenConfig()
	InterfaceOptionsFrame_OpenToCategory("Relay")
end

--------------------------------------------------------------------------------
-- Commands
--

-- Guild Member Echo Command
function Relay:EchoCommand(message)
	self:SendCommMessage("Relay", "Echo " .. message, "GUILD")
	self:Printf(L["Echo Conf"], message)
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

function Relay:ReputationRequest(factionId)
	self:SendCommMessage("Relay", "RepQ " .. factionId, "GUILD")
	self:Print(L["Rep Conf"])
end

function Relay:AchievementPointsRequest()
	self:SendCommMessage("Relay", "ApsQ", "GUILD")
	self:Print(L["Achiev Conf"])
end

function Relay:AchievementStatusRequest(achievementId)
	self:SendCommMessage("Relay", "AchQ " .. achievementId, "GUILD")
	self:Print(L["Achiev Conf"])
end

function Relay:GearRequest(type)
	if (type ~= "GS" and type ~= "IL") then
		self:Printf(L["Gear Error"], type)
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
	-- if (distribution ~= "GUILD" or sender == UnitName("player")) then return end

	local command, remainder = self:SplitFirst(message)

	-- Echo Command
	if (command == "Echo") then
		self:EchoRespond(remainder)
	-- Info Requests
	elseif (command == "TimeQ") then
		self:PlayTimeRespond()
	elseif (command == "ExpQ") then
		self:ExperienceRespond()
	elseif (command == "RepQ") then
		self:ReputationRespond(remainder)
	elseif (command == "ApsQ") then
		self:AchievementPointsRespond()
	elseif (command == "AchQ") then
		self:AchievementStatusRespond(remainder)
	elseif (command == "GearQ") then
		self:GearRespond(remainder)
	-- Info Responses
	elseif (command == "TimeR") then
		self:PlayTimeHandle(remainder, sender)
	elseif (command == "ExpR") then
		self:ExperienceHandle(remainder, sender)
	elseif (command == "RepR") then
		self:ReputationHandle(remainder, sender)
	elseif (command == "ApsR") then
		self:AchievementPointsHandle(remainder, sender)
	elseif (command == "AchR") then
		self:AchievementStatusHandle(remainder, sender)
	elseif (command == "GearR") then
		self:GearHandle(remainder, sender)
	end

end

-- Automatic Grats Message
function Relay:AutoGrats()
	if not self.db.profile.gratsEnable then return end
	SendChatMessage("Grats!", "GUILD")
end

-- Echo
function Relay:EchoRespond(message)
	if not self.db.profile.echoEnable then return end
	SendChatMessage(message, "GUILD")
end

-- Send Info Responses
function Relay:PlayTimeRespond()
	if not self.db.profile.timeEnable then return end
	-- TODO: Get play time
	local time = "???? ????"
	self:SendCommMessage("Relay", "TimeR " .. time, "GUILD")
end

function Relay:ExperienceRespond()
	if not self.db.profile.expEnable then return end
	local level = UnitLevel("player")
	local currentXp = UnitXP("player")
	local maxXp = UnitXPMax("player")
	self:SendCommMessage("Relay", "ExpR " .. level .. " " .. currentXp .. " " .. maxXp, "GUILD")
end

function Relay:ReputationRespond(factionId)
	if not self.db.profile.repEnable then return end
	local a, b, c, d, e, value = GetFactionInfoByID(factionId)
	self:SendCommMessage("Relay", "RepR " .. factionId .. " " .. value, "GUILD")
end

function Relay:AchievementPointsRespond()
	if not self.db.profile.achPtsEnable then return end
	local points = GetTotalAchievementPoints()
	self:SendCommMessage("Relay", "ApsR " .. points, "GUILD")
end

function Relay:AchievementStatusRespond(achievementId)
	if not self.db.profile.achStatEnable then return end
	local id, name, points, completed = GetAchievementInfo(achievementId)
	local result
	if completed then result = "true" else result = "false" end
	self:SendCommMessage("Relay", "AchR " .. id .. " " .. result, "GUILD")
end

function Relay:GearRespond(type)
	if not self.db.profile.gearEnable then return end
	-- TODO: Get GearScore / average item level
	local result = "????"
	self:SendCommMessage("Relay", "GearR " .. result, "GUILD")
end

-- Handle Info Responses
function Relay:PlayTimeHandle(message, sender)
	self:Print(sender .. ": " ..message)
end

function Relay:ExperienceHandle(message, sender)
	self:Print(sender .. ": " ..message)
end

function Relay:ReputationHandle(message, sender)
	self:Print(sender .. ": " ..message)
end

function Relay:AchievementPointsHandle(message, sender)
	self:Print(sender .. ": " ..message)
end

function Relay:AchievementStatusHandle(message, sender)
	self:Print(sender .. ": " ..message)
end

function Relay:GearHandle(message, sender)
	self:Print(sender .. ": " ..message)
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

function Relay:Printf(...)
	self:Print(string.format(...))
end
