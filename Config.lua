--------------------------------------------------------------------------------
-- AceConfig Support
--

local AC = LibStub("AceConfig-3.0")
local ACD = LibStub("AceConfigDialog-3.0")
local L = Relay.Locale

function Relay:GetOptionDefaults()
	local defaults = {
		profile = {
			echoEnable = true,
			gratsEnable = true,
			timeEnable = true,
			expEnable = true,
			achPtsEnable = true,
			achStatEnable = true,
			gearEnable = true
		}
	}
	return defaults
end

function Relay:GetOptions()
	local options = {
		type = "group",
		args = {
			basicFunctions = {
				type = "group",
				name = "Basic Functions",
				args = {
					echoEnable = {
						order = 1,
						type = "toggle",
						name = L["Echo Toggle"],
						desc = L["Echo Desc"],
						get = function(info) return self.db.profile.echoEnable end,
						set = function(info, value) self.db.profile.echoEnable = value end
					},
					gratsEnable = {
						order = 2,
						type = "toggle",
						name = L["Grats Toggle"],
						desc = L["Grats Desc"],
						get = function(info) return self.db.profile.gratsEnable end,
						set = function(info, value) self.db.profile.gratsEnable = value end
					}
				}
			},
			infoQueries = {
				type = "group",
				name = "Info Requests",
				args = {
					timeEnable = {
						order = 1,
						type = "toggle",
						name = L["Time Toggle"],
						get = function(info) return self.db.profile.timeEnable end,
						set = function(info, value) self.db.profile.timeEnable = value end
					},
					expEnable = {
						order = 2,
						type = "toggle",
						name = L["Exp Toggle"],
						get = function(info) return self.db.profile.expEnable end,
						set = function(info, value) self.db.profile.expEnable = value end
					},
					achPtsEnable = {
						order = 3,
						type = "toggle",
						name = L["AchPts Toggle"],
						get = function(info) return self.db.profile.achPtsEnable end,
						set = function(info, value) self.db.profile.achPtsEnable = value end
					},
					achStatEnable = {
						order = 4,
						type = "toggle",
						name = L["AchStat Toggle"],
						get = function(info) return self.db.profile.achStatEnable end,
						set = function(info, value) self.db.profile.achStatEnable = value end
					},
					gearEnable = {
						order = 5,
						type = "toggle",
						name = L["Gear Toggle"],
						get = function(info) return self.db.profile.gearEnable end,
						set = function(info, value) self.db.profile.gearEnable = value end
					}
				}
			}
		}
	}
	return options
end

function Relay:InitializeOptions()
	self.db = LibStub("AceDB-3.0"):New("RelayDB", defaults)

	local defaults = self:GetOptionDefaults()
	local options = self:GetOptions()
	AC:RegisterOptionsTable("Relay", options)
	-- ACD:AddToBlizOptions("Relay", "Relay", nil, "general")
	ACD:AddToBlizOptions("Relay", nil, "general")
end

