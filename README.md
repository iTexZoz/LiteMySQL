# Official Sponsor :

[![PrivateHeberg](https://rageui.riveria.fr/ph.png)](https://privateheberg.com)
I would like to make an announcement about the official partners of my projects.

Today, I offer you the possibility to buy different virtual servers (VPS) LXC or KVM (Linux or Windows) via PrivateHeberg.net.

The perfect solution for the conception / realisation of your projects.

Let me point out that Privateheberg uses professional protection against DDOS attacks (VAC TILERA) in addition to the private protection provided by PrivateHeberg.

A discount code of 8% is valid on all products on the site for a period of 3 months. (valid for renewals) 

### PrivateHeberg is not a waste hosting company, it does not use a shitty technology like WHMCS or WorldPress. 

I personally recommend NvME products (LXC / KVM) 

https://privateheberg.net/

Discount code : <code>PACO</code> (-8%)

# LiteMySQL
Lite MySQL Is a MySQL Async LUA Query wrapper

you need mysql-async,

and created_at / updated_at field in datetime

# Insert

```lua
Query:Insert('players_settings', {
  uuid = 1,
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

# Delete 

```lua
local count = Query:Select('players_settings'):Delete('uuid', '=', 1)
```

# Update Where
```lua

Query:Select('players_settings'):Where('uuid', '=', 'b7d4b94c-8581-440a-ab52-b442c8b6d3ea'):Update({
})
```


```lua
        local count, result = LiteMySQL:Select('players'):Wheres({
            { column = 'identifier', operator = '=', value = 'discord:109464193056423936' },
            { column = 'is_active', operator = '=', value = true },
        }):Get();

             LiteMySQL:Insert('players_settings', {
                 uuid = 1,
                 menus = json.encode({ style = "RageUI", sound = "RageUI" });
                 keyboard_binds = json.encode({});
                 approach = json.encode({});
             })
             Citizen.Wait(2000)
             LiteMySQL:Select('players_settings'):Where('uuid', '=', 'sex'):Update({
                 menus = json.encode({ style = 'xxxx', sound = 'RageUI' })
             })

             local affectedRows = LiteMySQL:Update('players_settings', 'uuid', '=', 'sex', {
                 menus = json.encode({ style = 'SS', sound = 'RageUI' })
             });

             LiteMySQL:Insert('players_settings', {
                 uuid = 1,
                 menus =  json.encode({ style = "RageUI", sound = "RageUI" });
                 keyboard_binds =json.encode({});
                 approach = json.encode({});
             })

             LiteMySQL:Select('players_settings'):Where('uuid', '=', 'sex'):Update({
                 menus = json.encode({ style = 'xxxx', sound = 'RageUI' })
             })

             local count, result = LiteMySQL:Select('players_settings'):All()

             local count, result = LiteMySQL:Select('players_settings'):Where('uuid', '=', 'b7d4b94c-8581-440a-ab52-b442c8b6d3ea'):Get();

             local exists = LiteMySQL:Select('players_settings'):Where('uuid', '=', 'b7d4b94c-8581-440a-ab52-b442c8b6d3ea'):Exists();

             local count = LiteMySQL:Select('players_settings'):Delete('uuid', '=', 'sex')

             LiteMySQL:Select('players_settings'):Where('uuid', '=', 'b7d4b94c-8581-440a-ab52-b442c8b6d3ea'):Update({

             })
             local count = LiteMySQL:Select('players_settings'):Delete('uuid', '=', 'sex')
             local count, result = LiteMySQL:Select('items'):All()

             local insertedID = LiteMySQL:Insert('items', {
                 label = 'Label test',
                 name = 'name test',
                 limit = 20,
                 weight = 200,
             })
```
