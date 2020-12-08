---@class LiteMySQL.Select
LiteMySQL.Select = LiteMySQL.Select or {};

---@type string
LiteMySQL.Select.Driver = 'mysql-async';

---Select
---@param table string
---@return LiteMySQL.Select
---@public
function LiteMySQL.Select:Select(table)
    self.table = table;
    return LiteMySQL.Select;
end

---Where
---@param column string
---@param operator string
---@param value any
---@public
---@return LiteMySQL.Result
function LiteMySQL.Select:Where(column, operator, value)
    return LiteMySQL.Where:Construct(self.table, column, operator, value)
end

---Wheres
---@param table table
---@public
function LiteMySQL.Select:Wheres(table)

end

---Insert
---@param content table
---@public
---@return void
function LiteMySQL.Select:Insert(content)
    local fields = "";
    local keys = "";
    for key, _ in pairs(content) do
        fields = string.format('%s`%s`,', fields, key)
        key = string.format('@%s', key)
        keys = string.format('%s%s,', keys, key)
    end
    return LiteMySQL.Helper:execute(string.format("INSERT INTO %s (%s) VALUES (%s)", self.table, string.sub(fields, 1, -2), string.sub(keys, 1, -2)), content);
end

---Count
---@public
function LiteMySQL.Select:Count()
    local query = LiteMySQL.Helper:fetchAll(string.format('SELECT COUNT(*) FROM %s', self.table), {});
    if (query ~= nil) and (query[1] ~= nil) and (query[1]["COUNT(*)"] ~= nil) then
        return query[1]["COUNT(*)"];
    else
        return false;
    end
end