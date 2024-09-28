DivineWindow.Locales.English = DivineWindow.Locales.English or {}

DivineWindow.Locales.English.addonName = "Divine Window";

-- These translations are shown inside of the specialisation windows of the configuration menu
-- General
DivineWindow.Locales.English.GeneralTab = {
    title                  = DivineWindow.Locales.English.addonName .. ": " .. "General",
    tabTitle               = "General",
    windowScale            = "Scale",
    inCombatAlpha          = "Opacity when in combat",
    outOfCombatCombatAlpha = "Opacity when out of combat",
    windowShading          = "Shading",
    windowGrain            = "Glass graininess",
    windowColor            = "Colored glass opacity",
    windowBackground       = "Background opacity",
    moveButton_off         = "Lock window position",
    moveButton_on          = "Move window",
}

DivineWindow.Locales.English.InfoTab = {
    title     = DivineWindow.Locales.English.addonName .. ": " .. "Info/About",
    tabTitle  = "About",
    okText    = "OK",
    textLeft  = [[
Thank you for using Divine Window. Did you know Divine Window is a labor of love? You may be using it right now, and miss more than a few windows to use. Well, don't be alarmed, there's a lot more to come!

Make sure to update regularly, and check regularly for updates on https://www.curseforge.com/wow/addons/divine-window.

Please support me by sharing your feedback, ${playerName}. And if you like the add-on, consider a small donating on Ko-Fi: https://ko-fi.com/darkrideraddons

And before I forget, don't forget to check-out my other plugins:
- Express Your Elf: A set of buttons that lets you interact with other people using contextual random phrase, fun or awkwardness guaranteed)

- Nurse Nancy: Announce ressurections in a funny way.

- AFK Answering Machine: When you go AFK, this answering machine will notify the other person that you are not available with tons of random messages.

- iTaunted: A small add-on that announce when you taunted.

Check them all out at: https://www.curseforge.com/members/darkrider/projects

Yours truly,
Darkrider.
]],
    textRight = [[
Help, I can’t find/select any windows

If you installed Divine Window, you may not have installed any mandatory additions to the add-on. Due to the file size of each window, they are split up in various packages.

Check them all out at: https://www.curseforge.com/members/darkrider/projects


How does this add-on work?

Divine Window tries to make things as easy as possible for you. However, with all unique interfaces, there may be a little bit of a learning curve.

You can find most common questions and issues on this page:
https://github.com/gitaarwerk/divine-window/wiki


Can’t find your favourite window?

Divine Window takes a lot of time to make. Each window takes about a week to make from begin to end. This means that this add-on will grow over time.


A couple of important things:

- If you uninstall the additional windows, make sure they are not used anymore.

- If you accidentally deleted them, and not want to reinstall, an error may appear. In that case, just open the configuration window and select another window.

]],
    textTitle = "Dear ${playerName},",
}

-- Specialisations
DivineWindow.Locales.English.Labels = {
    window = "Selected Divine Window",
    leftPowerBar = "Left Power Bar",
    rightPowerBar = "Right Power Bar",
    preview = "View",
    spellName = "Buff/Debuff or Spell [name or id]",
    timer = "Type of timer",
    windowPart = "Stained glass assignment",
    delete = "Delete",
    addRow = "Add row",
}

-- Power bar types
DivineWindow.Locales.English.PowerTypeTitle = {
    left = "Select left power bar",
    right = "Select right power bar"
}

-- Power types colors
DivineWindow.Locales.English.PowerTypeColorTitle = {
    left = "Select left bar color",
    right = "Select right bar color"
}

