---@class LiteMySQL.Where
LiteMySQL.Where = LiteMySQL.Where or {};

---Construct
---@return LiteMySQL.Result
---@public
function LiteMySQL.Where:Construct(table, column, operator, value)
    return LiteMySQL.Result:Construct(table, column, operator, value);
end
