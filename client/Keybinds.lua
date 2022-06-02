local emob1 = ""
local emob2 = ""
local emob3 = ""
local emob4 = ""
local emob5 = ""
local emob6 = ""
local keyb1 = ""
local keyb2 = ""
local keyb3 = ""
local keyb4 = ""
local keyb5 = ""
local keyb6 = "" 
local Initialized = false

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)



RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(newData)
    PlayerData = newData

    Citizen.Wait(5000)
    TriggerServerEvent("dp:ServerKeybindExist")
    --[[ESX.TriggerServerCallback('dp:getWalk', function(wartosc)
        if wartosc['hotbar'] ~= nil then
            exports['inventory']:UpdateHotbar(json.decode(wartosc['hotbar']))
        end
        if wartosc['walk'] ~= nil then
          print('Styl chodzenia został zaktualizowany ze względu na wejście na serwer: ' .. wartosc['walk'])
          ExecuteCommand('walk ' .. wartosc['walk'])
        else
          print('brak stylu')
        end
      end)]]
end)



RegisterNetEvent('dpemotes:updateHotBarAndWalk')
AddEventHandler('dpemotes:updateHotBarAndWalk',function(walk, hotbar)
  Wait(5000)
  ExecuteCommand('walk ' .. walk)
  print(ESX.DumpTable(hotbar))
  if hotbar then
   
  exports['inventory']:UpdateHotbar(hotbar)
  end
  print('zaktualizowany styl chodzenia: ' .. walk)
  print('Hotbar oraz styl chodzenia zostaly zaktualizowane')
end)



-----------------------------------------------------------------------------------------------------
-- Commands / Events --------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------



for k, v in pairs(Config.KeybindKeys) do
    RegisterCommand('+' .. v[1], function()
 
        if k == keyb1 then if emob1 ~= "" then EmoteCommandStart(nil,{emob1, 0}) end end
        if k == keyb2 then if emob2 ~= "" then EmoteCommandStart(nil,{emob2, 0}) end end
        if k == keyb3 then if emob3 ~= "" then EmoteCommandStart(nil,{emob3, 0}) end end
        if k == keyb4 then if emob4 ~= "" then EmoteCommandStart(nil,{emob4, 0}) end end
        if k == keyb5 then if emob5 ~= "" then EmoteCommandStart(nil,{emob5, 0}) end end
        if k == keyb6 then if emob6 ~= "" then EmoteCommandStart(nil,{emob6, 0}) end end
        Wait(1000)
        end, false)
    RegisterKeyMapping('+' .. v[1], 'Animacja ' .. k .. '~', 'keyboard', v[1])
end




function ShowBinds()
    --print(emob1)
        local elements = {}
        table.insert(elements, {label = '<span style="font-size:75%;"> Aby zbindować animację wystarczy użyć komendy /emotebind [num4-9] [emotka]</span>', value = 'anim_przypisane'})
        table.insert(elements, {label = '---------------------------------------------------', value = nil})
                if emob1 ~= "" then
                    table.insert(elements, {label = '1. ' .. emob1, value = emob1})
                else
                    table.insert(elements, {label = '1. Brak', value = nil})
                end
                if emob2 ~= "" then
                    table.insert(elements, {label = '2. ' .. emob2, value = emob2})
                else
                    table.insert(elements, {label = '2. Brak', value = nil})
                end
                if emob3 ~= "" then
                    table.insert(elements, {label = '3. ' .. emob3, value = emob3})
                else
                    table.insert(elements, {label = '3. Brak', value = nil})
                end
                if emob4 ~= "" then
                    table.insert(elements, {label = '4. ' .. emob4, value = emob4})
                else
                    table.insert(elements, {label = '4. Brak', value = nil})
                end
                if emob5 ~= "" then
                    table.insert(elements, {label = '5. ' .. emob5, value = emob5})
                else
                    table.insert(elements, {label = '5. Brak', value = nil})
                end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "binds", {
            title = 'Aktualne bindy',
            align = 'center',
            elements = elements
        }, function(data, menu)
            if data.current.value == nil then
                exports.pNotify:SendNotification({text = "Brak animacji! Przypisz ją za pomocą komendy /emotebind", type = "info", layout = "centerLeft", queue = "lmao", timeout = 2500})
                return
            end
            if data.current.value ~= nil then
                ExecuteCommand('e ' .. data.current.value)
            end
        end, function(data, menu)
            menu.close()
        end)
end