-- Reflection of DivineWindow.Constants.PowerTypes;
-- shown in the dropdown for the two 'power bars'
DivineWindow.Locales.English.PowerType = {
    Health = "Health", -- not an official power type
    Mana = "Mana",
    Rage = "Rage",
    Focus = "Focus",
    Energy = "Energy",
    ComboPoints = "Combo Points",
    Runes = "Runes",
    RunicPower = "Runic Power",
    SoulShards = "Soul Shards",
    LunarPower = "Lunar Power",
    HolyPower = "Holy Power",
    Alternate = "Alternate",
    Maelstrom = "Maelstrom",
    Chi = "Chi",
    Insanity = "Insanity",
    Obsolete = "Obsolete",
    Obsolete2 = "Obsolete2",
    ArcaneCharges = "Arcane Charges",
    Fury = "Fury",
    Pain = "Pain",
    Essence = "Essence",
    RuneBlood = "Rune Blood",
    RuneFrost = "Rune Frost",
    RuneUnholy = "Rune Unholy",
    AlternateQuest = "Alternate Quest",
    AlternateEncounter = "Alternate Encounter",
    AlternateMount = "Alternate Mount",
    NumPowerTypes = "Number of Power Types",
}

-- Count types
DivineWindow.Locales.English.CountTypeTitle = {
    tooltipTitle = "Select a count type"
}

DivineWindow.Locales.English.CountType = {
    BUFF_DEBUFF_EXPIRATION_TIME = "(De)Buff expiration time",
    BUFF_DEBUFF_STACKS = "(De)Buff stacks",
    COOLDOWN_TIMER = "Cooldown timer",
    COOLDOWN_STACKS = "Cooldown stacks",
    ON_OFF = "On/Off",
}

DivineWindow.Locales.English.AnimationType = {
    REGRESSIVE = "Regressive",
    PROGRESSIVE = "Progressive",
    FADE_OUT = "Fade out",
    FADE_IN = "Fade in",
    FADE_PULSE = "Pulse fade-in-out (on/off)",
};

-- Window parts
DivineWindow.Locales.English.WindowDetailTitle = {
    tooltipTitle = "Select a part of the window",
    unavailable = "(unavailable)"
}

DivineWindow.Locales.English.WindowDetailExplanation = {
    GRAIN = "Controls the level of grainyness of the stained glass",
    SHADES = "Controls how much shades you want to see",
    INACTIVE_OPACITY = "Controls the level of the glass' natural tint When the glass parts are inactive",
    ACTIVE_OPACITY = "Controls the level of the opacity of the active glass parts",
}

DivineWindow.Locales.English.WindowDetail = {
    GRAIN = "Window grainyness",
    SHADES = "Window shading",
    INACTIVE_OPACITY = "Opacity of inactive glass",
    ACTIVE_OPACITY = "Opacity of active glass",
}

DivineWindow.Locales.English.PowerBarType = {
    LEFT_BAR = "Left bar",
    RIGHT_BAR = "Right bar",
}

DivineWindow.Locales.English.PowerTypeColor = {
    AeroBlue = "Aero Blue",
    Blue = "Blue",
    Cyan = "Cyan",
    Heliotrope = "Heliotrope",
    Khaki = "Khaki",
    LightOrange = "Light Orange",
    MintGreen = "Mint Green",
    Purple = "Purple",
    Red = "Red",
    RoyalBlue = "Royal Blue",
    Yellow = "Yellow",
}

-- Available windows
--- Empty by default. The locales of the available windows will be provided by the dependancies.
DivineWindow.Locales.English.AvailableWindows = {
    title = "Available Divine Windows",
    defaultText = "Select a Divine Window",
    noWindowsAvailable = "No windows available. Please install one of the Divine Window addOns",
}



-- Window parts are in the following structure:
-- DivineWindow.Locales.English.PALADIN = {
--     Retribution = {
--         WindowPart = {
--             PART_1 = "Grass (11)",
--             PART_2 = "Ashbringer (4)",
--             PART_3 = "Cloak (3)",
--             PART_4 = "Winged Building (19)",
--             PART_5 = "Sky (12)",
--             PART_6 = "Left Building (5)",
--             PART_7 = "Armor (11)",
--             PART_8 = "Head (5)",
--             PART_9 = "Gemmed Ornament (4)",
--             FX_1 = "Ashbringer's Fire (3)",
--             FX_2 = "Glowing Eyes (9)",
--         }
--     }
-- };
