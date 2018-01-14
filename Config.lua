--------------------------------------------------------------------------------
-- AceConfig Support
--

local AC = LibStub("AceConfig-3.0")
local ACD = LibStub("AceConfigDialog-3.0")
local L = Relay.Locale

function Relay:GetOptionDefaults()
	local defaults = {
		profile = {
			echoToggle = true,
			gratsToggle = true
		}
	}
	return defaults
end

function Relay:GetOptions()
	local options = {
		type = "group",
		args = {
				echoToggle = {
					order = 1,
					type = "toggle",
					name = L["Echo Toggle"],
					desc = L["Echo Desc"],
					get = function(info) return Relay.db.profile.echoToggle end,
					set = function(info, value) Relay.db.profile.echoToggle = value end
				},
				gratsToggle = {
					order = 2,
					type = "toggle",
					name = L["Grats Toggle"],
					desc = L["Grats Desc"],
					get = function(info) return Relay.db.profile.gratsToggle end,
					set = function(info, value) Relay.db.profile.gratsToggle = value end
				}
		}
	}
	return options
end

function Relay:InitializeOptions()
	local defaults = self:GetOptionDefaults()
	local options = self:GetOptions()
	self.db = LibStub("AceDB-3.0"):New("RelayDB", defaults)
	AC:RegisterOptionsTable("Relay Main", options)
	-- ACD:AddToBlizOptions("Relay Main", "Relay", nil, "general")
	ACD:AddToBlizOptions("Relay Main", nil, "general")
end

