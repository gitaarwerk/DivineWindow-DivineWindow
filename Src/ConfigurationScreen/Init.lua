DivineWindow.ConfigurationScreen.frame = nil;
DivineWindow.ConfigurationScreen.isOpen = false;
DivineWindow.ConfigurationScreen.activeTab = 1;
DivineWindow.ConfigurationScreen.activeSpecialisationName = nil

function DivineWindow.ConfigurationScreen.userHasSpecialisationSetUp()
    local specialisationExists = not DivineWindow.Utilities.tableIsEmpty(DivineWindowLocalVars.specialisation);
    return specialisationExists and
        not DivineWindow.Utilities.tableIsEmpty(DivineWindowLocalVars.specialisation[DivineWindow.specialisation]);
end

function DivineWindow.ConfigurationScreen.prefillTalents()
    local numberOfSpecialisations = DivineWindow.numberOfSpecialisations;
    local className = select(2, UnitClass("player"));
    for i = 1, numberOfSpecialisations do
        local _, specialisation, _, _, _, _ = GetSpecializationInfo(i);

        if (DivineWindow.Utilities.tableContainsValue(DivineWindow.supportedSpecialisations, specialisation)) then
            local defaultSettings = DivineWindow.Windows[className].DefaultSettings[specialisation];
            DivineWindowLocalVars.specialisation[specialisation] = defaultSettings;
        else
            local defaultSettings = {
                isSetUp = true,
                chosenWindow = { "Paladin", "Holy" },
                powerBar = {
                    left = DivineWindow.Constants.PowerTypes.HEALTH,
                    right = DivineWindow.Constants.PowerTypes.HEALTH,
                },
                powerBarColor = {
                    left = DivineWindow.Constants.PowerTypeColors.RED,
                    right = DivineWindow.Constants.PowerTypeColors.LIGHT_ORANGE,
                },
                spells = {
                    {
                        name = "Devotion Aura",
                        countType = "COOLDOWN_TIMER",
                        windowPart = "PART_1",
                        animationType = "REGRESSIVE",
                    },
                }
            }

            DivineWindowLocalVars.specialisation[specialisation] = defaultSettings;
            DevTools_Dump(DivineWindowLocalVars)
        end
    end
end

function DivineWindow.ConfigurationScreen.show()
    DivineWindow.ConfigurationScreen.frame:Show();
    DivineWindow.ConfigurationScreen.isOpen = true;
end

function DivineWindow.ConfigurationScreen.hide()
    DivineWindow.ConfigurationScreen.frame:Hide();
    DivineWindow.ConfigurationScreen.isOpen = false;
    DivineWindow.ConfigurationScreen.activeSpecialisationName = nil;
end

function DivineWindow.ConfigurationScreen.openConfigTab(tabIndex)
    local currLanguage = DivineWindow.Locales[DivineWindow.language];
    for i = 1, DivineWindow.numberOfSpecialisations do
        local frameName = DivineWindow.ConfigurationScreen.FrameNames.SPECIALISATION_SCREEN_NAME .. tostring(i);
        local frame = _G[frameName];
        if (i == tabIndex) then
            frame:Show();
        else
            frame:Hide();
        end
    end

    DivineWindow.ConfigurationScreen.activeTab = tabIndex;
    if (tabIndex == 0) then
        _G[DivineWindow.ConfigurationScreen.FrameNames.CONFIG_SCREEN]:Show();
        _G[DivineWindow.ConfigurationScreen.FrameNames.CONFIG_SCREEN_TITLE]:SetText(currLanguage.GeneralTab
            .title);
    elseif (tabIndex == DivineWindow.numberOfSpecialisations + 1) then
        _G[DivineWindow.ConfigurationScreen.FrameNames.CONFIG_SCREEN]:Hide();
        _G[DivineWindow.ConfigurationScreen.FrameNames.INFO_SCREEN]:Show();
        _G[DivineWindow.ConfigurationScreen.FrameNames.CONFIG_SCREEN_TITLE]:SetText(currLanguage.InfoTab.title);
    else
        local _, specialisation = GetSpecializationInfo(tabIndex)
        _G[DivineWindow.ConfigurationScreen.FrameNames.INFO_SCREEN]:Hide();
        _G[DivineWindow.ConfigurationScreen.FrameNames.CONFIG_SCREEN]:Hide();
        _G[DivineWindow.ConfigurationScreen.FrameNames.CONFIG_SCREEN_TITLE]:SetText(specialisation);
    end
end

function DivineWindow.ConfigurationScreen.setActiveTab(tabIndex, tabName)
    return function()
        DivineWindow.ConfigurationScreen.openConfigTab(tabIndex)
        DivineWindow.ConfigurationScreen.activeTab = tabIndex;
        DivineWindow.ConfigurationScreen.activeSpecialisationName = tabName;
    end
