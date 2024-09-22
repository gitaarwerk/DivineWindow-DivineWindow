local function nilFunc() end
local previewTimer = C_Timer.NewTimer(0, nilFunc)
local previewTime = 3; -- seconds

local function resetPreviewCombatAlpha()
    if DivineWindow.Utilities.skipAfterReset() == true then return end;

    if (DivineWindow.Interface.frame) then
        if (UnitAffectingCombat("player")) then
            DivineWindow.Interface.frame:SetAlpha(DivineWindowLocalVars.inComabtAlpha);
        else
            DivineWindow.Interface.frame:SetAlpha(DivineWindowLocalVars.outOfCombatAlpha);
        end
    end
    previewTimer:Cancel()
end

function DivineWindow.ConfigurationScreen.setScale(value)
    DivineWindowLocalVars.scale = value;
    DivineWindow.Interface.frame:SetScale(value);
end

function DivineWindow.ConfigurationScreen.setInCombatAlpha(value)
    DivineWindowLocalVars.inComabtAlpha = value;
    DivineWindow.Interface.frame:SetAlpha(value);
    previewTimer:Cancel()
    previewTimer = C_Timer.NewTimer(previewTime, resetPreviewCombatAlpha)
end

function DivineWindow.ConfigurationScreen.setOutOfCombatAlpha(value)
    DivineWindowLocalVars.outOfCombatAlpha = value;
    DivineWindow.Interface.frame:SetAlpha(value);
    previewTimer:Cancel()
    previewTimer = C_Timer.NewTimer(previewTime, resetPreviewCombatAlpha)
end

function DivineWindow.ConfigurationScreen.setWindowShadingAlpha(value)
    DivineWindowLocalVars.windowGlassShading = value;
    _G["DivineWindow_Interface_" .. DivineWindow.Constants.WindowDetailType.SHADES]:SetAlpha(value);
    _G["DivineWindow_Interface_" .. DivineWindow.Constants.WindowDetailType.BASE_SHADES]:SetAlpha(value);
end

function DivineWindow.ConfigurationScreen.setWindowGrainAlpha(value)
    DivineWindowLocalVars.windowGlassGrain = value;
    _G["DivineWindow_Interface_" .. DivineWindow.Constants.WindowDetailType.GRAIN]:SetAlpha(value);
end

function DivineWindow.ConfigurationScreen.setWindowColorAlpha(value)
    DivineWindowLocalVars.windowColorAlpha = value;
end

function DivineWindow.ConfigurationScreen.setWindowBackgroundAlpha(value)
    DivineWindowLocalVars.windowBackgroundAlpha = value;
    _G["DivineWindow_Interface_" .. DivineWindow.Constants.WindowDetailType.BACKGROUND]:SetAlpha(value);
end

DivineWindow.Utilities.debugPrint("Src/ConfigurationScreen/GeneralSettings.lua", "file")
