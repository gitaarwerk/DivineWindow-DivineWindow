DivineWindow.Locales = DivineWindow.Locales or {}

function DivineWindow.Locales.setLanguage(locale)
    DivineWindow.Utilities.debugPrint("locale wanted to be set at: " .. locale)

    local language = DivineWindow.Support.locales[locale];
    if (language) then
        DivineWindow.language = language
    else
        DivineWindow.language = "English"
    end
    DivineWindow.Utilities.debugPrint("language is then set to: " .. language)
end

if (DivineWindow.debugMode) then
    print("[DW loaded file]: Src/Locales/Index.lua");
end
