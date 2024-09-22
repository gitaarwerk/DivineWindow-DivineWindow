DivineWindow.Support.ClassesAndSpecialisations = {
    GENERIC = {
        "Generic"
    }
}

DivineWindow.Support.PowerType = {
    PALADIN = {},
    PRIEST = {},
    WARRIOR = {},
    HUNTER = {},
    DRUID = {},
    ROGUE = {},
    MAGE = {},
    WARLOCK = {},
    SHAMAN = {},
    MONK = {},
    DEATH_KNIGHT = {},
    DEMON_HUNTER = {},
    EVOKER = {}
}

-- Paladin
table.insert(DivineWindow.Support.PowerType.PALADIN, DivineWindow.Constants.PowerTypes.HEALTH);
table.insert(DivineWindow.Support.PowerType.PALADIN, DivineWindow.Constants.PowerTypes.MANA);
table.insert(DivineWindow.Support.PowerType.PALADIN, DivineWindow.Constants.PowerTypes.HOLY_POWER);

-- Priest
table.insert(DivineWindow.Support.PowerType.PRIEST, DivineWindow.Constants.PowerTypes.HEALTH);
table.insert(DivineWindow.Support.PowerType.PRIEST, DivineWindow.Constants.PowerTypes.MANA);
table.insert(DivineWindow.Support.PowerType.PRIEST, DivineWindow.Constants.PowerTypes.INSANITY);

-- Warrior
table.insert(DivineWindow.Support.PowerType.WARRIOR, DivineWindow.Constants.PowerTypes.HEALTH);
table.insert(DivineWindow.Support.PowerType.WARRIOR, DivineWindow.Constants.PowerTypes.RAGE);

-- Hunter
table.insert(DivineWindow.Support.PowerType.HUNTER, DivineWindow.Constants.PowerTypes.HEALTH);
table.insert(DivineWindow.Support.PowerType.HUNTER, DivineWindow.Constants.PowerTypes.FOCUS);

-- Druid
table.insert(DivineWindow.Support.PowerType.DRUID, DivineWindow.Constants.PowerTypes.HEALTH);
table.insert(DivineWindow.Support.PowerType.DRUID, DivineWindow.Constants.PowerTypes.MANA);
table.insert(DivineWindow.Support.PowerType.DRUID, DivineWindow.Constants.PowerTypes.ENERGY);
table.insert(DivineWindow.Support.PowerType.DRUID, DivineWindow.Constants.PowerTypes.RAGE);
table.insert(DivineWindow.Support.PowerType.DRUID, DivineWindow.Constants.PowerTypes.LUNAR_POWER);

-- Rogue
table.insert(DivineWindow.Support.PowerType.ROGUE, DivineWindow.Constants.PowerTypes.HEALTH);
table.insert(DivineWindow.Support.PowerType.ROGUE, DivineWindow.Constants.PowerTypes.ENERGY);
table.insert(DivineWindow.Support.PowerType.ROGUE, DivineWindow.Constants.PowerTypes.COMBO_POINTS);

-- Mage
table.insert(DivineWindow.Support.PowerType.MAGE, DivineWindow.Constants.PowerTypes.HEALTH);
table.insert(DivineWindow.Support.PowerType.MAGE, DivineWindow.Constants.PowerTypes.MANA);
table.insert(DivineWindow.Support.PowerType.MAGE, DivineWindow.Constants.PowerTypes.ARCANE_CHARGES);

-- Warlock
table.insert(DivineWindow.Support.PowerType.WARLOCK, DivineWindow.Constants.PowerTypes.HEALTH);
table.insert(DivineWindow.Support.PowerType.WARLOCK, DivineWindow.Constants.PowerTypes.MANA);
table.insert(DivineWindow.Support.PowerType.WARLOCK, DivineWindow.Constants.PowerTypes.SOUL_SHARDS);

-- Shaman
table.insert(DivineWindow.Support.PowerType.SHAMAN, DivineWindow.Constants.PowerTypes.HEALTH);
table.insert(DivineWindow.Support.PowerType.SHAMAN, DivineWindow.Constants.PowerTypes.MANA);
table.insert(DivineWindow.Support.PowerType.SHAMAN, DivineWindow.Constants.PowerTypes.MAELSTROM);

-- Monk
table.insert(DivineWindow.Support.PowerType.MONK, DivineWindow.Constants.PowerTypes.HEALTH);
table.insert(DivineWindow.Support.PowerType.MONK, DivineWindow.Constants.PowerTypes.MANA);
table.insert(DivineWindow.Support.PowerType.MONK, DivineWindow.Constants.PowerTypes.ENERGY);
table.insert(DivineWindow.Support.PowerType.MONK, DivineWindow.Constants.PowerTypes.CHI);

-- Death Knight
table.insert(DivineWindow.Support.PowerType.DEATH_KNIGHT, DivineWindow.Constants.PowerTypes.HEALTH);
table.insert(DivineWindow.Support.PowerType.DEATH_KNIGHT, DivineWindow.Constants.PowerTypes.RUNES);
table.insert(DivineWindow.Support.PowerType.DEATH_KNIGHT, DivineWindow.Constants.PowerTypes.RUNIC_POWER);

-- Demon Hunter
table.insert(DivineWindow.Support.PowerType.DEMON_HUNTER, DivineWindow.Constants.PowerTypes.HEALTH);
table.insert(DivineWindow.Support.PowerType.DEMON_HUNTER, DivineWindow.Constants.PowerTypes.PAIN);
table.insert(DivineWindow.Support.PowerType.DEMON_HUNTER, DivineWindow.Constants.PowerTypes.FURY);

-- Evoker
table.insert(DivineWindow.Support.PowerType.EVOKER, DivineWindow.Constants.PowerTypes.HEALTH);
table.insert(DivineWindow.Support.PowerType.EVOKER, DivineWindow.Constants.PowerTypes.MANA);
table.insert(DivineWindow.Support.PowerType.EVOKER, DivineWindow.Constants.PowerTypes.ESSENCE);

-- Manual debug print before utilites are loaded.
if (DivineWindow.debugMode) then
    print("[DW loaded file]: Src/Support/ClassesAndSpecialisations.lua");
end
