local function addEditBox(parentFrame, name, text, specialisation, saveIndex)
    local editBox = CreateFrame("EditBox", name, parentFrame, "InputBoxTemplate")
    editBox:SetWidth(200)
    editBox:SetHeight(20)
    editBox:SetAutoFocus(false)
    editBox:SetText(text)
    editBox:SetMaxLetters(100)
    editBox:SetMultiLine(false)
    editBox:Show()
    editBox:SetScript("OnTextChanged", function(self)
        DivineWindowLocalVars.specialisation[specialisation].spells[saveIndex].name = self:GetText() or "";
    end)
    return editBox
end

local function windowPartMenuInfo_OnClick(specialisation)
    return function(self, parent, saveIndex)
        DivineWindowLocalVars.specialisation[specialisation].spells[saveIndex].windowPart =
            self.value;
        UIDropDownMenu_SetSelectedValue(parent, self.value);
    end
end


local function countTypeMenuInfo_OnClick(specialisation)
    return function(self, parent, saveIndex)
        DivineWindowLocalVars.specialisation[specialisation].spells[saveIndex].countType =
            self.value;
        UIDropDownMenu_SetSelectedValue(parent, self.value);
    end
end

local function powerBarMenuInfo_OnClick(specialisation)
    return function(self, parent, side)
        DivineWindowLocalVars.specialisation[specialisation].powerBar[side] =
            self
            .value;
        UIDropDownMenu_SetSelectedValue(parent, self.value);
    end
end

local function powerBarColorMenuInfo_OnClick(specialisation)
    return function(self, parent, side)
        DivineWindowLocalVars.specialisation[specialisation].powerBarColor[side] =
            self
            .value;
        UIDropDownMenu_SetSelectedValue(parent, self.value);
    end
end



local function powerBarMenuInfo(side, specialisation, initialValue)
    local playerClass = select(2, UnitClass("player"));
    return function(self)
        local info = UIDropDownMenu_CreateInfo()

        info.arg2 = side;
        info.tooltipTitle = DivineWindow.Locales[DivineWindow.language].PowerTypeTitle[side];

        info.text, info.menuList, info.isTitle =
            DivineWindow.Locales[DivineWindow.language].PowerTypeTitle[side],
            "POWER_BAR_" .. side, true;

        UIDropDownMenu_AddButton(info);

        for _, supportedPowerType in pairs(DivineWindow.Support.PowerType[playerClass]) do
            info                      = {}
            info.arg1                 = self;
            info.arg2                 = side;
            info.func                 = powerBarMenuInfo_OnClick(specialisation);
            local powerBarTranslation = DivineWindow.Locales[DivineWindow.language].PowerType[supportedPowerType]
            info.value, info.text     = supportedPowerType, powerBarTranslation or nil;
            UIDropDownMenu_AddButton(info);
        end
    end
end


local function powerBarColorMenuInfo(side, specialisation, initialValue)
    local playerClass = select(2, UnitClass("player"));
    return function(self)
        local info = UIDropDownMenu_CreateInfo()

        info.arg2 = side;
        info.tooltipTitle = DivineWindow.Locales[DivineWindow.language].PowerTypeColorTitle[side];

        info.text, info.menuList, info.isTitle =
            DivineWindow.Locales[DivineWindow.language].PowerTypeColorTitle[side],
            "POWER_BAR_" .. side, true;

        UIDropDownMenu_AddButton(info);

        for _, supportedPowerTypeColor in pairs(DivineWindow.Constants.PowerTypeColors) do
            info                           = {}
            info.arg1                      = self;
            info.arg2                      = side;
            info.func                      = powerBarColorMenuInfo_OnClick(specialisation);
            local powerBarColorTranslation = DivineWindow.Locales[DivineWindow.language].PowerTypeColor
                [supportedPowerTypeColor]
            info.value, info.text          = supportedPowerTypeColor, powerBarColorTranslation or nil;
            UIDropDownMenu_AddButton(info);
        end
    end
