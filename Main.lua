--------------------------------------------------------------------------------
-- Initialization
--

Relay = LibStub("AceAddon-3.0"):NewAddon("Relay", 
	"AceConsole-3.0", "AceComm-3.0")


function Relay:OnInitialize()
	Relay:RegisterComm("Relay")
end

function Relay:OnEnable()
end

function Relay:OnDisable()
end

--------------------------------------------------------------------------------
-- AceComm Support
--

function Relay:SendEcho(message)
	self:SendCommMessage("Relay", message, "GUILD")
end

function Relay:OnCommReceived(prefix, message, distribution, sender)
	if (distribution ~= "GUILD" or sender == UnitName("player")) then return end
	local result = message
	SendChatMessage(result, distribution)
end


