-- creating test data structure
DivineWindow.ConfigurationScreen.AvailableWindows = {}

function DivineWindow.ConfigurationScreen.createWindowDropdown(frameName, parentFrame, specialisation, selected,
                                                               onChangeHook)
    local language = DivineWindow.Locales[DivineWindow.language].AvailableWindows;
    local selectedValue = selected
    local dropdown = CreateFrame("DropdownButton", frameName, parentFrame, "WowStyle1DropdownTemplate")

    dropdown:SetPoint("CENTER")
    dropdown:SetWidth(250);

    local function IsSelected(value)
        if (value and selectedValue and type(value) == "table") then
            return DivineWindow.Utilities.tableContainsSameData(value, selectedValue)
        end

        return nil;
    end

    local function SetSelected(value)
        selectedValue = value
        DivineWindowLocalVars.specialisation[specialisation].chosenWindow = value;

        if (onChangeHook) then
            onChangeHook(value)
        end
    end

    local function GeneratorFunction(dropdown, rootDescription)
        rootDescription:CreateTitle(language.title);
        rootDescription:CreateDivider();

        dropdown:SetDefaultText(language.defaultText);

        if (DivineWindow.Utilities.tableIsEmpty(DivineWindow.ConfigurationScreen.AvailableWindows)) then
            dropdown:SetDefaultText(language.noWindowsAvailable);
            rootDescription:CreateTitle(language.noWindowsAvailable);
        end

        for key, value in pairs(DivineWindow.ConfigurationScreen.AvailableWindows) do
            local menu = rootDescription:CreateButton(language[key]);
            for key2, value2 in pairs(value) do
                menu:CreateRadio(language[key2], IsSelected, SetSelected, value2);
                -- @todo: [for later] change when multiple levels will be added....
                -- local subMenu = menu:CreateButton(language[key2]);
                -- for key3, value3 in pairs(value2) do
                --     subMenu:CreateRadio(language[key3], IsSelected, SetSelected, value3);
                -- end
            end
        end
    end

    dropdown:SetupMenu(GeneratorFunction);

    return dropdown
end

DivineWindow.Utilities.debugPrint("Src/ConfigurationScreen/WindowDropdown.lua", "file")
