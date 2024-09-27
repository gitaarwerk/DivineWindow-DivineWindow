DivineWindow.ConfigurationScreen.frame = nil;
DivineWindow.ConfigurationScreen.isOpen = false;
DivineWindow.ConfigurationScreen.activeTab = 1;
DivineWindow.ConfigurationScreen.activeSpecialisationName = nil
DivineWindow.ConfigurationScreen.isMoving = false

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
        _G[DivineWindow.ConfigurationScreen.FrameNames.INFO_SCREEN_BACKGROUND]:Hide();
        _G[DivineWindow.ConfigurationScreen.FrameNames.INFO_SCREEN_INPUT_NAME]:Hide();
        _G[DivineWindow.ConfigurationScreen.FrameNames.INFO_SCREEN_INPUT_BUTTON_NAME]:Hide();
        _G[DivineWindow.ConfigurationScreen.FrameNames.INFO_SCREEN_TEXT_TITLE_NAME]:Hide();
        _G[DivineWindow.ConfigurationScreen.FrameNames.INFO_SCREEN_TEXT_LEFT_NAME]:Hide();
        _G[DivineWindow.ConfigurationScreen.FrameNames.INFO_SCREEN_TEXT_RIGHT_NAME]:Hide();
    elseif (tabIndex == DivineWindow.numberOfSpecialisations + 1) then
        _G[DivineWindow.ConfigurationScreen.FrameNames.CONFIG_SCREEN]:Hide();
        _G[DivineWindow.ConfigurationScreen.FrameNames.INFO_SCREEN]:Show();
        _G[DivineWindow.ConfigurationScreen.FrameNames.CONFIG_SCREEN_TITLE]:SetText(currLanguage.InfoTab.title);

        _G[DivineWindow.ConfigurationScreen.FrameNames.INFO_SCREEN_BACKGROUND]:Show();
        _G[DivineWindow.ConfigurationScreen.FrameNames.INFO_SCREEN_INPUT_NAME]:Show();
        _G[DivineWindow.ConfigurationScreen.FrameNames.INFO_SCREEN_INPUT_BUTTON_NAME]:Show();
        _G[DivineWindow.ConfigurationScreen.FrameNames.INFO_SCREEN_TEXT_TITLE_NAME]:Show();
        _G[DivineWindow.ConfigurationScreen.FrameNames.INFO_SCREEN_TEXT_LEFT_NAME]:Show();
        _G[DivineWindow.ConfigurationScreen.FrameNames.INFO_SCREEN_TEXT_RIGHT_NAME]:Show();
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
    _G[DivineWindow.ConfigurationScreen.FrameNames.INTERFACE_BACKGROUND_MOVE_BUTTON]:SetText(currLanguage
        .GeneralTab
        .moveButton_on);
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

local function initializeAboutPage()
    local playerName = UnitName("player");
    local toReplace = {
        playerName = playerName
    }
    local infoScreen = _G[DivineWindow.ConfigurationScreen.FrameNames.INFO_SCREEN];
    local textLeft = infoScreen:CreateFontString(DivineWindow.ConfigurationScreen.FrameNames.INFO_SCREEN_TEXT_LEFT_NAME,
        "ARTWORK", "QuestFontNormalSmall")
    local textStringLeft = DivineWindow.Utilities.parseText(
        DivineWindow.Locales[DivineWindow.language].InfoTab.textLeft,
        toReplace);
    textLeft:SetText(textStringLeft)
    textLeft:SetWidth(300)
    textLeft:SetHeight(600)

    local textRight = infoScreen:CreateFontString(
        DivineWindow.ConfigurationScreen.FrameNames.INFO_SCREEN_TEXT_RIGHT_NAME, "ARTWORK", "QuestFontNormalSmall")
    local textStringRight = DivineWindow.Utilities.parseText(
        DivineWindow.Locales[DivineWindow.language].InfoTab.textRight,
        toReplace);

    textRight:SetText(textStringRight)
    textRight:SetWidth(300)
    textRight:SetHeight(600)


    local title = infoScreen:CreateFontString(DivineWindow.ConfigurationScreen.FrameNames.INFO_SCREEN_TEXT_TITLE_NAME,
        "ARTWORK", "GameFontNormal")
    local titleString = DivineWindow.Utilities.parseText(
        DivineWindow.Locales[DivineWindow.language].InfoTab.textTitle,
        toReplace);
    title:SetText(titleString)
    title:SetFont("Interface\\AddOns\\DivineWindow\\Src\\Assets\\BeyondWonderland.ttf", 24, "THICK")
    title:SetWidth(300)
    title:SetHeight(200)


    title:SetPoint("TOPLEFT", infoScreen, "TOPLEFT", 40, -165);
    textLeft:SetPoint("TOPLEFT", infoScreen, "TOPLEFT", 45, -200);
    textRight:SetPoint("TOPLEFT", infoScreen, "TOPLEFT", 400, -50);

    local fontFile, _, fontFlags = textRight:GetFont();

    title:SetJustifyH("LEFT")
    textRight:SetJustifyH("LEFT")
    textLeft:SetJustifyH("LEFT")
    title:SetJustifyV("TOP")
    textRight:SetJustifyV("TOP")
    textLeft:SetJustifyV("TOP")


    textRight:SetTextColor(0.22, 0.13, 0.07, 0.8)
    textLeft:SetTextColor(0.22, 0.13, 0.07, 0.8)
    title:SetTextColor(0, 0, 0, 0.8)

    title:SetShadowColor(0.4, 0.24, 0.13, 0.3)
    textLeft:SetShadowColor(0.4, 0.24, 0.13, 0.3)
    textRight:SetShadowColor(0.4, 0.24, 0.13, 0.333)

    textLeft:SetShadowOffset(2, -2)
    textRight:SetShadowOffset(2, -2)
    title:SetShadowOffset(2, -2)

    textLeft:SetFont(fontFile, 11, fontFlags);
    textRight:SetFont(fontFile, 11, fontFlags);


    DivineWindow.ConfigurationScreen.InitInput();
end

function DivineWindow.ConfigurationScreen.eventHandler(_, event, addonName, ...)
    if (event == "ADDON_LOADED" and addonName == "DivineWindow") then
        DivineWindow.ConfigurationScreen.frame = _G["DivineWindow_ConfigurationScreen"];

        setInitialTranslations();
        initializeGenericSettings();
        initializeAboutPage();
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
