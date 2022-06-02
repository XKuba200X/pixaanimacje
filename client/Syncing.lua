local isRequestAnim = false
local requestedemote = ''

-- Some of the work here was done by Super.Cool.Ninja / rubbertoe98
-- https://forum.fivem.net/t/release-nanimstarget/876709

-----------------------------------------------------------------------------------------------------
-- Commands / Events --------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
function GetNeareastPlayers()
    local playerPed = PlayerPedId()
    local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
    local players_clean = {}
    local found_players = false
    for i = 1, #players, 1 do
        found_players = true
        table.insert(players_clean, { player = players[i], playerName = GetPlayerName(players[i]), playerId = GetPlayerServerId(players[i]) })
    end
    return players_clean
end


    RegisterCommand('nearby', function(source, args, raw)
        if #args > 0 then
            local emotename = string.lower(args[1])
            local nearByPlayers = GetNeareastPlayers()

            local options = {}
            for k, v in pairs(nearByPlayers) do
                table.insert(options, {
                    label = v.playerName .. ' (' .. v.playerId .. ')', action = function()
                        ESX.UI.Menu.CloseAll()
                     
                        if DP.Shared[emotename] ~= nil then
                            dict, anim, ename = table.unpack(DP.Shared[emotename])
                            TriggerServerEvent("ServerEmoteRequest", v.playerId, GetPlayerServerId(PlayerId()),emotename)
                          
                            exports.pNotify:SendNotification({text = "Wysłałeś/aś propozycję <b>wspólnej emotki.</b> </br> <b>Odbiorca:</b> (" .. v.playerId .. ') ' ..  v.playerName .. '</br> <b>Animacja:</b> ' .. ename, type = "info", layout = "centerLeft", queue = "lmao", timeout = 7000})
                        else
                            exports.pNotify:SendNotification({text = "Nieprawidłowa emotka.", type = "info", layout = "centerLeft", queue = "lmao", timeout = 3500})
                        end
                    end })
            end
            local menu = {
                type = 'default',
                title = 'Wspólna emota',
                align = 'center',
                name = 'syncing_players',
                options = options
            }
            TriggerEvent('disc-base:openMenu', menu)
              
        else
          MearbysOnCommand()
        end
    end, false)








RegisterNetEvent("SyncPlayEmote")
AddEventHandler("SyncPlayEmote", function(emote, player)
    EmoteCancel()
    Wait(300)
    if DP.Shared[emote] ~= nil then
      if OnEmotePlay(DP.Shared[emote]) then end return
    elseif DP.Dances[emote] ~= nil then
      if OnEmotePlay(DP.Dances[emote]) then end return
    end
end)

RegisterNetEvent("SyncPlayEmoteSource")
AddEventHandler("SyncPlayEmoteSource", function(emote, player)
    -- Thx to Poggu for this part!
    local pedInFront = GetPlayerPed(GetClosestPlayer())
    local heading = GetEntityHeading(pedInFront)
    local coords = GetOffsetFromEntityInWorldCoords(pedInFront, 0.0, 1.0, 0.0)
    if (DP.Shared[emote]) and (DP.Shared[emote].AnimationOptions) then
      local SyncOffsetFront = DP.Shared[emote].AnimationOptions.SyncOffsetFront
      if SyncOffsetFront then
          coords = GetOffsetFromEntityInWorldCoords(pedInFront, 0.0, SyncOffsetFront, 0.0)
      end
    end
    local headingOffset = 180.1
    if DP.Shared[emote] and DP.Shared[emote].AnimationOptions and DP.Shared[emote].AnimationOptions.headingOffset then
        headingOffset = DP.Shared[emote].AnimationOptions.headingOffset
    end
        SetEntityHeading(PlayerPedId(), heading - headingOffset)
    SetEntityCoordsNoOffset(PlayerPedId(), coords.x, coords.y, coords.z, 0)
    EmoteCancel()
    Wait(300)
    if DP.Shared[emote] ~= nil then
      if OnEmotePlay(DP.Shared[emote]) then end return
    elseif DP.Dances[emote] ~= nil then
      if OnEmotePlay(DP.Dances[emote]) then end return
    end
end)


RegisterNetEvent('dpemotes:RequestFromEye')
AddEventHandler('dpemotes:RequestFromEye', function(entity)
    local emotename = 'bracie'
    local ped = GetPlayerPed(entity)
    local id = GetPlayerFromPed(entity)
      local server = GetPlayerServerId(id)

    if server == nil then
        exports.pNotify:SendNotification({text = "Wystąpił błąd!", type = "info", layout = "centerLeft", queue = "lmao", timeout = 3500})
    end

    if DP.Shared[emotename] ~= nil then
        if DP.Shared[emotename] ~= nil then
            _,_,_,otheremote = table.unpack(DP.Shared[emotename])
        elseif DP.Dances[emotename] ~= nil then
            _,_,_,otheremote = table.unpack(DP.Dances[emotename])
        end
        TriggerServerEvent("ServerEmoteRequest", server, GetPlayerServerId(PlayerId()),emotename)
        --TriggerServerEvent("ServerValidEmote", server, emotename, otheremote)

        exports.pNotify:SendNotification({text = "Wysłałeś/aś propozycję <b>wspólnej emotki.</b>", type = "info", layout = "centerLeft", queue = "lmao", timeout = 7000})
    else
        exports.pNotify:SendNotification({text = "Nieprawidłowa emotka.", type = "info", layout = "centerLeft", queue = "lmao", timeout = 3500})
    end

end)




