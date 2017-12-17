--------------------------------------------------------------------------------
-- AceConfig Support
--

local AC = LibStub("AceConfig-3.0")
local ACD = LibStub("AceConfigDialog-3.0")
local L = Relay.Locale

local defaults = {
	global = {
		echoToggle = true,
		gratsToggle = true
	}
}

--Relay.Options = {
local options = {
	type = "group",
	args = {
			echoToggle = {
				order = 1,
				type = "toggle",
				name = L["Echo Toggle"],
				desc = L["Echo Toggle Desc"],
				get = function(info) return Relay.db.global.echoToggle end,
				set = function(info, value) Relay.db.global.echoToggle = value end
			},
			gratsToggle = {
				order = 2,
				type = "toggle",
				name = L["Grats Toggle"],
				desc = L["Grats Toggle Desc"],
				get = function(info) return Relay.db.global.gratsToggle end,
				set = function(info, value) Relay.db.global.gratsToggle = value end
			}
	}
}

function Relay:InitializeOptions()
	self.db = LibStub("AceDB-3.0"):New("RelayDB", defaults)
	AC:RegisterOptionsTable("Relay", options)
	ACD:AddToBlizOptions("Relay", nil, "general")
end

