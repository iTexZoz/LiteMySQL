---@class LiteMySQL
LiteMySQL = LiteMySQL or {};

---@class LiteMySQL.Helper
LiteMySQL.Helper = LiteMySQL.Helper or {};

---Query
---@public
---@return LiteMySQL.Select;
function LiteMySQL:Query(driver)
    LiteMySQL.Select.Driver = driver or 'mysql-async'
    return LiteMySQL.Select;
end

