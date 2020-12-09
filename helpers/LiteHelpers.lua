function LiteMySQL.Helper:Logs(timer, message)
    local Started = timer;
    print(string.format('[^2%s^7] [%s] [LiteMySQL] [^6%sms^7] :%s^7', os.date("%Y-%m-%d %H:%M:%S", os.time()), LiteMySQL.Select.Driver, string.gsub((Started - GetGameTimer()) + 100, '%-', ''), message))
end

function LiteMySQL.Helper:ParseWheres(conditions)
    local keys = "";
    local args = {};
    for _, value in pairs(conditions) do
        keys = string.format("%s `%s` %s @%s AND ", keys, value.column, value.operator, value.column)
        args[string.format('@%s', value.column)] = value.value;
    end
    return args, string.sub(keys, 1, -5);
end

---fetchAll
---@param query string
---@param args table
---@public
function LiteMySQL.Helper:fetchAll(query, args)
    local timer = GetGameTimer();
    local storage;
    local driver = {
        ['vSql'] = vSql.Async.fetchAll,
        ['mysql-async'] = MySQL.Async.fetchAll,
    }
    if (driver[LiteMySQL.Select.Driver]) then
        driver[LiteMySQL.Select.Driver](query, args, function(result)
            if (result ~= nil) then
                storage = result;
            else
                storage = false;
            end
        end)
        while (storage == nil) do
            Citizen.Wait(1.0)
        end
        LiteMySQL.Helper:Logs(timer, string.format('^5 %s [%s]', query, json.encode(args)))
        return storage;
    else
        error(string.format("Fatal errors occurred, driver [%s] is not supported by LiteMySQL.", LiteMySQL.Select.Driver))
    end
end

function LiteMySQL.Helper:execute(query, args)
    local timer = GetGameTimer();
    local storage;
    local driver = {
        ['vSql'] = vSql.Async.execute,
        ['mysql-async'] = MySQL.Async.execute,
    }
    if (driver[LiteMySQL.Select.Driver]) then
        driver[LiteMySQL.Select.Driver](query, args, function(affectedRows)
            if (affectedRows ~= nil) then
                storage = affectedRows;
            else
                storage = false;
            end
        end)
        while (storage == nil) do
            Citizen.Wait(1.0)
        end
        LiteMySQL.Helper:Logs(timer, string.format('^5 %s [%s]', query, json.encode(args)))
        return storage;
    else
        error(string.format("Fatal errors occurred, driver [%s] is not supported by LiteMySQL.", LiteMySQL.Select.Driver))
    end
end