end

local function countTypeMenuInfo(saveToIndex, specialisation)
    return function(self)
        local info = UIDropDownMenu_CreateInfo()
        info.arg2 = saveToIndex;
        info.tooltipTitle = DivineWindow.Locales[DivineWindow.language].CountTypeTitle.tooltipTitle;

        info.text, info.menuList, info.isTitle = DivineWindow.Locales[DivineWindow.language].CountTypeTitle.tooltipTitle,
            "COUNT_TYPE_" .. saveToIndex, true;

        UIDropDownMenu_AddButton(info);

        for _, countType in pairs(DivineWindow.Constants.CountType) do
            info                       = {}
            info.arg1                  = self;
            info.arg2                  = saveToIndex;
            info.func                  = countTypeMenuInfo_OnClick(specialisation);
            local countTypeTranslation = DivineWindow.Locales[DivineWindow.language].CountType[countType]

            info.value, info.text      = countType, countTypeTranslation or nil;
            UIDropDownMenu_AddButton(info);
        end
    end
end

local function windowPartMenuInfo(saveToIndex, specialisation, chosenWindow)
    return function(self)
        local info = UIDropDownMenu_CreateInfo()
        wipe(info);
        info.arg2 = saveToIndex;
        info.tooltipTitle = DivineWindow.Locales[DivineWindow.language].WindowDetailTitle.tooltipTitle;

        info.text, info.menuList, info.isTitle =
            DivineWindow.Locales[DivineWindow.language].WindowDetailTitle.tooltipTitle,
            "WINDOW_PART" .. saveToIndex, true;

        UIDropDownMenu_AddButton(info);

        -- look over all constanst in DivineWindow.Constants.WindowParts
        for _, windowPart in pairs(DivineWindow.Constants.WindowPart) do
            info              = {}
            info.arg1         = self;
            info.arg2         = saveToIndex;
            info.func         = windowPartMenuInfo_OnClick(specialisation);

            local category    = chosenWindow[1];
            local window      = chosenWindow[2];

            local translation = DivineWindow.Locales[DivineWindow.language][category][window]
                .WindowPart[windowPart]

            if (translation == nil) then
                info.disabled = true;
            end

            local windowPartTranslation = translation or
                DivineWindow.Locales[DivineWindow.language].WindowDetailTitle.unavailable;

            info.value, info.text       = windowPart, windowPartTranslation or nil;
            UIDropDownMenu_AddButton(info);
        end
    end
end

local function createCountTypeDropDownBox(dropdownName, parentFrame, saveIndex, specialisation, initialValue)
    local dropDown = CreateFrame("Frame", dropdownName, parentFrame, "UIDropDownMenuTemplate")
    UIDropDownMenu_SetWidth(dropDown, 150) -- Use in place of dropDown:SetWidth
    UIDropDownMenu_Initialize(dropDown, countTypeMenuInfo(saveIndex, specialisation))
    UIDropDownMenu_SetSelectedValue(dropDown, initialValue);
    UIDropDownMenu_JustifyText(dropDown, "LEFT")

    return dropDown;
end


local function createWindowPartDropDownBox(dropdownName, parentFrame, saveIndex, specialisation, initialValue,
                                           chosenWindow)
    local dropDown = CreateFrame("Frame", dropdownName, parentFrame, "UIDropDownMenuTemplate")
    UIDropDownMenu_SetWidth(dropDown, 150) -- Use in place of dropDown:SetWidth
    UIDropDownMenu_Initialize(dropDown, windowPartMenuInfo(saveIndex, specialisation, chosenWindow))
    UIDropDownMenu_SetSelectedValue(dropDown, initialValue);
    UIDropDownMenu_JustifyText(dropDown, "LEFT")
    return dropDown;
end

