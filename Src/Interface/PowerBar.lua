local function getHealth()
    local health = UnitHealth("player")
    local maxHealth = UnitHealthMax("player")
    local healthPercentage = math.ceil((health / maxHealth) * 100)

    return health, maxHealth, healthPercentage
end

local function getPower(powerType)
    local power = UnitPower("player", powerType)
    local maxPower = UnitPowerMax("player", powerType)
    local powerPercentage = math.ceil((power / maxPower) * 100)

    return power, maxPower, powerPercentage
end

function DivineWindow.Interface.handlePowerBar(side, powerType, color)
    local powerPercentage;
    local facets = 22;
    local colorOpacity = DivineWindowLocalVars.windowColorAlpha or 1;
    local texture = _G["DivineWindow_Interface_" .. DivineWindow.Constants.WindowPowerBarType[side]];
    local fx = _G["DivineWindow_Interface_" .. DivineWindow.Constants.WindowPowerBarType[side .. '_FX']];

    if (powerType == DivineWindow.Constants.PowerTypes.HEALTH) then
        _, _, powerPercentage = getHealth()
    else
        _, _, powerPercentage = getPower(Enum.PowerType[powerType])
    end
    local PowerBarDir = side == DivineWindow.Constants.WindowPowerBarType.LEFT_BAR and "LeftPowerBar" or "RightPowerBar";

    local currentFacet = math.ceil((facets / 100) * powerPercentage);
    local textureFile =
        "Interface\\AddOns\\DivineWindow\\Src\\Windows\\" ..
        PowerBarDir .. "\\" .. color .. "\\" ..
        currentFacet .. ".blp"
    texture:SetTexture(textureFile, false)

    if (powerPercentage == 100) then
        local fxFile =
            "Interface\\AddOns\\DivineWindow\\Src\\Windows\\" ..
            PowerBarDir .. "\\" .. color .. "\\" ..
            "fx.blp"
        fx:SetTexture(fxFile, false)
    else
        fx:SetTexture("", false)
    end
    texture:SetAlpha(colorOpacity);
    fx:SetAlpha(colorOpacity);
end
