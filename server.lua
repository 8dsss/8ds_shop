ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('8ds:shop')
AddEventHandler('8ds:shop', function(ITEM,price)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then
        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem(ITEM, 1)
        TriggerClientEvent('esx:showNotification', source, "Votre achat a était effectué !")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez d\'argent")
    end
end)