local function createPowerBarDropDownBox(dropdownName, parentFrame, side, specialisation, initialValue)
    local dropDown = CreateFrame("Frame", dropdownName, parentFrame, "UIDropDownMenuTemplate")
    UIDropDownMenu_SetWidth(dropDown, 150) -- Use in place of dropDown:SetWidth
    UIDropDownMenu_Initialize(dropDown, powerBarMenuInfo(side, specialisation, initialValue))
    UIDropDownMenu_SetSelectedValue(dropDown, initialValue);
    UIDropDownMenu_JustifyText(dropDown, "LEFT")
    return dropDown;
end

local function createPowerBarColorDropDownBox(dropdownName, parentFrame, side, specialisation, initialValue)
    local dropDown = CreateFrame("Frame", dropdownName, parentFrame, "UIDropDownMenuTemplate")
    UIDropDownMenu_SetWidth(dropDown, 150) -- Use in place of dropDown:SetWidth
    UIDropDownMenu_Initialize(dropDown, powerBarColorMenuInfo(side, specialisation, initialValue))
    UIDropDownMenu_SetSelectedValue(dropDown, initialValue);
    UIDropDownMenu_JustifyText(dropDown, "LEFT")
    return dropDown;
end


local function resizeScrollFrame(items, specialisation, frameToSize)
    local frame = frameToSize or
        _G
        [DivineWindow.ConfigurationScreen.FrameNames.SPECIALISATION_SCREEN_SCROLL_NAME .. tostring(DivineWindow.ConfigurationScreen.activeTab)];

    -- set new scroll frame height
    frame:SetHeight(30 * items);
end

