-- DivineWindow.Locales.English.PALADIN
local function handleBuffDebuffExpirationTime(auraDuration, auraRemainingTime, facets)
    if (not auraDuration or not auraRemainingTime) then
        return 0;
    end

    return math.ceil(facets / auraDuration * auraRemainingTime);
end

local function handleBuffDeBuffStacks(auraStacks, auraTotalStacks, facets)
    if (not auraStacks or not auraTotalStacks) then
        return 0;
    end
    return math.ceil(facets / auraStacks * auraTotalStacks);
end


local function handleCooldown(auraDuration, auraRemainingTime, facets)
    if (not auraDuration or not auraRemainingTime) then
        return 0;
    end
    return math.ceil(facets / auraDuration * auraRemainingTime);
end

local function handleCooldownStacks(auraStacks, auraTotalStacks, facets)
    if (not auraStacks or not auraTotalStacks) then
        return 0;
    end
    return math.ceil(facets / auraStacks * auraTotalStacks);
end


local function handleOnOff(isOn, facets)
    if (isOn) then
        return facets;
    end

    return nil;
end

local function getChosenWindowTextureBasePath(specialisation)
    if (
            DivineWindowLocalVars
            and DivineWindowLocalVars.specialisation
            and DivineWindowLocalVars.specialisation[specialisation]
            and DivineWindowLocalVars.specialisation[specialisation].chosenWindow) then
        local category = DivineWindowLocalVars.specialisation[specialisation].chosenWindow[1];
        local window = DivineWindowLocalVars.specialisation[specialisation].chosenWindow[2];

        if (not (category and window)) then
            return nil, nil, nil;
        end

        local basePath = DivineWindow.Windows[category][window].Directory;

        return basePath, category, window;
    end

    return nil, nil, nil;
end

function DivineWindow.Interface.resetTextures()
    for i = 1, 9 do
        local textureLocation = _G["DivineWindow_Interface_PART_" .. i];
        textureLocation:SetTexture(nil, false);
    end

    _G["DivineWindow_Interface_FX_1"]:SetTexture(nil, false);
    _G["DivineWindow_Interface_FX_2"]:SetTexture(nil, false);
end

function DivineWindow.Interface.setBaseTextures(
    chosenWindow
)
    DivineWindow.Interface.resetTextures()
    local basePath, category, window = getChosenWindowTextureBasePath(chosenWindow);

    if (not (basePath and category and window)) then
        return;
    end

    if (not (basePath and category and window)) then
        return;
    end

    local shading = _G["DivineWindow_Interface_SHADES"];
    local window = _G["DivineWindow_Interface_WINDOW"];
    local grain = _G["DivineWindow_Interface_GRAIN"];
    local shadingFile = basePath .. "\\Shading.blp";
    local grainFile = basePath .. "\\Grain.blp";
    local windowFile = basePath .. "\\Window.blp";

    shading:SetTexture(shadingFile, false);
    window:SetTexture(windowFile, false);
    grain:SetTexture(grainFile, false);
end

function DivineWindow.Interface.handleWindowFacet(
    countType,
    isOn,
    auraDuration,
    auraRemainingTime,
    auraStacks,
    auraTotalStacks,
    chosenWindow, windowPart, test
)
    local textureLocation = _G["DivineWindow_Interface_" .. windowPart];
    local currentFacet;

    if (not textureLocation) then
        return;
    end

    local colorOpacity = DivineWindowLocalVars.windowColorAlpha or 1;
    local basePath, category, window = getChosenWindowTextureBasePath(chosenWindow);

    if (not (basePath and category and window)) then
        return;
    end

    local facets = DivineWindow.Windows[category][window].FacetCount[windowPart];


    if (not (facets and basePath)) then
        return;
    end

    if (countType == DivineWindow.Constants.CountType.ON_OFF) then
        currentFacet = handleOnOff(isOn, facets);
    end

    if (countType == DivineWindow.Constants.CountType.BUFF_DEBUFF_STACKS) then
        currentFacet = handleBuffDeBuffStacks(auraStacks, auraTotalStacks, facets);
    end

    if (countType == DivineWindow.Constants.CountType.BUFF_DEBUFF_EXPIRATION_TIME) then
        currentFacet = handleBuffDebuffExpirationTime(auraDuration, auraRemainingTime, facets);
    end

    if (countType == DivineWindow.Constants.CountType.COOLDOWN_TIMER) then
        currentFacet = handleCooldown(auraDuration, auraRemainingTime, facets);
    end

    if (countType == DivineWindow.Constants.CountType.COOLDOWN_STACKS) then
        currentFacet = handleCooldownStacks(auraStacks, auraTotalStacks, facets);
    end

    if ((currentFacet == nil or currentFacet == 0) and not test) then
        textureLocation:SetTexture(nil, false)
        return;
    end

    local textureFile =
        basePath .. "\\" .. windowPart .. "\\" .. currentFacet .. ".blp"

    textureLocation:SetTexture(textureFile, false);
    textureLocation:SetAlpha(colorOpacity);
end
