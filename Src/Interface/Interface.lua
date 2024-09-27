DivineWindow.Interface.updateInterface = 0.25;
DivineWindow.Interface.frame = nil;
DivineWindow.Interface.target = "player";


local function setPositionOnLoad()
    DivineWindow.Interface.frame:ClearAllPoints();
    DivineWindow.Interface.frame:SetPoint(
        DivineWindowLocalVars.position[1],
        DivineWindowLocalVars.position[2],
        DivineWindowLocalVars.position[3],
        DivineWindowLocalVars.position[4],
        DivineWindowLocalVars.position[5]
    );
end

function DivineWindow.Interface.savePositionToCharacter()
    local frame = DivineWindow.Interface.frame;
    local anchor, anchorTwo, anchorThree, x, y = frame:GetPoint();

    DivineWindowLocalVars.position[1] = anchor;
    DivineWindowLocalVars.position[2] = anchorTwo;
    DivineWindowLocalVars.position[3] = anchorThree;
    DivineWindowLocalVars.position[4] = x;
    DivineWindowLocalVars.position[5] = y;

    DivineWindow.Utilities.debugPrint("saved positioning: " ..
        DivineWindow.Utilities.dump(DivineWindowLocalVars.position))
end

function DivineWindow.Interface.getOutOfCombatAlpha()
    DivineWindow.Utilities.debugPrint('out of combat alpha: ', tostring(DivineWindowLocalVars.outOfCombatAlpha))
    return DivineWindowLocalVars.outOfCombatAlpha;
end

function DivineWindow.Interface.getInCombatAlpha()
    DivineWindow.Utilities.debugPrint('in combat alpha: ', tostring(DivineWindowLocalVars.inComabtAlpha))
    return DivineWindowLocalVars.inComabtAlpha;
end

function DivineWindow.Interface.getScale()
    DivineWindow.Utilities.debugPrint('scale: ', tostring(DivineWindowLocalVars.scale))
    return DivineWindowLocalVars.scale
end

function DivineWindow.Interface.getWindowShadingAlpha()
    DivineWindow.Utilities.debugPrint('windowGlassShading: ', tostring(DivineWindowLocalVars.windowGlassShading))
    return DivineWindowLocalVars.windowGlassShading
end

function DivineWindow.Interface.getWindowGrainAlpha()
    DivineWindow.Utilities.debugPrint('windowGlassGrain: ', tostring(DivineWindowLocalVars.windowGlassGrain))
    return DivineWindowLocalVars.windowGlassGrain
end

function DivineWindow.Interface.getWindowColorAlpha()
    DivineWindow.Utilities.debugPrint('windowColorAlpha: ', tostring(DivineWindowLocalVars.windowColorAlpha))
    return DivineWindowLocalVars.windowColorAlpha
end

function DivineWindow.Interface.getWindowBackgroundAlpha()
    DivineWindow.Utilities.debugPrint('windowBackgroundlpha: ', tostring(DivineWindowLocalVars.windowBackgroundAlpha))
    return DivineWindowLocalVars.windowBackgroundAlpha
end

function DivineWindow.Interface.hide()
    DivineWindow.Interface.frame:Hide();
end

function DivineWindow.Interface.setGlassTextures()
    DivineWindow.Interface.frame:SetAlpha(DivineWindow.Interface.getOutOfCombatAlpha());
    DivineWindow.Interface.frame:SetScale(DivineWindow.Interface.getScale());
    _G["DivineWindow_Interface_" .. DivineWindow.Constants.WindowDetailType.BASE_SHADES]:SetAlpha(DivineWindow.Interface
        .getWindowShadingAlpha());
    _G["DivineWindow_Interface_" .. DivineWindow.Constants.WindowDetailType.SHADES]:SetAlpha(DivineWindow.Interface
        .getWindowShadingAlpha());
    _G["DivineWindow_Interface_" .. DivineWindow.Constants.WindowDetailType.GRAIN]:SetAlpha(DivineWindow.Interface
        .getWindowGrainAlpha());
end

function DivineWindow.Interface.show()
    DivineWindow.Interface.setGlassTextures()
    DivineWindow.Interface.frame:Show();
end