RegisterCommand('bindy', function()
    ShowBinds()
end)




RegisterNetEvent("dp:ClientKeybindExist")
AddEventHandler("dp:ClientKeybindExist", function(does)
    if does then
    	TriggerServerEvent("dp:ServerKeybindGrab")
    else
    	TriggerServerEvent("dp:ServerKeybindCreate")
    end
end)

RegisterNetEvent("dp:ClientKeybindGet")
AddEventHandler("dp:ClientKeybindGet", function(k1, e1, k2, e2, k3, e3, k4, e4, k5, e5, k6, e6)
    keyb1 = k1 emob1 = e1 keyb2 = k2 emob2 = e2 keyb3 = k3 emob3 = e3 keyb4 = k4 emob4 = e4 keyb5 = k5 emob5 = e5 keyb6 = k6 emob6 = e6
    Initialized = true
    if walk ~= nil then
        ExecuteCommand('walk ' .. walk)
    end
end)

RegisterNetEvent("dp:ClientKeybindGetOne")
AddEventHandler("dp:ClientKeybindGetOne", function(key, e)
    --SimpleNotify(Config.Languages[lang]['bound'].."~y~"..e.."~w~ "..Config.Languages[lang]['to'].." ~g~"..firstToUpper(key).."~w~")
	if key == "num4" then emob1 = e keyb1 = "num4" elseif key == "num5" then emob2 = e keyb2 = "num5" elseif key == "num6" then emob3 = e keyb3 = "num6" elseif key == "num7" then emob4 = e keyb4 = "num7" elseif key == "num8" then emob5 = e keyb5 = "num8" elseif key == "num9" then emob6 = e keyb6 = "num9" end
end)

-----------------------------------------------------------------------------------------------------
------ Functions and stuff --------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

function EmoteBindsStart()
    EmoteChatMessage(Config.Languages[lang]['currentlyboundemotes'].."\n"
        ..firstToUpper(keyb1).." = '^2"..emob1.."^7'\n"
        ..firstToUpper(keyb2).." = '^2"..emob2.."^7'\n"
        ..firstToUpper(keyb3).." = '^2"..emob3.."^7'\n"
        ..firstToUpper(keyb4).." = '^2"..emob4.."^7'\n"
        ..firstToUpper(keyb5).." = '^2"..emob5.."^7'\n"
        ..firstToUpper(keyb6).." = '^2"..emob6.."^7'\n")
end

function EmoteBindStart(source, args, raw)
    if #args > 0 then
        local key = string.lower(args[1])
        local emote = string.lower(args[2])
        print(key)
        if (Config.KeybindKeys[key]) ~= nil then
        	if DP.Emotes[emote] ~= nil then
          		TriggerServerEvent("dp:ServerKeybindUpdate", key, emote)
                  if key == 'num4' then
                    emob1 =  emote
                  elseif key == 'num5' then
                    emob2 =  emote
                  elseif key == 'num6' then
                    emob3 =  emote
                  elseif key == 'num7' then
                    emob4 =  emote
                  elseif key == 'num8' then
                    emob5 =  emote
                  elseif key == 'num9' then
                    emob6 =  emote
                  end
        	elseif DP.Dances[emote] ~= nil then
          		TriggerServerEvent("dp:ServerKeybindUpdate", key, emote)
                  if key == 'num4' then
                    emob1 =  emote
                  elseif key == 'num5' then
                    emob2 =  emote
                  elseif key == 'num6' then
                    emob3 =  emote
                  elseif key == 'num7' then
                    emob4 =  emote
                  elseif key == 'num8' then
                    emob5 =  emote
                  elseif key == 'num9' then
                    emob6 =  emote
                  end
        	elseif DP.PropEmotes[emote] ~= nil then
          		TriggerServerEvent("dp:ServerKeybindUpdate", key, emote)
                  if key == 'num4' then
                    emob1 =  emote
                  elseif key == 'num5' then
                    emob2 =  emote
                  elseif key == 'num6' then
                    emob3 =  emote
                  elseif key == 'num7' then
                    emob4 =  emote
                  elseif key == 'num8' then
                    emob5 =  emote
                  elseif key == 'num9' then
                    emob6 =  emote
                  end
        	else
          		EmoteChatMessage("'"..emote.."' "..Config.Languages[lang]['notvalidemote'].."")
        	end
        else
        	EmoteChatMessage("'"..key.."' "..Config.Languages[lang]['notvalidkey'])
        end
    else
        print("invalid")
    end
end
