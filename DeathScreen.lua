local isUIActive = false
local deathTime = 0
local timeLeft = Config.DeathTimer

RegisterCommand(Config.ShowUICommand, function()
    TriggerEvent('deathscreen:showUI')
end, false)

RegisterCommand(Config.HideUICommand, function()
    TriggerEvent('deathscreen:hideUI')
end, false)

RegisterNetEvent('deathscreen:showUI')
AddEventHandler('deathscreen:showUI', function()
    if not isUIActive then
        isUIActive = true
        deathTime = GetGameTimer()
        timeLeft = Config.DeathTimer
        SendNUIMessage({
            action = "showDeathScreen",
            timeLeft = timeLeft
        })
        SetNuiFocus(true, true)
    end
end)

RegisterNetEvent('deathscreen:hideUI')
AddEventHandler('deathscreen:hideUI', function()
    if isUIActive then
        isUIActive = false
        SendNUIMessage({
            action = "hideDeathScreen"
        })
        SetNuiFocus(false, false)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if isUIActive then
            local timePassed = (GetGameTimer() - deathTime) / 1000
            timeLeft = math.max(0, Config.DeathTimer - timePassed)
            SendNUIMessage({
                action = "updateTimer",
                timeLeft = math.ceil(timeLeft)
            })
        end
    end
end)