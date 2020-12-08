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

---Count
---@public
function LiteMySQL.Select:Count()

end

---Insert
---@param content table
---@public
function LiteMySQL.Select:Insert(content)

end
