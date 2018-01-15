local L = LibStub("AceLocale-3.0"):NewLocale("Relay", "enUS", true)

if not L then return end

-- General
L["Config Desc"] = "Open configuration panel"
L["Help Desc"] = "Show command list"

-- Echo
L["Echo"] = true
L["Echo Desc"] = "Relay a message through guild members"
L["Echo Conf"] = "Echo message \"%s\" sent."

-- Auto Grats
L["Auto Grats"] = true
L["Grats Desc"] = "Automatic congratulation messaging"

-- Play Time
L["Play Time"] = true
L["Time Desc"] = "Get guild member play time"
L["Time Conf"] = "Queried guild for play time."

-- Experience
L["Experience"] = true
L["Exp Desc"] = "Get guild member level and experience"
L["Exp Conf"] = "Queried guild for experience."
L["Exp Return 80"] = "%s: Level %s"
L["Exp Return"] = "%s: Level %s (%s / %s)"

-- Reputation
L["Reputation"] = true
L["Rep Desc"] = "Get guild member reputation with a faction"
L["Rep Conf"] = "Queried guild for reputation."
L["Rep Return"] = "%s: Faction %s (%s / %s %s)"
L["Exalted"] = true
L["Revered"] = true
L["Honored"] = true
L["Friendly"] = true
L["Neutral"] = true
L["Unfriendly"] = true
L["Hostile"] = true
L["Hated"] = true

-- Achievements
L["Achievement Points"] = true
L["Achievement Status"] = true
L["Achiev Desc"] = "Get guild member achievement points (use 'points') or achievement status (use an achievement ID)"
L["Achiev Conf"] = "Queried guild for achievement info."
L["Achiev Points Return"] = "%s: %s Achievement Points"
L["Achiev Status Return"] = "%s: Achievement %s %s"
L["Complete"] = true
L["Incomplete"] = true

-- Gear
L["GearScore"] = true
L["Gear Desc"] = "Get guild member GearScore (use 'GS') or average item level (use 'IL')"
L["Gear Conf"] = "Queried guild for gear info."
L["Gear Error"] = "Type %s is not supported."
