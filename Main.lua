--------------------------------------------------------------------------------
-- Initialization
--

Relay = LibStub("AceAddon-3.0"):NewAddon("Relay", 
	"AceConsole-3.0", "AceEvent-3.0", "AceComm-3.0")

local defaults = {
	profile = {
		autoGrats = true,
		echo = false,
	},
}

local options = {
	name = "Relay",
	handler = Relay,
	type = "group",
	args = {
		echo = {
			name = "Echo",
			desc = "Sends a message to be echoed over guild chat",
			type = "execute",
			func = "SendEcho"
		},
		enables = {
			name = "Enables",
			desc = "Feature enable toggle",
			type = "group",
			args = {
				echo = {
					name = "Echo",
					desc = "Enables or disables message echoing",
					type = "toggle",
					set = function(info, val) Relay.db.profile.echo = val end,
					get = function(info) return Relay.db.profile.echo end
				},
			},
		},
	}
}

LibStub("AceConfig-3.0"):RegisterOptionsTable("Relay", options, {"relay"})

function Relay:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("RelayDB", defaults)
end

function Relay:OnEnable()
end

function Relay:OnDisable()
end

--------------------------------------------------------------------------------
-- Echo
--

Relay:RegisterComm("Relay")

function Relay:OnCommReceived(prefix, message, distribution, sender)
	if (distribution ~= "GUILD") then return end
	local result = message
	SendChatMessage(result, distribution)
end

function Relay:SendEcho(message)
	self:SendCommMessage("Relay", message, "GUILD")
end

