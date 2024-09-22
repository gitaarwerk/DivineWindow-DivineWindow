-- To add more windows to the menu, set the items in the following files;

-- ConfigurationScreen\WindowDropdown.lua
-- Support\AvailableWindows.lua
-- Support\ClassesAndSpecialisations.lua (when adding one for a specialisastion)
-- Locales\[language].lua  check "AvailableWindows" part.
-- Add the right files in order of the table strings: { \[directory]\, \[file\] }, including the Index.xml, and Index.lua


DivineWindow.Support.AvailableWindows = {
    Classes = {
        Paladin = {
            -- Protection = { "Paladin", "Protection" },
            Retribution = { "Paladin", "Retribution" },
            Holy = { "Paladin", "Holy" },
        },
        Priest = {
            Holy = { "Priest", "Holy" },
        },
    },
    Alliance = {
        Jaina = { "Alliance", "Jaina" },
    },
    Horde = {
        Sylvanas = { "Horde", "Sylvanas" },
    },
    Neutral = {
        Kitty = { "Neutral", "Kitty" },
    },
    Enemies = {
        TheLichKing = { "Enemies", "TheLichKing" },
        CThun = { "Enemies", "CThun" },
    }
}
