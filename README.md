# LiteMySQL
Lite MySQL Is a MySQL Async LUA Query wrapper

# Insert

```lua
Query:Insert('players_settings', {
  uuid = 'sex',
  menus = json.encode({ test = true });
  keyboard_binds = json.encode({ test = true });
  approach = "Oui argent";
})
```

# Select all table

```lua
local count, result = Query:Select('players_settings'):All()
```

# Select All Where
```lua
local count, result = Query:Select('players_settings'):Where('uuid', '=', 'b7d4b94c-8581-440a-ab52-b442c8b6d3ea'):Get();
```

# Select Where Exists

```lua
local exists = Query:Select('players_settings'):Where('uuid', '=', 'b7d4b94c-8581-440a-ab52-b442c8b6d3ea'):Exists();
```

#Delete 

```lua
local count = Query:Select('players_settings'):Delete('uuid', '=', 'sex')
```

# Update Where
```lua

Query:Select('players_settings'):Where('uuid', '=', 'b7d4b94c-8581-440a-ab52-b442c8b6d3ea'):Update({
})
```
