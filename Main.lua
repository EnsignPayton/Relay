Relay = LibStub("AceAddon-3.0"):NewAddon("Relay", 
	"AceConsole-3.0", "AceEvent-3.0", "AceComm-3.0")

local options = {
	name = "Relay",
	handler = Relay,
	type = 'group',
	args = {
		msg = {
			type = 'input',
			name = 'My Message',
			desc = 'The message for my addon',
			set = 'SetMyMessage',
			get = 'GetMyMessage'
		}
	}
}

function Relay:GetMyMessage(info)
	return self.db.global.myMessage
end

function Relay:SetMyMessage(info, input)
	self.db.global.myMessage = input
end

LibStub("AceConfig-3.0"):RegisterOptionsTable("Relay", options, {"relay"})

-- Lifecycle Management Functions

function Relay:OnInitialize()
	options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(db)
	self.db = LibStub("AceDB-3.0"):New("RelayDB")
end

function Relay:OnEnable()
end

function Relay:OnDisable()
end


