ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("familymake:bigsocities")
AddEventHandler("familymake:bigsocities", function(gangname)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local MafiaPayment = xPlayer.getAccount("black_money").money
    local society = "society_"..gangname
    
    MySQL.Async.execute('INSERT INTO addon_account (name, label, shared) VALUES (@name, @label, @shared)',
        {
            ['@name'] = society,
            ['@label'] = gangname,
            ['@shared'] = 1
        }
    )

        MySQL.Async.execute('INSERT INTO addon_inventory (name, label, shared) VALUES (@name, @label, @shared) ',
        {
            ['@name'] = society,
            ['@label'] = gangname,
            ['@shared'] = 1
        }
    )

    MySQL.Async.execute('INSERT INTO datastore (name, label, shared) VALUES (@name, @label, @shared) ',
        {
            ['@name'] = society,
            ['@label'] = gangname,
            ['@shared'] = 1
        }
    )


end) 



RegisterServerEvent("createfam:family")
AddEventHandler("createfam:family", function(gangname, type)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.execute('INSERT INTO gangs (name, label, experience, level, type) VALUES (@name, @label, @experience, @level, @type)',
        {
            ['@name'] = gangname,
            ['@label'] = gangname,
            ['@experience'] = 0,
            ['@level'] = 1,
            ['@type'] = type,
        }
    )

    --[[local identifier = GetPlayerIdentifiers(source)[1]

    MySQL.Sync.execute('UPDATE users SET gang = @gang WHERE identifier = @identifier', {
		['@identifier'] = identifier,
		['@gang'] = gangname
	})
    MySQL.Sync.execute('UPDATE users SET gang_grade = @gang_grade WHERE identifier = @identifier', {
		['@identifier'] = identifier,
		['@gang_grade'] = 3
	})--]]
end)

RegisterServerEvent("Familygrades:ganggrades")
AddEventHandler("Familygrades:ganggrades", function(gangname)
   
    MySQL.Async.execute('INSERT INTO gang_grades (gang_name, grade, name, label, salary, skin_male, skin_female) VALUES (@gang_name, @grade, @name, @label, @salary, @skin_male, @skin_female)',
    {
        ['@gang_name'] = gangname,
        ['@grade'] = "1", 
        ['@name'] = "level1",
        ['@label'] = gangname,
        ['@salary'] = "300",
        ['@skin_male'] = "{}",
        ['@skin_female'] = "{}"
    })

    MySQL.Async.execute('INSERT INTO gang_grades (gang_name, grade, name, label, salary, skin_male, skin_female) VALUES (@gang_name, @grade, @name, @label, @salary, @skin_male, @skin_female)',
    {
        ['@gang_name'] = gangname,
        ['@grade'] = "2", 
        ['@name'] = "level2",
        ['@label'] = gangname,
        ['@salary'] = "300",
        ['@skin_male'] = "{}",
        ['@skin_female'] = "{}"
    })

    MySQL.Async.execute('INSERT INTO gang_grades (gang_name, grade, name, label, salary, skin_male, skin_female) VALUES (@gang_name, @grade, @name, @label, @salary, @skin_male, @skin_female)',
    {
        ['@gang_name'] = gangname,
        ['@grade'] = "3", 
        ['@name'] = "level3",
        ['@label'] = gangname,
        ['@salary'] = "350",
        ['@skin_male'] = "{}",
        ['@skin_female'] = "{}"
    })

    MySQL.Async.execute('INSERT INTO gang_grades (gang_name, grade, name, label, salary, skin_male, skin_female) VALUES (@gang_name, @grade, @name, @label, @salary, @skin_male, @skin_female)',
    {
        ['@gang_name'] = gangname,
        ['@grade'] = "4", 
        ['@name'] = "level4",
        ['@label'] = gangname,
        ['@salary'] = "500",
        ['@skin_male'] = "{}",
        ['@skin_female'] = "{}"
    })

end)

RegisterServerEvent('createFamily:setplayercreatedjob')
AddEventHandler('createFamily:setplayercreatedjob', function(gangjob, grade)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.setGang(gangjob, grade)
end)

RegisterServerEvent('createFamily:leavefamily')
AddEventHandler('createFamily:leavefamily', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.setGang('nogang', 0)
end)


RegisterServerEvent('createFamily:deletefamily')
AddEventHandler('createFamily:deletefamily', function(gangname)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.setGang('nogang', 0)

    MySQL.Async.execute('DELETE from gangs WHERE name = @name', {
        ['@name'] = gangname
    })

    MySQL.Async.execute('DELETE from gang_grades WHERE gang_name = @gang_name', {
        ['@gang_name'] = gangname
    })

    MySQL.Async.execute('DELETE from addon_account WHERE label = @label', {
        ['@label'] = gangname
    })

    MySQL.Async.execute('DELETE from addon_inventory WHERE label = @label', {
        ['@label'] = gangname
    })

    MySQL.Async.execute('DELETE from datastore WHERE label = @label', {
        ['@label'] = gangname
    })


end)

ESX.RegisterServerCallback('family:canhecreate', function(src, cb, gangname)
    MySQL.Async.fetchAll('SELECT * FROM `gangs` WHERE `name` = @name', 
    {
        ['@name'] = gangname
    }, function(result)
        if result[1] then
            if result[1].name then
                cb(false)
                TriggerClientEvent('esx:showNotification', src, '~r~Error: ~w~There\'s already a mafia with the same name.')
            else
                cb(true)
            end
        else
            cb(true)
        end
    end)
end)


ESX.RegisterServerCallback('hasmoney:create', function(src, cb, howmuch)
    local player = ESX.GetPlayerFromId(src)
    local xp = player.getAccount(Config.accounttype).money
    if xp >= howmuch then
        cb(true)
        player.removeAccountMoney(Config.accounttype, howmuch)
    else
        cb(false)
    end
end)


ESX.RegisterServerCallback('exp:exp', function(src, cb)
    local player = ESX.GetPlayerFromId(src)
    local xp = player.getAccount(Config.accounttype).money
    cb(xp)
end)


RegisterCommand("0black", function(src)
    local source = src
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.setAccountMoney('black_money', 0)
end, false)