-- Hints table is always filled with this structure: ["words to look for"] = "output hint"
DivineWindow.ConfigurationScreen.HintsTable = {}

local helloTable = {
    "Hello,...",
    "Yes?",
    "What is it?",
    "If you have nothing to say...",
    "I'm listening",
    "This must do something, right?"
}

local helpTable = {
    "I'm not here to help, just to provide.",
    "If I was here to help, you wouldn't get anywhere.",
}

local secretTable = {
    "Secrets are always exact.",
    "Yes, this is for something secret. Are you able to find it?",
    "You should look elsewhere for something secretive, perhaps on CurseForge/Overwolf?",
    "I'm not going to tell you anything. But keep trying.",
}

local divineWindowTable = {
    "You're right, this IS DivineWindow. What are you trying to achieve here?",
    "Yes, this is DivineWindow. I have a mirror, you know?",
}

local function playScenario(input)
    for key, value in pairs(DivineWindow.ConfigurationScreen.HintsTable) do
        if (string.find(input, key)) then
            return value;
        end
    end

    if (string.find(input, "secret")) then
        local randomIndex = math.random(1, #secretTable)
        return secretTable[randomIndex]
    end

    if (string.find(input, "help")) then
        local randomIndex = math.random(1, #helpTable)
        return helpTable[randomIndex]
    end

    if (string.find(input, "divine") or input.find(input, "divinewindow") or input.find(input, "divine window")) then
        local randomIndex = math.random(1, #divineWindowTable)
        return divineWindowTable[randomIndex]
    end

    if (input == "" or string.find(input, "hello") or string.find(input, "hi")) then
        local randomIndex = math.random(1, #helloTable)
        return helloTable[randomIndex]
    end

    return nil;
end

function DivineWindow.ConfigurationScreen.HandleInput()
    local input = _G[DivineWindow.ConfigurationScreen.FrameNames.INFO_SCREEN_INPUT_NAME]
    local text = input:GetText();
    local strlowerInput = string.lower(text);

    local scenarioText = playScenario(strlowerInput);

    input:SetText("");

    if (scenarioText) then
        DivineWindow.Utilities.printToUser(scenarioText)
        return;
    end

    DivineWindow.ConfigurationScreen.addToLockTable(text, "User input", false)
end

function DivineWindow.ConfigurationScreen.InitInput()
    local button = _G[DivineWindow.ConfigurationScreen.FrameNames.INFO_SCREEN_INPUT_BUTTON_NAME]
    local input = _G[DivineWindow.ConfigurationScreen.FrameNames.INFO_SCREEN_INPUT_NAME]

    input:SetWidth(200)
    input:SetHeight(30)
    input:SetAutoFocus(false)
    input:SetMaxLetters(100)
    input:SetMultiLine(false)

    if (button) then
        button:SetText(DivineWindow.Locales[DivineWindow.language].InfoTab.okText);
    end
end

DivineWindow.Utilities.debugPrint("Src/ConfigurationScreen/HandleInput.lua", "file")
