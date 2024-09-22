local function toggleDebug()
    DivineWindowGlobalVars.debugMode = not DivineWindowGlobalVars.debugMode
    local debugText = DivineWindowGlobalVars.debugMode and "on" or "off"
    print('DW Debug mode: ' .. debugText);
end

local function dumpVars()
    local dumpedGlobalVars = DivineWindow.Utilities.dump(DivineWindowGlobalVars);
    local dumpedSavedVarsPerCharacter = DivineWindow.Utilities.dump(DivineWindowLocalVars);
    print("");
    print("DW global saved: " .. dumpedGlobalVars);
    print("");
    print("DW local saved: " .. dumpedSavedVarsPerCharacter);
end

local function resetSavedVariables()
    DivineWindow.Interface.off();
    DivineWindow.ConfigurationScreen:hide();

    DivineWindowGlobalVars = {};
    print("DW Saved Variables have been reset");
end

local function resetSavedVariablesPerCharacter()
    DivineWindow.Interface.off();
    DivineWindow.ConfigurationScreen:hide();
    DivineWindowLocalVars = {};
    print("DW Saved Variables have been reset for this character");
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
        print('Testing unlock table:')
        DivineWindow.ConfigurationScreen.addToLockTable(args, nil, true)
    elseif cmd == "dump" then
        print('---- local vars ----')
        DevTools_Dump(DivineWindowLocalVars);
        print('---- global vars ----')
        DevTools_Dump(DivineWindowGlobalVars);
    elseif cmd == "resetGlobal" then
        if (args == "confirm") then
            resetSavedVariables();
        else
            print("To reset the global saved variables, type: /dw resetGlobal confirm");
        end
    elseif cmd == "resetCharacter" then
        if (args == "confirm") then
            resetSavedVariablesPerCharacter();
        else
            print("To reset the character saved variables, type: /dw resetCharacter confirm");
        end
    elseif cmd == "reset" then
        if (args == "confirm" or DivineWindowGlobalVars.debugMode == true) then
            resetAll();
        else
            print("To reset all saved variables, type: /dw reset confirm");
        end
    else
        -- If not handled above, display some sort of help message
        print("To show or hide the button; interface, use one of these commands:");
        print("Syntax: /dw show");
        print("Syntax: /dw hide");
        print("Syntax: /dw config");
        print("", "And to reset the saved settings:");
        print("Syntax: /dw resetGlobal confirm");
        print("Syntax: /dw resetCharacter confirm");
        print("Syntax: /dw resetreset confirm");
    end
end

SlashCmdList["DW"] = cmd;

SLASH_DW1 = "/dw";
SLASH_DW2 = "/divinewindow";

DivineWindow.Utilities.debugPrint("Src/Commands/Commands.lua", "file");