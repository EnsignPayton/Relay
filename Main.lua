--------------------------------------------------------------------------------
-- Initialization
--

Relay = LibStub("AceAddon-3.0"):NewAddon("Relay", 
	"AceConsole-3.0", "AceComm-3.0", "AceEvent-3.0")

function Relay:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("RelayDB")
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
	self:Print("Echo message \"" .. message .. "\" sent.")
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

-- TODO: Remove if we use AceConfig
Relay.CmdList = {
	echo = "Echoes a message across the guild"
}

function Relay:PrintHelp()
	local helpMessage = "Guild chat enhancement."
	for key, value in pairs(Relay.CmdList) do
		helpMessage = helpMessage .. "\n|cffffff78" .. key .. "|r - " .. value
	end
	self:Print(helpMessage)
end

--------------------------------------------------------------------------------
-- Auto-Grats Support
--

function Relay:AutoGrats()
	SendChatMessage("Grats!", "GUILD")
end