local sender
RegisterNetEvent("ClientEmoteRequestReceive")
AddEventHandler("ClientEmoteRequestReceive", function(sent, emotename, etype)
    --isRequestAnim = true
    --print(requestedemote)
    sender = sent
    requestedemote = emotename
    --print(emotename)
    --print(sender)
 
    if DP.Shared[requestedemote] ~= nil then
        _,_,_,otheremote = table.unpack(DP.Shared[requestedemote])
    elseif DP.Dances[requestedemote] ~= nil then
        _,_,_,otheremote = table.unpack(DP.Dances[requestedemote])
    end

    local name =  GetPlayerFromServerId(sender)
    local name2 = GetPlayerName(name)
    ESX.UI.Menu.CloseAll()
    exports.pNotify:SendNotification({text = "Otrzymałeś/aś propozycję wspólnej emotki", type = "info", layout = "centerLeft", queue = "lmao", timeout = 7000})
    local elements = {}
    table.insert(elements, {label = "Wspólna emotka - propozycja", value = nil})
    table.insert(elements, {label = "<b>Nadawca:</b> (" .. sender .. ") " .. name2, value = nil})
    table.insert(elements, {label = "<b>Animacja:</b> " .. otheremote, value = nil})
    table.insert(elements, {label = '<span style="font-size: 70%";> ----------------------------- </span>', value = nil})
    table.insert(elements, {label = "Zaakceptuj", value = true})
    table.insert(elements, {label = "Odrzuć", value = false})
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dpemotes_emoterequest', {
        title    = 'Wspólna emotka <span style="font-size:30%;"> by matthew</span>',
        align    = 'center',
        elements = elements
    }, function(data, menu)
        local action = data.current.value
        if action ~= nil then
            if action == true then
                menu.close()
                TriggerServerEvent("ServerValidEmote", sender, requestedemote, otheremote)
            else
                menu.close()
                TriggerServerEvent("dpemotes:declineAnim", sender, GetPlayerServerId(PlayerId()))
            end
        else
            exports['mythic_notify']:SendAlert('black', 'Nie dotykaj tego! </br>Te okno jest tylko do podglądu.', 5000)
        end
    end, function(data, menu)
        menu.close()
    end)
end)





--[[
Citizen.CreateThread(function()
while true do
local time = 100
    if isRequestAnim then
        time = 1
        ESX.ShowHelpNotification("Naciśnij ~INPUT_MP_TEXT_CHAT_TEAM~ aby przyjąć wspólną emotkę \nNaciśnij ~INPUT_CELLPHONE_CAMERA_FOCUS_LOCK~ aby odrzucić")
        if IsControlJustPressed(1, 246)  then
        
            if DP.Shared[requestedemote] ~= nil then
                _,_,_,otheremote = table.unpack(DP.Shared[requestedemote])
            elseif DP.Dances[requestedemote] ~= nil then
                _,_,_,otheremote = table.unpack(DP.Dances[requestedemote])
            end
            if otheremote == nil then otheremote = requestedemote end
            TriggerServerEvent("ServerValidEmote", sender, requestedemote, otheremote)
            isRequestAnim = false
    elseif IsControlJustPressed(1, 182)then
        exports.pNotify:SendNotification({text = "Odrzuciłeś propozycję.", type = "info", layout = "centerLeft", queue = "lmao", timeout = 3000})
        isRequestAnim = false
    end
    end
Citizen.Wait(time)
end
end)]]



-----------------------------------------------------------------------------------------------------
------ Functions and stuff --------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

function GetPlayerFromPed(ped)
    for _,player in ipairs(GetActivePlayers()) do
        if GetPlayerPed(player) == ped then
            return player
        end
    end
    return -1
end

function GetPedInFront()
    local player = PlayerId()
    local plyPed = GetPlayerPed(player)
    local plyPos = GetEntityCoords(plyPed, false)
    local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.3, 0.0)
    local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, 10.0, 12, plyPed, 7)
    local _, _, _, _, ped2 = GetShapeTestResult(rayHandle)
    return ped2
end

function MearbysOnCommand(source, args, raw)
  local NearbysCommand = ""
  for a in pairsByKeys(DP.Shared) do
    NearbysCommand = NearbysCommand .. ""..a..", "
  end
  EmoteChatMessage(NearbysCommand)
  EmoteChatMessage(Config.Languages[lang]['emotemenucmd'])
end

function SimpleNotify(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(0,1)
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end