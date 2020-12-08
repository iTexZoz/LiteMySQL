function LiteMySQL.Helper:Logs(timer, message)
    local Started = timer;
    print(string.format('[^2%s^7] [%s] [LiteMySQL] [^6%sms^7] :%s^7', os.date("%Y-%m-%d %H:%M:%S", os.time()), LiteMySQL.Select.Driver, string.gsub((Started - GetGameTimer()) + 100, '%-', ''), message))
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