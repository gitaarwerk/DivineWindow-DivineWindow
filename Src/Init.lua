DivineWindow = DivineWindow or {};

DivineWindow.debugMode = false;              -- Debug mode
DivineWindow.specialisation = nil;           -- Player's current specialisation
DivineWindow.supportedSpecialisations = nil; -- Player's current specialisation
DivineWindow.language = "English";           -- Player's preferred language

local function updateDivineWindowType()
    if (C_SpecializationInfo.IsInitialized()) then
        local activeSpecialisationId                  = GetSpecialization()
        local numSpecializations                      = GetNumSpecializations();
        local _, activeSpecialisationName, _, _, _, _ = GetSpecializationInfo(activeSpecialisationId)
        local _, _, playerClass, _, _                 = DivineWindow.Utilities.getPlayerInformation();

        DivineWindow.specialisation                   = activeSpecialisationName;
        DivineWindow.numberOfSpecialisations          = numSpecializations;
        DivineWindow.supportedSpecialisations         = DivineWindow.Support.ClassesAndSpecialisations[playerClass];
    end
end

-- Sets up the saved variables
local function setupInitialSavedVariables()
    DivineWindow.Utilities.debugPrint("setupInitialSavedVariables");

    if DivineWindow.Utilities.tableIsEmpty(DivineWindowGlobalVars) then
        DivineWindowGlobalVars = {};
        DivineWindowGlobalVars.debugMode = false
        DivineWindowGlobalVars.unlockTable = {};
    end

    if DivineWindow.Utilities.tableIsEmpty(DivineWindowLocalVars) then
        DivineWindowLocalVars = {};
        
        -- positioning
        DivineWindowLocalVars.position = {};
        DivineWindowLocalVars.position[1] = "CENTER";
        DivineWindowLocalVars.position[2] = "UIParent";
        DivineWindowLocalVars.position[3] = "CENTER";
        DivineWindowLocalVars.position[4] = 0;
        DivineWindowLocalVars.position[5] = 0;

        DivineWindowLocalVars.active = true;
        DivineWindowLocalVars.position = {};
        DivineWindowLocalVars.specialisation = {};
        DivineWindowLocalVars.scale = 0.37;
        DivineWindowLocalVars.inComabtAlpha = 1.0;
        DivineWindowLocalVars.outOfCombatAlpha = 1.0;
        DivineWindowLocalVars.windowBackgroundAlpha = 0.3;
        DivineWindowLocalVars.windowGlassShading = 0.5;
        DivineWindowLocalVars.windowGlassGrain = 0.3;
        DivineWindowLocalVars.windowColorAlpha = 0.8;
    end

    DivineWindow.debugMode = DivineWindowGlobalVars.debugMode;
    DivineWindow.Utilities.debugPrint("setupInitialSavedVariables now set");
end

local function warnIfNoWindowIsInstalled()
    if (DivineWindow.Utilities.tableIsEmpty(DivineWindow.ConfigurationScreen.AvailableWindows)) then
        DivineWindow.Utilities.printToUser("DivineWindow: No windows are installed. Please install a window to use the addon.");
    end
end

local function eventHandler(self, event, arg1)
    if (event == "ADDON_LOADED" and arg1 == "DivineWindow") then
        DivineWindow.Locales.setLanguage(GetLocale());
        setupInitialSavedVariables();
    end

    if (DivineWindow.Constants and event == "PLAYER_TALENT_UPDATE") then
        updateDivineWindowType();
        warnIfNoWindowIsInstalled();
    end
end

local function registerEvents()
    local frame = CreateFrame("FRAME", "DivineWindow_Init");
    frame:RegisterEvent("ADDON_LOADED");
    frame:RegisterEvent("PLAYER_TALENT_UPDATE");
    frame:RegisterEvent("PLAYER_ENTERING_WORLD");

    return frame;
end

local function init()
    DivineWindow.frame = registerEvents();
    DivineWindow.frame:SetScript("OnEvent", eventHandler);
end

-- Manual debug print before utilites are loaded.
if (DivineWindow.debugMode) then
    print("[DW loaded file]: init.lua");
end

init();
