---@class LiteMySQL.Result
LiteMySQL.Result = LiteMySQL.Result or {};

---Construct
---@param table string
---@param column string
---@param operator string
---@param value table
---@public
---@return LiteMySQL.Result
function LiteMySQL.Result:Construct(table, column, operator, value)
    self.table = table;
    self.column = column;
    self.operator = operator;
    self.value = value;
    return LiteMySQL.Result;
end

---Get
---@public
---@return table<number, table>
function LiteMySQL.Result:Get()
    local response = LiteMySQL.Helper:fetchAll(string.format('SELECT * FROM %s WHERE %s %s @value', self.table, self.column, self.operator), { ['@value'] = self.value })
    if (response ~= false) then
        return #response, response;
    else
        return false, false;
    end
end

---First
---@public
---@return table<table>
function LiteMySQL.Result:First()
    local response = LiteMySQL.Helper:fetchAll(string.format('SELECT * FROM %s WHERE %s %s @value', self.table, self.column, self.operator), { ['@value'] = self.value })
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
    local query = LiteMySQL.Helper:fetchAll(string.format('SELECT COUNT(*) FROM %s WHERE %s %s @value', self.table, self.column, self.operator), { ['@value'] = self.value });
    if (query ~= nil) and (query[1] ~= nil) and (query[1]["COUNT(*)"] ~= nil) then
        return query[1]["COUNT(*)"];
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