function DivineWindow.Interface.on()
    if (not DivineWindow.Utilities.classHasSupportedSpecialisation()) then
        DivineWindow.Utilities.debugPrint("Class does not have supported specialisation, putting interface off.");
        return;
    end

    DivineWindow.Interface.show();
    DivineWindowLocalVars.active = true;
end

function DivineWindow.Interface.off()
    DivineWindowLocalVars.active = false;
    DivineWindow.Interface.hide();
end

local function handleCooldown(spellName)
    if (not spellName) then
        return;
    end
    local spellCharges = C_Spell.GetSpellCharges(spellName);
    if (spellCharges == nil) then
        return nil, nil, nil, nil, nil;
    end

    local auraStacks, auraTotalStacks, auraStart, auraDuration, _ = spellCharges.currentCharges,
        spellCharges.maxCharges, spellCharges.cooldownStartTime, spellCharges.cooldownDuration,
        spellCharges.chargeModRate;
    local hasCooldown = auraStart and auraStart > 0 and auraDuration and auraDuration > 0;
    local auraRemainingTime = 0;


    if (hasCooldown) then
        auraRemainingTime = DivineWindow.Utilities.round(auraStart + auraDuration - GetTime());
    end;


    return spellName, auraRemainingTime, auraDuration, auraStacks, auraTotalStacks
end

local function handleAura(name, aura)
    local time = GetTime();
    local totalDuration = aura.duration;
    local remaintingTime = aura.expirationTime > 0 and aura.expirationTime - time or 0;

    -- possibility that this is a totem-related aura, then the expirationTime is not set, so this will take over.
    if (aura.nameplateShowPersonal) then
        for index = 1, 4 do
            local _, totemName, totemStartTime, totemDuration = GetTotemInfo(index);
            if (totemName == name) then
                local hasCooldown = totemDuration and totemStartTime and totemStartTime > 0 and totemDuration and
                    totemDuration > 0;
                totalDuration = totemDuration;
                remaintingTime = hasCooldown and totemStartTime + totemDuration - time or 0;
            end
        end
    end

    return
        name,
        aura.durationstacks,
        DivineWindow.Utilities.round(remaintingTime),
        DivineWindow.Utilities.round(totalDuration)
end

-- Shows the current window based on the active specialisation;
-- If configuration screen is open, it should show the screen for that specialisation;
-- if the specialisation is not set-up, show default window;
local function getActiveWindowToShow()
    if (
            DivineWindow.ConfigurationScreen.activeSpecialisationName
            and DivineWindowLocalVars.specialisation[DivineWindow.ConfigurationScreen.activeSpecialisationName]
            and DivineWindowLocalVars.specialisation[DivineWindow.ConfigurationScreen.activeSpecialisationName].isSetUp) then
        return DivineWindow.ConfigurationScreen.activeSpecialisationName;
    end

    return DivineWindow.specialisation;
end

