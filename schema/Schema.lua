---@class LiteMySQL.Schema
LiteMySQL.Schema = LiteMySQL.Schema or {}

---table
---@param table string
---@param blueprint fun(table:string, function:string)
function LiteMySQL.Schema:table(table, blueprint)
    blueprint(LiteMySQL.Schema);
end

