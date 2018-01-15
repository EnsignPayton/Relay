local L = LibStub("AceLocale-3.0"):NewLocale("Relay", "enUS", true)

if not L then return end

-- Command Descriptions
L["Echo Desc"] = "Relay a message through guild members"
L["Time Desc"] = "Get guild member play time"
L["Exp Desc"] = "Get guild member level and experience"
L["Rep Desc"] = "Get guild member reputation with a faction"
L["Achiev Desc"] = "Get guild member achievement points (use 'points') or achievement status (use an achievement ID)"
L["Gear Desc"] = "Get guild member GearScore (use 'GS') or average item level (use 'IL')"
L["Config Desc"] = "Open configuration panel"
L["Help Desc"] = "Show command list"

-- Command Confirmations
L["Echo Conf"] = "Echo message \"%s\" sent."
L["Time Conf"] = "Queried guild for play time."
L["Exp Conf"] = "Queried guild for experience."
L["Rep Conf"] = "Queried guild for reputation."
L["Achiev Conf"] = "Queried guild for achievement info."
L["Gear Conf"] = "Queried guild for gear info."

-- Command Error Messages
L["Gear Error"] = "Type %s is not supported."

-- Options Strings
L["Echo"] = true
L["Auto Grats"] = true
L["Grats Desc"] = "Automatic congratulation messaging"
L["Play Time"] = true
L["Experience"] = true
L["Reputation"] = true
L["Achievement Points"] = true
L["Achievement Status"] = true
L["GearScore"] = true
