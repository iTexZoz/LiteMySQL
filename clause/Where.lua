---@class LiteMySQL.Where
LiteMySQL.Where = LiteMySQL.Where or {};

---@class LiteMySQL.Wheres
LiteMySQL.Wheres = LiteMySQL.Wheres or {};

---Construct
---@return LiteMySQL.Result
---@public
function LiteMySQL.Where:Construct(table, column, operator, value)
    return LiteMySQL.Result:Where(table, column, operator, value);
end

---Construct
---@return LiteMySQL.Result
---@public
function LiteMySQL.Wheres:Construct(table, conditions)
    return LiteMySQL.Result:Wheres(table, conditions);
end
