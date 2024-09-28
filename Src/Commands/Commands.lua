local function toggleDebug()
    DivineWindowGlobalVars.debugMode = not DivineWindowGlobalVars.debugMode
    local debugText = DivineWindowGlobalVars.debugMode and "on" or "off"
    DivineWindow.Utilities.printToUser('DW Debug mode: ' .. debugText);
end

local function resetSavedVariables()
    DivineWindow.Interface.off();
    DivineWindow.ConfigurationScreen:hide();

    DivineWindowGlobalVars = {};
    DivineWindow.Utilities.printToUser("DW Saved Variables have been reset");
end

local function resetSavedVariablesPerCharacter()
    DivineWindow.Interface.off();
    DivineWindow.ConfigurationScreen:hide();
    DivineWindowLocalVars = {};
    DivineWindow.Utilities.printToUser("DW Saved Variables have been reset for this character");
end

local function resetAll()
    resetSavedVariables();
    resetSavedVariablesPerCharacter();
end

local function cmd(msg)
    local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")

    if cmd == "on" then
        DivineWindow.Interface.on();
    elseif cmd == "off" then
        DivineWindow.Interface.off();
    elseif cmd == "debug" then
        toggleDebug();
    elseif cmd == "config" then
        DivineWindow.ConfigurationScreen:show();
        DivineWindow.Interface.show();
    elseif cmd == "test" then
        DivineWindow.Utilities.printToUser('Testing unlock table:')
        DivineWindow.ConfigurationScreen.addToLockTable(args, nil, true)
    elseif cmd == "dump" then
        DivineWindow.Utilities.printToUser('---- local vars ----')
        DevTools_Dump(DivineWindowLocalVars);
        DivineWindow.Utilities.printToUser('---- global vars ----')
        DevTools_Dump(DivineWindowGlobalVars);
    elseif cmd == "resetGlobal" then
        if (args == "confirm") then
            resetSavedVariables();
        else
            DivineWindow.Utilities.printToUser("To reset the global saved variables, type: /dw resetGlobal confirm");
        end
    elseif cmd == "resetCharacter" then
        if (args == "confirm") then
            resetSavedVariablesPerCharacter();
        else
            DivineWindow.Utilities.printToUser("To reset the character saved variables, type: /dw resetCharacter confirm");
        end
    elseif cmd == "reset" then
        if (args == "confirm" or DivineWindowGlobalVars.debugMode == true) then
            resetAll();
        else
            DivineWindow.Utilities.printToUser("To reset all saved variables, type: /dw reset confirm");
        end
    else
        -- If not handled above, display some sort of help message
        DivineWindow.Utilities.printToUser("To show or hide the button; interface, use one of these commands:");
        DivineWindow.Utilities.printToUser("Syntax: /dw show");
        DivineWindow.Utilities.printToUser("Syntax: /dw hide");
        DivineWindow.Utilities.printToUser("Syntax: /dw config");
        DivineWindow.Utilities.printToUser("", "And to reset the saved settings:");
        DivineWindow.Utilities.printToUser("Syntax: /dw resetGlobal confirm");
        DivineWindow.Utilities.printToUser("Syntax: /dw resetCharacter confirm");
        DivineWindow.Utilities.printToUser("Syntax: /dw resetreset confirm");
    end
end

SlashCmdList["DW"] = cmd;

SLASH_DW1 = "/dw";
SLASH_DW2 = "/divinewindow";

DivineWindow.Utilities.debugDivineWindow.Utilities.printToUser("Src/Commands/Commands.lua", "file");
