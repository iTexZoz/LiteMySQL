---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by iTexZ.
--- DateTime: 12/06/2020 19:04
---

---@class Query
local Query = {};

---@class Select
local Select = {};

---@class Where
local Where = {}

---Insert
---
--- Insert database content.
---
---@param Table string
---@param Content table
---@return number
function Query:Insert(Table, Content)
    self.fields = "";
    self.keys = "";
    self.id = nil;
    for key, _ in pairs(Content) do
        self.fields = string.format('%s%s,', self.fields, key)
        key = string.format('@%s', key)
        self.keys = string.format('%s%s,', self.keys, key)
    end
    MySQL.Async.insert(string.format("INSERT INTO %s (%s) VALUES (%s)", Table, string.sub(self.fields, 1, -2), string.sub(self.keys, 1, -2)), Content, function(insertId)
        self.id = insertId; -- TODO Not working
    end)
    if (self.id ~= nil) then
        return self.id;
    end
end

function Query:Update()
    -- TODO 
end

---Select
---@return Select
---@param Table string
---@public
function Query:Select(Table)
    self.SelectTable = Table
    return Select;
end

---GetSelectTable
---@public
function Query:GetSelectTable()
    return self.SelectTable;
end

---All
---@return any
---@private
function Select:All()
    local storage = {};
    MySQL.Async.fetchAll(string.format('SELECT * FROM %s', Query:GetSelectTable()), { }, function(result)
        if (result ~= nil) then
            table.insert(storage, result)
        end
    end)
    Citizen.Wait(100.0)
    return #storage, storage;
end

---Delete
---@param Column string
---@param Operator string
---@param Value string
---@return number
---@private
function Select:Delete(Column, Operator, Value)
    local count = 0;
    MySQL.Async.execute(string.format('DELETE FROM %s WHERE %s %s @value', Query:GetSelectTable(), Column, Operator), { ['@value'] = Value }, function(affectedRows)
        count = affectedRows
    end)
    Citizen.Wait(100.0)
    return count;
end

---GetWhereResult
---@return table
---@private
function Select:GetWhereResult()
    return self.whereStorage;
end

---Where
---@param Column string
---@param Operator string
---@param Value string
---@return Where
---@public
function Select:Where(Column, Operator, Value)
    self.whereStorage = {};
    MySQL.Async.fetchAll(string.format('SELECT * FROM %s WHERE %s %s @value', Query:GetSelectTable(), Column, Operator), { ['@value'] = Value }, function(result)
        if (result ~= nil) then
            table.insert(self.whereStorage, result)
        end
    end)
    Citizen.Wait(100.0)
    return Where;
end

---Update
---@param Content table
---@return void
---@public
function Where:Update(Content)
    if (self:Exists()) then
        local count = #Select:GetWhereResult();
        if (count > 1) then
            for key, value in pairs(Select:GetWhereResult()) do
                -- TODO Update multiple
            end
        else
            -- TODO Update one
        end
    else
        -- TODO Not exists throw error
    end
end

---Exists
---@return boolean
---@public
function Where:Exists()
    if (Select:GetWhereResult() ~= nil and #Select:GetWhereResult() >= 1) then
        return true;
    else
        return false;
    end
end

---Get
---@return any
---@public
function Where:Get()
    local result = Select:GetWhereResult();
    return #result, result;
end

MySQL.ready(function()

    --[[
    Query:Insert('players_settings', {
        uuid = 'sex',
        menus = json.encode({ test = true });
        keyboard_binds = json.encode({ test = true });
        approach = "Oui argent";
    })
    ]]--

    --local count, result = Query:Select('players_settings'):All()

    --local count, result = Query:Select('players_settings'):Where('uuid', '=', 'b7d4b94c-8581-440a-ab52-b442c8b6d3ea'):Get();

    --local exists = Query:Select('players_settings'):Where('uuid', '=', 'b7d4b94c-8581-440a-ab52-b442c8b6d3ea'):Exists();

    --local count = Query:Select('players_settings'):Delete('uuid', '=', 'sex')

    --[[
    Query:Select('players_settings'):Where('uuid', '=', 'b7d4b94c-8581-440a-ab52-b442c8b6d3ea'):Update({

    })
    ]]--
end)