end

local function setInitialTranslations()
    -- set transations
    local currLanguage = DivineWindow.Locales[DivineWindow.language];

    -- general
    _G[DivineWindow.ConfigurationScreen.FrameNames.CONFIG_SCREEN_TITLE]:SetText(currLanguage.GeneralTab.title);
    _G[DivineWindow.ConfigurationScreen.FrameNames.GENERAL_TAB_NAME]:SetText(currLanguage.GeneralTab.tabTitle);

    -- sliders
    _G[DivineWindow.ConfigurationScreen.FrameNames.INTERFACE_IN_COMBAT_OPACITY_SLIDER_NAME_TEXT]:SetText(
        currLanguage
        .GeneralTab
        .inCombatAlpha);
    _G[DivineWindow.ConfigurationScreen.FrameNames.INTERFACE_OUT_OF_COMBAT_OPACITY_SLIDER_NAME_TEXT]:SetText(
        currLanguage
        .GeneralTab
        .outOfCombatCombatAlpha);
    _G[DivineWindow.ConfigurationScreen.FrameNames.INTERFACE_SCALE_SLIDER_NAME_TEXT]:SetText(currLanguage
        .GeneralTab
        .windowScale);
    _G[DivineWindow.ConfigurationScreen.FrameNames.INTERFACE_SHADING_SLIDER_NAME_TEXT]:SetText(currLanguage
        .GeneralTab
        .windowShading);
    _G[DivineWindow.ConfigurationScreen.FrameNames.INTERFACE_GRAININESS_SLIDER_NAME_TEXT]:SetText(currLanguage
        .GeneralTab
        .windowGrain);
    _G[DivineWindow.ConfigurationScreen.FrameNames.INTERFACE_COLOR_ALPHA_SLIDER_NAME_TEXT]:SetText(currLanguage
        .GeneralTab
        .windowColor);
    _G[DivineWindow.ConfigurationScreen.FrameNames.INTERFACE_BACKGROUND_ALPHA_SLIDER_NAME_TEXT]:SetText(currLanguage
        .GeneralTab
        .windowBackground);
end

local function initializeGenericSettings()
    -- set general settings
    _G[DivineWindow.ConfigurationScreen.FrameNames.INTERFACE_IN_COMBAT_OPACITY_SLIDER_NAME]:SetValue(
        DivineWindowLocalVars.inComabtAlpha);
    _G[DivineWindow.ConfigurationScreen.FrameNames.INTERFACE_OUT_OF_COMBAT_OPACITY_SLIDER_NAME]:SetValue(
        DivineWindowLocalVars.outOfCombatAlpha);
    _G[DivineWindow.ConfigurationScreen.FrameNames.INTERFACE_SCALE_SLIDER_NAME]:SetValue(DivineWindowLocalVars
        .scale);
    _G[DivineWindow.ConfigurationScreen.FrameNames.INTERFACE_SHADING_SLIDER_NAME]:SetValue(DivineWindowLocalVars
        .windowGlassShading);
    _G[DivineWindow.ConfigurationScreen.FrameNames.INTERFACE_GRAININESS_SLIDER_NAME]:SetValue(DivineWindowLocalVars
        .windowGlassGrain);
    _G[DivineWindow.ConfigurationScreen.FrameNames.INTERFACE_COLOR_ALPHA_SLIDER_NAME]:SetValue(DivineWindowLocalVars
        .windowColorAlpha);
    _G[DivineWindow.ConfigurationScreen.FrameNames.INTERFACE_BACKGROUND_ALPHA_SLIDER_NAME]:SetValue(
        DivineWindowLocalVars
        .windowBackgroundAlpha);
end


function DivineWindow.ConfigurationScreen.eventHandler(_, event, addonName, ...)
    if (event == "ADDON_LOADED" and addonName == "DivineWindow") then
        DivineWindow.ConfigurationScreen.frame = _G["DivineWindow_ConfigurationScreen"];

        setInitialTranslations();
        initializeGenericSettings();
    end

    if (event == "PLAYER_TALENT_UPDATE") then
        if (C_SpecializationInfo.IsInitialized()) then
            local showConfigurationScreen = false;
            local hasSetup = DivineWindow.ConfigurationScreen.userHasSpecialisationSetUp();
            if (hasSetup == false) then
                DivineWindow.ConfigurationScreen.prefillTalents();
                showConfigurationScreen = true;
                hasSetup = true;
            end

            DivineWindow.ConfigurationScreen.generateScreensForAllSpecialisations();

            if (DivineWindow.ConfigurationScreen.frame and hasSetup and showConfigurationScreen) then
                DivineWindow.ConfigurationScreen.show();
                DivineWindow.Interface.show();
            end
        end
    end
end

DivineWindow.Utilities.debugPrint("Src/ConfigurationScreen/Init.lua", "file")