local function deleteRow(index, specialisation)
    table.remove(DivineWindowLocalVars.specialisation[specialisation].spells, index);
    -- hide children
    _G[DivineWindow.ConfigurationScreen.FrameNames.SPELL_SPELL_NAME_DROPDOWN_NAME .. specialisation .. "_" .. index]
        :SetHeight(0);
    _G[DivineWindow.ConfigurationScreen.FrameNames.SPELL_COUNTDOWN_TYPE_DROPDOWN_NAME .. specialisation .. "_" .. index]
        :SetHeight(0);
    _G[DivineWindow.ConfigurationScreen.FrameNames.SPELL_WINDOW_PART_DROPDOWN_NAME .. specialisation .. "_" .. index]
        :SetHeight(0);
    _G[DivineWindow.ConfigurationScreen.FrameNames.SPELL_DELETE_ROW .. specialisation .. '_' .. index]:SetHeight(0);

    local windowSpellConfiguration = DivineWindow.Utilities.getWindowConfiguration(specialisation);

    resizeScrollFrame(#windowSpellConfiguration.spells, specialisation);
end

local function preview(index, specialisation, spell, time)
    local timer = time;
    return function()
        DivineWindow.Interface.handleWindowFacet(
            spell.countType,
            DivineWindow.Constants.CountType.ON_OFF == spell.countType and timer > 0 or false,
            (DivineWindow.Constants.CountType.BUFF_DEBUFF_EXPIRATION_TIME == spell.countType or DivineWindow.Constants.CountType.COOLDOWN_TIMER == spell.countType) and
            time or 0,
            (DivineWindow.Constants.CountType.BUFF_DEBUFF_EXPIRATION_TIME == spell.countType or DivineWindow.Constants.CountType.COOLDOWN_TIMER == spell.countType) and
            timer or 0,
            (DivineWindow.Constants.CountType.BUFF_DEBUFF_STACKS == spell.countType or DivineWindow.Constants.CountType.COOLDOWN_STACKS == spell.countType) and
            time or 0,
            (DivineWindow.Constants.CountType.BUFF_DEBUFF_STACKS == spell.countType or DivineWindow.Constants.CountType.COOLDOWN_STACKS == spell.countType)
            and timer or 0,
            specialisation,
            spell.windowPart,
            timer > 0
        )
        timer = timer - 1;
    end
end



local function createPreviewButton(buttonName, parentFrame, index, specialisation)
    local previewButton = CreateFrame("Button", buttonName, parentFrame, "UIPanelButtonTemplate")
    previewButton:SetText("");
    previewButton:Show();
    previewButton:SetNormalTexture(3004126);
    previewButton:SetSize(20, 20)

    previewButton:SetScript("OnClick", function()
        local function nilFunc() end
        local previewTimer = C_Timer.NewTicker(0, nilFunc)
        local previewTime = 0.5; -- seconds
        local runningTime = 6

        local spell = DivineWindowLocalVars.specialisation[specialisation].spells[index]
        if (not (spell and spell.countType and spell.windowPart)) then
            previewTimer:Cancel()
            return;
        end

        C_Timer.NewTicker(previewTime, preview(index, specialisation, spell, runningTime - 1), runningTime)
        previewTimer:Cancel()
    end)

    return previewButton;
end

local function createDeleteButton(buttonName, parentFrame, index, specialisation)
    local deleteButton = CreateFrame("Button", buttonName, parentFrame, "UIPanelButtonTemplate")
    deleteButton:SetText("X");
    deleteButton:SetWidth(20)
    deleteButton:Show();
    deleteButton:SetScript("OnClick", function()
        deleteRow(index, specialisation)
    end)

    return deleteButton;
end

local function createText(textString, parentFrame)
    local text = parentFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    text:SetText(textString)
    text:SetWidth(200)
    text:SetHeight(20)
    text:Show()
    return text
end

local function addRow(self, specialisation, parentFrame, chosenWindow)
    local windowSpellConfiguration = DivineWindow.Utilities.getWindowConfiguration(specialisation); -- always request latest ones, not in memory
    if (windowSpellConfiguration and windowSpellConfiguration.isSetUp) then
        local numOfSpellsSaved = #windowSpellConfiguration.spells;
        local newId = numOfSpellsSaved + 1;

        -- insert empty data set
        table.insert(DivineWindowLocalVars.specialisation[specialisation].spells, {
            name = "",
            countType = nil,
            windowPart = nil
        });

        local spellBox = addEditBox(parentFrame,
            DivineWindow.ConfigurationScreen.FrameNames.SPELL_SPELL_NAME_DROPDOWN_NAME .. specialisation .. "_" .. newId,
            "nothing",
            specialisation,
            newId);
        local countTypeBox = createCountTypeDropDownBox(
            DivineWindow.ConfigurationScreen.FrameNames.SPELL_COUNTDOWN_TYPE_DROPDOWN_NAME ..
            specialisation .. "_" .. newId,
            parentFrame, newId, specialisation);
        local windowPartBox = createWindowPartDropDownBox(
            DivineWindow.ConfigurationScreen.FrameNames.SPELL_WINDOW_PART_DROPDOWN_NAME .. specialisation .. "_" .. newId,
            parentFrame, newId, specialisation, nil, chosenWindow);

        local deleteRowButton = createDeleteButton(
            DivineWindow.ConfigurationScreen.FrameNames.SPELL_DELETE_ROW .. specialisation .. '_' .. newId,
            parentFrame, newId,
            specialisation);

        spellBox:SetPoint("TOPLEFT", parentFrame, "TOP", 60, -40 * newId);
        countTypeBox:SetPoint("TOPLEFT", parentFrame, "TOP", 260, (-40 * newId) + 4);
        windowPartBox:SetPoint("TOPLEFT", parentFrame, "TOP", 445, (-40 * newId) + 4);
        deleteRowButton:SetPoint("TOPLEFT", parentFrame, "TOP", 640, -40 * newId);
        spellBox:SetFocus();
        resizeScrollFrame(#windowSpellConfiguration.spells, specialisation);
    end
end

function DivineWindow.ConfigurationScreen.generateEditBoxPerSpecialisation(specialisationFrameScrollBox, specialisation,
                                                                           chosenWindow)
    if (not specialisation or specialisation.isSetup == false) then
        return;
    end

    local windowSpellConfiguration = DivineWindow.Utilities.getWindowConfiguration(specialisation);
    if (windowSpellConfiguration and windowSpellConfiguration.isSetUp) then
        for index, spellConfiguration in ipairs(windowSpellConfiguration.spells) do
            local spellName = spellConfiguration.name;
            local countType = spellConfiguration.countType;
            local windowPart = spellConfiguration.windowPart;

            local spellBox = addEditBox(specialisationFrameScrollBox,
                DivineWindow.ConfigurationScreen.FrameNames.SPELL_SPELL_NAME_DROPDOWN_NAME ..
                specialisation .. "_" .. index,
                spellName, specialisation,
                index);
            local countTypeBox = createCountTypeDropDownBox(
                DivineWindow.ConfigurationScreen.FrameNames.SPELL_COUNTDOWN_TYPE_DROPDOWN_NAME ..
                specialisation .. "_" .. index,
                specialisationFrameScrollBox, index, specialisation, countType);
            local windowPartBox = createWindowPartDropDownBox(
                DivineWindow.ConfigurationScreen.FrameNames.SPELL_WINDOW_PART_DROPDOWN_NAME ..
                specialisation .. "_" .. index,
                specialisationFrameScrollBox, index, specialisation, windowPart, chosenWindow);
            local deleteRowButton = createDeleteButton(
                DivineWindow.ConfigurationScreen.FrameNames.SPELL_DELETE_ROW .. specialisation .. '_' .. index,
                specialisationFrameScrollBox, index,
                specialisation);
            local previewButton = createPreviewButton(
                DivineWindow.ConfigurationScreen.FrameNames.SPELL_PREVIEW_BUTTON_NAME .. specialisation .. '_' .. index,
                specialisationFrameScrollBox, index,
                specialisation);

            previewButton:SetPoint("TOPLEFT", specialisationFrameScrollBox, "TOP", 15, (-40 * index) + 36);
            spellBox:SetPoint("TOPLEFT", specialisationFrameScrollBox, "TOP", 60, (-40 * index) + 36);
            countTypeBox:SetPoint("TOPLEFT", specialisationFrameScrollBox, "TOP", 260, (-40 * index) + 40);
            windowPartBox:SetPoint("TOPLEFT", specialisationFrameScrollBox, "TOP", 445, (-40 * index) + 40);
            deleteRowButton:SetPoint("TOPLEFT", specialisationFrameScrollBox, "TOP", 640, (-40 * index) + 36);
        end

        resizeScrollFrame(#windowSpellConfiguration.spells, specialisation, specialisationFrameScrollBox);
    end
end

local function generateSpecialisationTab(tabIndex, specialisation)
    local leftPowerBarValue = nil;
    local rightPowerBarValue = nil;
    local leftPowerBarColorValue = nil;
    local rightPowerBarColorValue = nil;
    local chosenWindow = nil;
    local tabAnchorName;
    local parentFrame = DivineWindow.ConfigurationScreen.frame;
    local frameName = DivineWindow.ConfigurationScreen.FrameNames.SPECIALISATION_SCREEN_NAME .. tostring(tabIndex);
    local scrollFrameName = DivineWindow.ConfigurationScreen.FrameNames.SPECIALISATION_SCREEN_SCROLL_NAME ..
        tostring(tabIndex);
    local tabName = DivineWindow.ConfigurationScreen.FrameNames.SPECIALISATION_SCREEN_TAB_BUTTON_NAME ..
        tostring(tabIndex);

    -- get initial values
    local windowSpellConfiguration = DivineWindow.Utilities.getWindowConfiguration(specialisation);
    if (windowSpellConfiguration and windowSpellConfiguration.isSetUp) then
        leftPowerBarValue = windowSpellConfiguration.powerBar.left;
        rightPowerBarValue = windowSpellConfiguration.powerBar.right;
        leftPowerBarColorValue = windowSpellConfiguration.powerBarColor.left;
        rightPowerBarColorValue = windowSpellConfiguration.powerBarColor.right;
        chosenWindow = windowSpellConfiguration.chosenWindow;
    end


    -- return panel;

    local specialisationFrame = CreateFrame("ScrollFrame", frameName, parentFrame, "UIPanelScrollFrameTemplate")
    local scrollChildFrame = CreateFrame("Frame", scrollFrameName, specialisationFrame)

    scrollChildFrame:SetPoint("TOPLEFT", 16, -16)
    scrollChildFrame:SetWidth(specialisationFrame:GetWidth() - 18)

    local leftPowerBar = createPowerBarDropDownBox(
        DivineWindow.ConfigurationScreen.FrameNames.SPECIALISATION_SCREEN_POWER_BAR_LEFT_NAME .. tostring(tabIndex),
        specialisationFrame, "left", specialisation, leftPowerBarValue);
    local leftPowerBarColor = createPowerBarColorDropDownBox(
        DivineWindow.ConfigurationScreen.FrameNames.SPECIALISATION_SCREEN_POWER_BAR_LEFT_COLOR_NAME .. tostring(tabIndex),
        specialisationFrame, "left", specialisation, leftPowerBarColorValue);
    local rightPowerBar = createPowerBarDropDownBox(
        DivineWindow.ConfigurationScreen.FrameNames.SPECIALISATION_SCREEN_POWER_BAR_RIGHT_NAME .. tostring(tabIndex),
        specialisationFrame, "right", specialisation, rightPowerBarValue);
    local rightPowerBarColor = createPowerBarColorDropDownBox(
        DivineWindow.ConfigurationScreen.FrameNames.SPECIALISATION_SCREEN_POWER_BAR_RIGHT_COLOR_NAME ..
        tostring(tabIndex),
        specialisationFrame, "right", specialisation, rightPowerBarColorValue);


    local function recreateEditBoxes(newWindow)
        -- iterate over all spells and recreate the edit boxes
        local windowSpellConfiguration = DivineWindow.Utilities.getWindowConfiguration(specialisation);
        if (windowSpellConfiguration and windowSpellConfiguration.isSetUp) then
            for index, spellConfiguration in ipairs(windowSpellConfiguration.spells) do
                local dropdown = DivineWindow.ConfigurationScreen.FrameNames.SPELL_WINDOW_PART_DROPDOWN_NAME ..
                    specialisation .. "_" .. index;

                UIDropDownMenu_Initialize(
                    _G[dropdown],
                    windowPartMenuInfo(index, specialisation, newWindow))
                UIDropDownMenu_SetSelectedValue(_G[dropdown], spellConfiguration.windowPart);
            end
        end
    end

    local selectedWindow = DivineWindow.ConfigurationScreen.createWindowDropdown(
        DivineWindow.ConfigurationScreen.FrameNames.SPECIALISATION_SCREEN_WINDOW_DROPDOWN_NAME .. tostring(tabIndex),
        specialisationFrame, specialisation, chosenWindow, recreateEditBoxes);

    leftPowerBar:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 270, -60);
    rightPowerBar:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 453, -60);
    leftPowerBarColor:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 270, -90);
    rightPowerBarColor:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 453, -90);
    selectedWindow:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 20, -62);


    local labels = DivineWindow.Locales[DivineWindow.language].Labels;

    -- add labels for various elements;
    createText(labels.window, specialisationFrame):SetPoint("TOPLEFT", selectedWindow, "TOPLEFT", -25, 22);
    createText(labels.leftPowerBar, specialisationFrame):SetPoint("TOPLEFT", leftPowerBar, "TOPLEFT", -35, 22);
    createText(labels.rightPowerBar, specialisationFrame):SetPoint("TOPLEFT", rightPowerBar, "TOPLEFT", -33, 22);
    createText(labels.preview, specialisationFrame):SetPoint("TOPLEFT", parentFrame, "TOPLEFT", -62, -130);
    createText(labels.spellName, specialisationFrame):SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 60,
        -130);
    createText(labels.timer, specialisationFrame):SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 230, -130);
    createText(labels.windowPart, specialisationFrame):SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 450, -130);
    createText(labels.delete, specialisationFrame):SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 570, -130);

    -- create some lines:
    local line = specialisationFrame:CreateLine()
    line:SetColorTexture(1, 0, 0)
    line:SetStartPoint("CENTER", -20, 20) -- start topleft
    --

    local tab = CreateFrame("Button", tabName, parentFrame, "PanelTabButtonTemplate")
    local ContentSlider = CreateFrame("Slider",
        DivineWindow.ConfigurationScreen.FrameNames.SPECIALISATION_SCREEN_SLIDER_NAME .. tostring(tabIndex),
        specialisationFrame,
        "OptionsSliderTemplate")
    ContentSlider:Show()

    specialisationFrame:SetWidth(parentFrame:GetWidth())
    specialisationFrame:SetHeight(parentFrame:GetHeight())
    specialisationFrame:SetPoint("TOPLEFT", 20, -150)
    specialisationFrame:SetPoint("BOTTOMRIGHT", -27, 50)


    -- set scrollchilds
    specialisationFrame:SetScrollChild(scrollChildFrame)

    local addRowButton = CreateFrame("Button",
        DivineWindow.ConfigurationScreen.FrameNames.SPELL_ADD_ROW .. specialisation,
        specialisationFrame, "UIPanelButtonTemplate")
    addRowButton:SetPoint("TOPLEFT", specialisationFrame, "BOTTOMLEFT", 5, 0);

    addRowButton:SetText(labels.addRow);
    addRowButton:SetWidth(100)
    addRowButton:SetHeight(30)
    addRowButton:Show();
    addRowButton:SetScript("OnClick", function(self)
        addRow(self, specialisation, scrollChildFrame, chosenWindow)
    end)

    specialisationFrame:Hide()

    --- tabs
    if (tabIndex == 1) then
        tabAnchorName = DivineWindow.ConfigurationScreen.FrameNames.GENERAL_TAB_NAME;
    else
        tabAnchorName = DivineWindow.ConfigurationScreen.FrameNames.SPECIALISATION_SCREEN_TAB_BUTTON_NAME .. tabIndex - 1;
    end

    tab:SetPoint("LEFT", tabAnchorName, "RIGHT", 10, 0)
    tab:SetText(specialisation)
    tab:SetWidth((string.len(specialisation) * 8) + 10);
    tab:SetScript("OnClick", DivineWindow.ConfigurationScreen.setActiveTab(tabIndex, specialisation))
    tab:RegisterForClicks("AnyDown")
    tab:Show();

    DivineWindow.ConfigurationScreen.generateEditBoxPerSpecialisation(scrollChildFrame, specialisation, chosenWindow);
