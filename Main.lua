--------------------------------------------------------------------------------
-- Initialization
--

Relay = LibStub("AceAddon-3.0"):NewAddon("Relay", 
	"AceConsole-3.0", "AceComm-3.0", "AceEvent-3.0")

function Relay:OnInitialize()
	self:RegisterComm("Relay")
	self:RegisterChatCommand("relay", "SlashCommand")
	self:RegisterEvent("CHAT_MSG_GUILD_ACHIEVEMENT", "AutoGrats")
end

function Relay:OnEnable()
end

function Relay:OnDisable()
end

--------------------------------------------------------------------------------
-- Echo Support
--

function Relay:SendEcho(message)
	self:SendCommMessage("Relay", message, "GUILD")
end

function Relay:OnCommReceived(prefix, message, distribution, sender)
	if (distribution ~= "GUILD" or sender == UnitName("player")) then return end
	local result = message
	SendChatMessage(result, distribution)
end

--------------------------------------------------------------------------------
-- Slash Command Handling
--

function Relay:SlashCommand(input)
	-- Grab the first word (control selector)
	local command, remainder = string.match(input, "(%w+)(.+)")
	if (command == "echo" and remainder ~= "") then
		self:SendEcho(remainder)
	else
		self:PrintHelp()
	end
end

function Relay:PrintHelp()
	self:Print("This is a help message.")
end

--------------------------------------------------------------------------------
-- Auto-Grats Support
--

function Relay:AutoGrats()
	SendChatMessage("Grats!", "GUILD")
end

