local function StringHash(text)
    local counter = 1
    local len = string.len(text)
    for i = 1, len, 3 do
        counter = math.fmod(counter * 8161, 4294967279) + -- 2^32 - 17: Prime!
            (string.byte(text, i) * 16776193) +
            ((string.byte(text, i + 1) or (len - i + 256)) * 8372226) +
            ((string.byte(text, i + 2) or (len - i + 256)) * 3932164)
    end
    return math.fmod(counter, 4294967291) -- 2^32 - 5: Prime (and different from the prime in the loop)
end

function DivineWindow.ConfigurationScreen.addToLockTable(lockString, value, test)
    local hashedString = StringHash(lockString);
    if (not test) then
        DivineWindowGlobalVars.unlockTable[hashedString] = value;
    end
    DivineWindow.Utilities.debugPrint("Unlock table: " .. hashedString)
end

DivineWindow.Utilities.debugPrint("Src/ConfigurationScreen/UnlockTable.lua", "file")