function DivineWindow.Interface.onUpdate(self, elapsed)
    if not DivineWindowLocalVars.active then
        return;
    end

    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;

    if (self.TimeSinceLastUpdate > DivineWindow.Interface.updateInterface) then
        local activeWindow = getActiveWindowToShow();
        DivineWindow.Interface.setBaseTextures(activeWindow);
        local windowSpellConfiguration = DivineWindow.Utilities.getWindowConfiguration(activeWindow);

        if (windowSpellConfiguration and windowSpellConfiguration.isSetUp) then
            DivineWindow.Interface.handlePowerBar(DivineWindow.Constants.WindowPowerBarType.LEFT_BAR,
                windowSpellConfiguration.powerBar.left, windowSpellConfiguration.powerBarColor.left)
            DivineWindow.Interface.handlePowerBar(DivineWindow.Constants.WindowPowerBarType.RIGHT_BAR,
                windowSpellConfiguration.powerBar.right, windowSpellConfiguration.powerBarColor.right)

            -- loop trough all items from windowSpellConfiguration
            for index, spellConfiguration in ipairs(windowSpellConfiguration.spells) do
                local spellName = spellConfiguration.name;
                local countType = spellConfiguration.countType;
                local windowPart = spellConfiguration.windowPart;
                local aura, auraName, isOn, auraDuration, auraRemainingTime, auraStacks, auraTotalStacks;

                -- stop processing if spell-set-up is not complete
                if (not (windowPart and countType and spellName)) then
                    return;
                end


                if (countType == DivineWindow.Constants.CountType.BUFF_DEBUFF_EXPIRATION_TIME or countType == DivineWindow.Constants.CountType.BUFF_DEBUFF_STACKS) then
                    if (AuraUtil.FindAuraByName(spellName, DivineWindow.Interface.target, "HARMFUL")) then
                        aura = C_UnitAuras.GetAuraDataBySpellName(DivineWindow.Interface.target, spellName, "HARMFUL")
                    end

                    if (AuraUtil.FindAuraByName(spellName, DivineWindow.Interface.target, "HELPFUL")) then
                        aura = C_UnitAuras.GetAuraDataBySpellName(DivineWindow.Interface.target, spellName, "HELPFUL")
                    end

                    if (AuraUtil.FindAuraByName(spellName, DivineWindow.Interface.target, "PLAYER")) then
                        aura = C_UnitAuras.GetAuraDataBySpellName(DivineWindow.Interface.target, spellName, "PLAYER")
                    end

                    if (AuraUtil.FindAuraByName(spellName, DivineWindow.Interface.target, "RAID")) then
                        aura = C_UnitAuras.GetAuraDataBySpellName(DivineWindow.Interface.target, spellName, "RAID")
                    end

                    if (type(aura) == "table") then
                        auraName, auraStacks, auraRemainingTime, auraDuration = handleAura(spellName, aura);
                    end
                end

                if (countType == DivineWindow.Constants.CountType.ON_OFF) then
                    isOn = false;
                    if (
                            AuraUtil.FindAuraByName(spellName, DivineWindow.Interface.target, "HARMFUL") or
                            AuraUtil.FindAuraByName(spellName, DivineWindow.Interface.target, "HELPFUL") or
                            AuraUtil.FindAuraByName(spellName, DivineWindow.Interface.target, "PLAYER") or
                            AuraUtil.FindAuraByName(spellName, DivineWindow.Interface.target, "RAID")
                        ) then
                        isOn = true;
                    end
                end

                if (countType == DivineWindow.Constants.CountType.COOLDOWN_TIMER or countType == DivineWindow.Constants.CountType.COOLDOWN_STACKS) then
                    auraName, auraRemainingTime, auraDuration, auraStacks, auraTotalStacks = handleCooldown(spellName);
                end



                DivineWindow.Interface.handleWindowFacet(
                    countType,
                    isOn,
                    auraDuration,
                    auraRemainingTime,
                    auraStacks,
                    auraTotalStacks,
                    activeWindow,
                    windowPart
                );
            end
        end

        self.TimeSinceLastUpdate = 0;
    end
end

function DivineWindow.Interface.eventHandler(_, event, arg1, ...)
    if (event == "ADDON_LOADED" and arg1 == "DivineWindow") then
        local frame = _G["DivineWindow_Interface"];
        DivineWindow.Interface.frame = frame;

        if (DivineWindowLocalVars.active == true) then
            DivineWindow.Interface.on();
        else
            DivineWindow.Interface.off();
        end

        setPositionOnLoad();

        if (UnitAffectingCombat("player")) then
            DivineWindow.Interface.frame:SetAlpha(DivineWindow.Interface.getInCombatAlpha());
        else
            DivineWindow.Interface.frame:SetAlpha(DivineWindow.Interface.getOutOfCombatAlpha());
        end
    end

    if (DivineWindow.Constants and (event == "PLAYER_TALENT_UPDATE")) then
        -- do stuff like load different specialisation window graphics etc.
    end

    if (event == "PLAYER_ENTERING_WORLD") then
        -- nothing yet...
    end

    if (event == "UNIT_AURA") then
        if arg1 ~= "player" then
            return
        end
    end


    if (event == "PLAYER_REGEN_DISABLED" and C_SpecializationInfo.IsInitialized()) then
        DivineWindow.Interface.frame:SetAlpha(DivineWindow.Interface.getInCombatAlpha());
    end

    if (event == "PLAYER_REGEN_ENABLED" and C_SpecializationInfo.IsInitialized()) then
        DivineWindow.Interface.frame:SetAlpha(DivineWindow.Interface.getOutOfCombatAlpha());
    end
end

DivineWindow.Utilities.debugPrint("Src/Interface/Interface.lua", "file")
