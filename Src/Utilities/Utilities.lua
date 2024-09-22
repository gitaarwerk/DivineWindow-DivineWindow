function DivineWindow.Utilities.dump(o)
  if type(o) == 'table' then
    local s = '{ ';
    for k, v in pairs(o) do
      if type(k) ~= 'number' then k = '"' .. k .. '"' end
      s = s .. '[' .. k .. '] = ' .. DivineWindow.Utilities.dump(v) .. ',';
    end
    return s .. '} ';
  else
    return tostring(o);
  end
end

function DivineWindow.Utilities.debugPrint(message, type)
  if (DivineWindow.debugMode) then
    if (type == "file") then
      print("[DW loaded file]: " .. message)
    else
      print("[DW Debug]: " .. message)
    end
  end
end

function DivineWindow.Utilities.skipAfterReset()
  if (DivineWindowLocalVars == {} or DivineWindowGlobalVars == {}) then
    return true
  end

  return false;
end

function DivineWindow.Utilities.parseText(s, tab)
  return (s:gsub('($%b{})', function(w) return tab[w:sub(3, -2)] or w end))
end

function DivineWindow.Utilities.mergeTable(t1, t2)
  for i = 1, #t2 do
    t1[#t1 + 1] = t2[i]
  end
  return t1
end

local function getCharacterinfo(target)
  local genderTable = { "neuter or unknown", "male", "female" };
  local localizedPlayerClass, playerClass, _ = UnitClass(target);
  local name, _, _ = UnitName(target)
  local unitLevel = UnitLevel(target)
  local gender = genderTable[UnitSex(target)]
  local race, _ = UnitRace(target);

  return name, gender, playerClass, race, unitLevel
end

function DivineWindow.Utilities.round(number)
  return number >= 0 and math.floor(number + 0.5) or math.ceil(number - 0.5)
end

function DivineWindow.Utilities.getPlayerInformation()
  return getCharacterinfo("player")
end

function DivineWindow.Utilities.tableIsEmpty(table)
  if (table == nil or table == {} or type(table) == nil) then
    return true
  end

  for _, _ in pairs(table) do
    return false
  end

  return true
end

function DivineWindow.Utilities.capitalizeString(str)
  local newString = string.lower(str)
  return (newString:gsub("^%l", string.upper))
end

function DivineWindow.Utilities.tableContainsValue(table, val)
  for index, value in ipairs(table) do
    if value == val then
      return true
    end
  end

  return false
end

function DivineWindow.Utilities.tableContainsKey(table, key)
  for k, v in pairs(table) do
    if k == key then
      return true
    end
  end

  return false
end

function DivineWindow.Utilities.tableContainsSameData(table1, table2)
  if #table1 ~= #table2 then return false end
  -- Consider an early "return true" if table1 == table2 here
  local t1_counts = {}
  -- Check if the same elements occur the same number of times
  for _, v1 in ipairs(table1) do
    t1_counts[v1] = (t1_counts[v1] or 0) + 1
  end
  for _, v2 in ipairs(table2) do
    local count = t1_counts[v2] or 0
    if count == 0 then return false end
    t1_counts[v2] = count - 1
  end
  return true
end

function DivineWindow.Utilities.getWindowConfiguration(specialisation)
  if (not DivineWindowLocalVars or not specialisation) then
    return nil
  end

  local specialisationExists = DivineWindowLocalVars.specialisation and
      DivineWindow.Utilities.tableIsEmpty(DivineWindowLocalVars.specialisation) == false;

  if (specialisationExists) then
    local specialisationTable = DivineWindowLocalVars.specialisation and
        DivineWindowLocalVars.specialisation[specialisation];
    if (specialisationTable and specialisationTable.isSetUp) then
      return specialisationTable;
    end
  end

  return nil
end

function DivineWindow.Utilities.classHasSupportedSpecialisation()
  if (DivineWindow.specialisation and DivineWindow.supportedSpecialisations) then
    local hasSupportedSpecialisation = DivineWindow.Utilities.tableContainsValue(
      DivineWindow.supportedSpecialisations, DivineWindow.specialisation);
    DivineWindow.Utilities.debugPrint("Has supported specialisation: " .. tostring(hasSupportedSpecialisation))
    return hasSupportedSpecialisation
  end

  return false
end

function DivineWindow.Utilities.ShowError(message)
  print("[Divine Window] Error: " .. message)
end

DivineWindow.Utilities.debugPrint("Src/Utilities/Utilities.lua", "file")
