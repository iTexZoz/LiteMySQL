---@class LiteMySQL.Result
LiteMySQL.Result = LiteMySQL.Result or {};

---Where
---@param table string
---@param column string
---@param operator string
---@param value table
---@public
---@return LiteMySQL.Result
function LiteMySQL.Result:Where(table, column, operator, value)
    self.table = table;
    self.column = column;
    self.operator = operator;
    self.value = value;
    self.conditions = false;
    return LiteMySQL.Result;
end

---Where
---@param table string
---@param conditions table<string, string, any>
---@public
---@return LiteMySQL.Result
function LiteMySQL.Result:Wheres(table, conditions)
    self.table = table;
    self.conditions = conditions;
    return LiteMySQL.Result;
end

---Get
---@public
---@return table<number, table>
function LiteMySQL.Result:Get()
    local response
    if not (self.conditions) then
        response = LiteMySQL.Helper:fetchAll(string.format('SELECT * FROM %s WHERE %s %s @value', self.table, self.column, self.operator), { ['@value'] = self.value })
    else
        local args, keys = LiteMySQL.Helper:ParseWheres(self.conditions);
        response = LiteMySQL.Helper:fetchAll(string.format('SELECT * FROM %s WHERE %s', self.table, keys), args)
    end
    if (response ~= nil) and (response ~= false) then
        return #response, response;
    else
        return 0, nil;
    end
end

---First
---@public
---@return table<table>
function LiteMySQL.Result:First()
    local response
    if not (self.conditions) then
        response = LiteMySQL.Helper:fetchAll(string.format('SELECT * FROM %s WHERE %s %s @value LIMIT 1', self.table, self.column, self.operator), { ['@value'] = self.value })
    else
        local args, keys = LiteMySQL.Helper:ParseWheres(self.conditions);
        response = LiteMySQL.Helper:fetchAll(string.format('SELECT * FROM %s WHERE %s LIMIT 1', self.table, keys), args)
    end
    if (response ~= false) and (response[1] ~= nil) then
        return response[1];
    else
        return false;
    end
end

---Count
---@public
---@return number
function LiteMySQL.Result:Count()
    local response
    if not (self.conditions) then
        response = LiteMySQL.Helper:fetchAll(string.format('SELECT COUNT(*) FROM %s WHERE %s %s @value', self.table, self.column, self.operator), { ['@value'] = self.value })
    else
        local args, keys = LiteMySQL.Helper:ParseWheres(self.conditions);
        response = LiteMySQL.Helper:fetchAll(string.format('SELECT COUNT(*) FROM %s WHERE %s', self.table, keys), args)
    end
    if (response ~= nil) and (response[1] ~= nil) and (response[1]["COUNT(*)"] ~= nil) then
        return response[1]["COUNT(*)"];
    else
        return false;
    end
end

---Exists
---@public
---@return boolean
function LiteMySQL.Result:Exists()
    local count = self:Count();
    return count ~= false and count ~= 0 and true or false or false;
end

---Delete
---@public
---@return number
function LiteMySQL.Result:Delete()
    return LiteMySQL.Helper:execute(string.format('DELETE FROM %s WHERE %s %s @value', self.table, self.column, self.operator), { ['@value'] = self.value });
end

---Update
---@param content table<string, any>
---@public
---@return number
function LiteMySQL.Result:Update(content)
    local keys = "";
    local args = {};
    for key, value in pairs(content) do
        keys = string.format("%s`%s` = @%s, ", keys, key, key)
        args[string.format('@%s', key)] = value;
    end
    keys = string.format("%s`%s` = @%s, ", keys, 'updated_at', 'updated_at')
    args[string.format('@%s', 'updated_at')] = os.date("%Y-%m-%d %H:%M:%S", os.time());
    args['@value'] = self.value;
    return LiteMySQL.Helper:execute(string.format("UPDATE %s SET %s WHERE %s %s @value", self.table, string.sub(keys, 1, -3), self.column, self.operator, self.value), args);
end

---CreateOrGet
---@param content table<string, any>
---@public
---@return table<number, any>
function LiteMySQL.Result:CreateOrGet(content)
    local count, result = self:Get()
    if (count > 0) then
        return count, result;
    else
        local fields = "";
        local keys = "";
        for key, _ in pairs(content) do
            fields = string.format('%s`%s`,', fields, key)
            key = string.format('@%s', key)
            keys = string.format('%s%s,', keys, key)
        end
        local isSuccess = LiteMySQL.Helper:execute(string.format("INSERT INTO %s (%s) VALUES (%s)", self.table, string.sub(fields, 1, -2), string.sub(keys, 1, -2)), content);
        if (isSuccess) then
            return 1, content;
        else
            return 0, nil;
        end
    end
end

---CreateOrUpdate
---@param content table<string, any>
---@public
---@return void
function LiteMySQL.Result:CreateOrUpdate(content)
    local exists = self:Exists();
    if (exists) then
        self:Update(content);
    else
        LiteMySQL:Query(LiteMySQL.Select.Driver):Select(self.table):Insert(content);
    end
end