end

-- only use when talents are initialized;
function DivineWindow.ConfigurationScreen.generateScreensForAllSpecialisations()
    local numberOfSpecialisations = DivineWindow.numberOfSpecialisations;
    for i = 1, numberOfSpecialisations do
        local _, specialisation, _, _, _, _ = GetSpecializationInfo(i);
        generateSpecialisationTab(i, specialisation);
    end

    local infoTab = CreateFrame("Button", DivineWindow.ConfigurationScreen.FrameNames.ABOUT_TAB_NAME,
        DivineWindow.ConfigurationScreen.frame, "PanelTabButtonTemplate")
    local buttonAnchor =
        _G[DivineWindow.ConfigurationScreen.FrameNames.SPECIALISATION_SCREEN_TAB_BUTTON_NAME ..
        numberOfSpecialisations];
    infoTab:SetPoint("LEFT", buttonAnchor, "RIGHT", 10, 0)
    infoTab:SetText(DivineWindow.Locales[DivineWindow.language].InfoTab.tabTitle)


    infoTab:SetScript("OnClick",
        function() DivineWindow.ConfigurationScreen.openConfigTab(numberOfSpecialisations + 1) end);
    infoTab:RegisterForClicks("AnyDown")
    infoTab:Show();
end

DivineWindow.Utilities.debugPrint("Src/ConfigurationScreen/SpecialisationSettings.lua", "file")
