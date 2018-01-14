local L = LibStub("AceLocale-3.0"):NewLocale("Relay", "enUS", true)

if not L then return end

-- Command Descriptions
L["Echo Desc"] = "Relay a message through guild members"
L["Time Desc"] = "Get guild member play time"
L["Exp Desc"] = "Get guild member level and experience"
L["Achiev Desc"] = "Get guild member achievement points (use 'points') or achievement status (use an achievement ID)"
L["Gear Desc"] = "Get guild member GearScore (use 'GS') or average item level (use 'IL')"

-- Command Confirmations
L["Echo Conf 1"] = "Echo message \""
L["Echo Conf 2"] = "\" sent."
L["Time Conf"] = "Queried guild for play time."
L["Exp Conf"] = "Queried guild for experience."
L["Achiev Conf"] = "Queried guild for achievement info."
L["Gear Conf"] = "Queried guild for gear info."

-- Command Error Messages
L["Gear Error 1"] = "Type "
L["Gear Error 2"] = " is not supported."

L["Echo Toggle"] = "Enable Echo"
L["Echo Toggle Desc"] = "Enable automatic guild message echoing"

L["Grats Toggle"] = "Enable Auto Grats"
L["Grats Toggle Desc"] = "Enable automatic contratulations message for guild achievements"
