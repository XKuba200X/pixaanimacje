-- You probably shouldnt touch these.

local AnimationDuration = -1

local ChosenAnimation = ""

local ChosenDict = ""

local IsInAnimation = false

local MostRecentChosenAnimation = ""

local MostRecentChosenDict = ""

local MovementType = 0

local PlayerGender = "male"

local PlayerHasProp = false

local PlayerProps = {}

local PlayerParticles = {}

local SecondPropEmote = false

local lang = Config.MenuLanguage

local PtfxNotif = false

local PtfxPrompt = false

local PtfxWait = 500

local lastAnimName = nil

local PtfxNoProp = false

local firstTime = true

local time = 500

local droppingItem = false

Citizen.CreateThread(function()

  while true do

    Citizen.Wait(5)

    if IsInAnimation then

      local ped = PlayerPedId()

        if IsPedShooting(ped) then

        EmoteCancel()

        end

    else

      Citizen.Wait(500)

    end



  end

end)



RegisterCommand('+cancel', function()

  EmoteCancel()

end, false)



RegisterKeyMapping('+cancel', 'Przerwanie animacji~', 'keyboard', 'DELETE')







RegisterCommand('animedit', function()

  if not IsInAnimation then

    exports['mythic_notify']:SendAlert('black', 'Musisz być podczas animacji!', 2500)

    return

  end

  EditPosition()

end, false)



local editingPos = false

local lastCoords = nil

function EditPosition()

  local ped = PlayerPedId()

  lastCoords = GetEntityCoords(ped)

  local heading = GetEntityHeading(ped)

  local coords = GetEntityCoords(ped)

  local newPos = GetEntityCoords(ped)

  local yoff = 0.0

			local zoff = 0.0

      if editingPos then

        exports['mythic_notify']:SendAlert('black', 'Już jesteś podczas edycji animacji!', 2500)

        return

      end

      local accepted = false

      editingPos = true

      

      FreezeEntityPosition(ped, true)

while editingPos do

  Wait(5)

  ESX.ShowHelpNotification('~INPUT_MOVE_UP_ONLY~ ~INPUT_MOVE_DOWN_ONLY~ \n~INPUT_COVER~ ~INPUT_MULTIPLAYER_INFO~\n~INPUT_MOVE_LEFT_ONLY~ ~INPUT_MOVE_RIGHT_ONLY~\nABY MANIPULOWAĆ\n\n~INPUT_ENTER~ ABY ZATWIERDZIĆ POZYCJE')

  if IsDisabledControlPressed(0, 32) then

    yoff = 0.05;

  end

			SetEntityInvincible(ped, true)

  if IsDisabledControlPressed(0, 33) then

    yoff = -0.05;

  end



  if IsDisabledControlPressed(0, 44) then

    zoff = 0.02;

  end



  if IsDisabledControlPressed(0, 20) then

    zoff = -0.02;

  end



  if IsDisabledControlPressed(0, 23) then

    accepted = true

    editingPos = false

  end



  if IsDisabledControlPressed(0, 34) then

    SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId()) + 2.0)

  end



  if IsDisabledControlPressed(0, 35) then

    SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId()) - 2.0)

  end

  

  newPos = GetOffsetFromEntityInWorldCoords(ped, 0.0, yoff, zoff)

  if (yoff ~= 0.0 or zoff ~= 0.0) then

  SetEntityCoordsNoOffset(ped, newPos.x, newPos.y, newPos.z, 1, 0, 1)

     if not IsEntityPlayingAnim(ped, ChosenDict, ChosenAnimation, 3) then

      OnEmotePlay(lastAnimName)

   end

  end

  yoff = 0.0

  zoff = 0.0

end



if accepted then

  local crds = GetEntityCoords(PlayerPedId())

  --SetEntityCoordsNoOffset(ped, newPos.x, newPos.y, newPos.z, 0, 0, 0)

  SetEntityCoords(ped, crds.x, crds.y, crds.z - 0.97, 0)

  FreezeEntityPosition(ped, true)



  while accepted do

    Wait(5)

    ESX.ShowHelpNotification('~INPUT_PICKUP~ ABY ANULOWAĆ EDYCJE ANIMACJI')

    local ped = PlayerPedId()

    if not IsEntityPlayingAnim(ped, ChosenDict, ChosenAnimation, 3) then

      OnEmotePlay(lastAnimName)

   end

    if IsDisabledControlPressed(0, 38) then

      accepted = false

    end

     

  end

  local ped = PlayerPedId()

  FreezeEntityPosition(ped, false)

  SetPlayerInvincible(ped, false)

  local health = GetEntityHealth(ped)

  SetEntityCoords(ped, lastCoords, 0, 0, 0, false)

	NetworkResurrectLocalPlayer(lastCoords.x, lastCoords.y, lastCoords.z, GetEntityHeading(PlayerPedId()), true, false)

	SetPlayerInvincible(ped, false)

  Wait(500)

  SetEntityHealth(PlayerPedId(), health)

else

  local ped = PlayerPedId()

  FreezeEntityPosition(ped, false)

  SetPlayerInvincible(ped, false)

  local health = GetEntityHealth(ped)

  SetEntityCoords(ped, lastCoords, 0, 0, 0, false)

	NetworkResurrectLocalPlayer(lastCoords.x, lastCoords.y, lastCoords.z, GetEntityHeading(PlayerPedId()), true, false)

	SetPlayerInvincible(ped, false)

  Wait(500)

  SetEntityHealth(PlayerPedId(), health)

end





end













RegisterCommand('+animationmenu', function()

ExecuteCommand('menuanimacji')



end)



RegisterKeyMapping('+animationmenu', 'Menu animacji~', 'keyboard', '')











-----------------------------------------------------------------------------------------------------

-- Commands / Events --------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------



Citizen.CreateThread(function()

    TriggerEvent('chat:addSuggestion', '/e', 'Odpal emotkę', {{ name="emotka", help="rece6, damn, przytulas albo jakakolwiek inna emotka."}})

    TriggerEvent('chat:addSuggestion', '/emote', 'Odpal emotkę', {{ name="emotka", help="rece6, damn, przytulas albo jakakolwiek inna emotka."}})

      TriggerEvent('chat:addSuggestion', '/emotebind', 'Zbinduj emotkę', {{ name="klawisz", help="num4, num5, num6, num7. num8, num9. Numpad 4-9!"}, { name="emotka", help="rece6, damn, przytulas albo jakakolwiek inna emotka."}})

    TriggerEvent('chat:addSuggestion', '/walk', 'Ustawia styl chodzenia postaci.', {{ name="styl", help="gangster, pijany, kozaczek4 albo jakikolwiek inny styl chodzenia."}})

end)



RegisterCommand('e', function(source, args, raw) EmoteCommandStart(source, args, raw) end)

RegisterCommand('emotes', function(source, args, raw) EmotesOnCommand() end)

RegisterCommand('walk', function(source, args, raw) WalkCommandStart(source, args, raw) end)

RegisterCommand('walks', function(source, args, raw) WalksOnCommand() end)

RegisterCommand('emotebind', function(source, args, raw) EmoteBindStart(source, args, raw) end)

  RegisterCommand('emotebinds', function(source, args, raw) EmoteBindsStart(source, args, raw) end)

AddEventHandler('onResourceStop', function(resource)

  if resource == GetCurrentResourceName() then

    DestroyAllProps()

   -- ClearPedTasksImmediately(GetPlayerPed(-1))

   -- ResetPedMovementClipset(PlayerPedId())

  end

end)





function WalksMenu()

  local elements = {

    head = {'Style chodzenia', 'Opcje'},

    rows = {}

  }

  

  local number = 1



  table.insert(elements.rows, {

    data = 'reset',

    cols = {

      'Domyślny styl chodzenia',

      '{{' .. 'Wybierz styl chodzenia' .. '|play}}'

    }

  })

  for k,v in pairsByKeys(DP.Walks) do

    table.insert(elements.rows, {

      data = k,

      cols = {

        number .. '. ' .. k,

        '{{' .. 'Wybierz styl chodzenia' .. '|play}}'

      }

    })

    number = number + 1

  end



  ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'Chodzenie', elements, function(data, menu)

    local action = data.data

    if data.value == 'play' then

      ExecuteCommand('walk ' .. action)

    end

  end, function(data, menu)

    menu.close()

  end)

end







function FaceMenu()



  local elements = {}

local number = 1

table.insert(elements, {label = 'Zresetuj humor', value = 'reset', type = 'reset'})

for k,v in pairsByKeys(DP.Expressions) do

    table.insert(elements, {label = number .. '. ' .. k, value = v[2], type = 'play'})

    number = number + 1

end



  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dpemotes_expressions', {

		title    =  'Humorki',

		align    = Config.MenuPosition,

		elements = elements

	}, function(data, menu)

      if data.current.type == 'play' then

        SetFacialIdleAnimOverride(PlayerPedId(), data.current.value, 0)

      elseif data.current.type == 'reset' then

        ClearFacialIdleAnimOverride(PlayerPedId())

      end

		

	end, function(data, menu)

		menu.close()

	end)







end

RegisterNetEvent('otworzmenuanimacji:jd')
AddEventHandler('otworzmenuanimacji:jd', function()
      OpenMainAnimationsMenu()
end)

RegisterCommand('menuanimacji', function()
      TriggerEvent('otworzmenuanimacji:jd')
end)



function OpenMainAnimationsMenu()

  if firstTime then

    exports.pNotify:SendNotification({text = "Jeżeli jakieś menu Ci się nie załaduje, wystarczy kliknąć <b>[ESC]</b>, a następnie ponownie wejść w menu animacji.", type = "info", layout = "centerLeft", queue = "lmao", timeout = 8000})

    firstTime = false

  end

  local elements = {}

  table.insert(elements, {label = 'Animacje', value = 'animations'})

  table.insert(elements, {label = 'Anuluj animacje', value = 'cancel_animation'})

  table.insert(elements, {label = 'Style chodzenia', value = 'walking_styles'})

  table.insert(elements, {label = 'Nastroje', value = 'moods'})

  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'main_anims', {

      title    = 'Menu Animacji <span style="font-size:30%;"> by matthew</span>',

      align    = Config.MenuPosition,

      elements = elements

  }, function(data, menu)

      local action = data.current.value

    if action == 'animations' then

      ChooseAnimations()

    elseif action == 'moods' then

      FaceMenu()

    elseif action == 'cancel_animation' then

      ExecuteCommand('+cancel')

    elseif action == 'walking_styles' then

      WalksMenu()

    end



  end, function(data, menu)

      menu.close()

  end)

end



function SharedAnims()





local elements = {}

local number = 1

for k,v in pairsByKeys(DP.Shared) do

    table.insert(elements, {label = number .. '. ' .. v[3] .. ' <span style="font-size:70%; color:LightCoral;">/nearby ' .. k .. '</span>', value = k})

    number = number + 1

end



  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dpemotes_sharedanims', {

		title    =  'Wspólne animacje',

		align    = Config.MenuPosition,

		elements = elements

	}, function(data, menu)

    ExecuteCommand('nearby ' .. data.current.value)

		

	end, function(data, menu)

		menu.close()

	end)



end



local onDance = false

function PropsAnims()

  local elements = {

    head = {'Emotki z przedmiotami', 'Opcje'},

    rows = {}

  }

  

  local number = 1

  for k,v in pairsByKeys(DP.PropEmotes) do

    table.insert(elements.rows, {

      data = k,

      cols = {

        number .. '. ' .. v[3] .. ' <span style="font-size:70%;">/e ' .. k .. '</span>',

        '{{' .. 'Odpal emotkę' .. '|play}}'

      }

    })

    number = number + 1

  end



  ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'Przedmioty', elements, function(data, menu)

    local action = data.data

    if data.value == 'play' then

      ExecuteCommand('e ' .. action)

    end

   

  end, function(data, menu)

    menu.close()

  end)



end



function ChooseAnimations()

  local elements = {}

  table.insert(elements, {label = 'Wszystkie animacje', value = 'all_anims'})

  table.insert(elements, {label = 'Wspólne animacje', value = 'shared_anims'})

  table.insert(elements, {label = 'Przypisane animacje', value = 'anim_przypisane'})

  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'anims_choose', {

      title    = 'Menu Animacji <span style="font-size:30%;"> by matthew</span>',

      align    = Config.MenuPosition,

      elements = elements

  }, function(data, menu)

      local action = data.current.value

    if action == 'all_anims' then

      AllAnims()

    elseif action == 'shared_anims' then

      SharedAnims()

    elseif action == 'anim_przypisane' then

      ExecuteCommand('bindy')

    end

  end, function(data, menu)

      menu.close()

  end)

end





function AllAnims()



	local elements = {}



  for i = 1, #DP.Categories do

    table.insert(elements, {label = DP.Categories[i].label, value = DP.Categories[i].name, sub = DP.Categories[i].sub})

  end

 



  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dpemotes_categories', {

		title    = "Kategorie",

		align    = Config.MenuPosition,

		elements = elements

	}, function(data, menu)

    if data.current.sub ~= nil then

        local subs = {}

        for i = 1, #data.current.sub do

          table.insert(subs, {label = data.current.sub[i].label, value = data.current.sub[i].name})

        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dpemotes_categories_subs', {

          title    = data.current.label .. ' - Kategorie',

          align    = Config.MenuPosition,

          elements = subs

        }, function(data2, menu2)

          OpenAnimList(data2.current.label, data2.current.value)

        end, function(data2, menu2)

          menu2.close()

        end)

    else

      OpenAnimList(data.current.label, data.current.value)

    end

	end, function(data, menu)

		menu.close()

	end)

end





function OpenAnimList(label, name)

  local anims = FindAnimsByCategories(name)

  local elements = {}

 

  for k,v in pairsByKeys(anims) do

    table.insert(elements, {label = v[3] .. '  <span style="font-size:70%; color:LightCoral;">/e ' .. v.command .. '</span>', value = v.command})

  end



  table.sort(elements, function(a, b) return a.label:upper() < b.label:upper() end)

ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dpemotes_anims', {

        title    =  label,

        align    = Config.MenuPosition,

        elements = elements

    }, function(data, menu)

    ExecuteCommand('e ' .. data.current.value)

        

    end, function(data, menu)

        menu.close()

    end)



end











function FindAnimsByCategories(name)

local anims = {}

  for k,v in pairs(DP.Emotes) do

    if v.category ~= nil then

      for i = 1,#v.category do

        if v.category[i] == name then

          DP.Emotes[k].command = k

          table.insert(anims, DP.Emotes[k])

        end

      end

    end

  end

  for k,v in pairs(DP.PropEmotes) do

    if v.category ~= nil then

      for i = 1,#v.category do

        if v.category[i] == name then

          DP.PropEmotes[k].command = k

          table.insert(anims, DP.PropEmotes[k])

        end

      end

    end

  end

  for k,v in pairs(DP.Dances) do

    if v.category ~= nil then

      for i = 1,#v.category do

        if v.category[i] == name then

          DP.Dances[k].command = k

          table.insert(anims, DP.Dances[k])

        end

      end

    end

  end



  return anims

end

function DanceAnims()

  local elements = {}

  local number = 1

  local elements = {

    head = {'Wybór tańca', 'Opcje'},

    rows = {}

  }

  

  local number = 1

  table.insert(elements.rows, {

    data = 'random',

    cols = {

      'Randomowy taniec',

      '{{' .. 'Odpal taniec' .. '|play}}'

    }

  })

  for k,v in pairsByKeys(DP.Dances) do

    table.insert(elements.rows, {

      data = k,

      cols = {

        number .. '. ' .. v[3] .. ' <span style="font-size:70%;">/e ' .. k .. '</span>',

        '{{' .. 'Odpal taniec' .. '|play}}'

      }

    })

    number = number + 1

  end



  ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'Tańce', elements, function(data, menu)

    local action = data.data

    if action == 'random' then

        TriggerEvent('np:dances:dance', -1)

      return

    end

    if data.value == 'play' then

      ExecuteCommand('e ' .. action)

    end

   

  end, function(data, menu)

    menu.close()

  end)

end

-----------------------------------------------------------------------------------------------------

------ Functions and stuff --------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------



function EmoteCancel()



  if ChosenDict == "MaleScenario" and IsInAnimation then

    ClearPedTasksImmediately(PlayerPedId())

    IsInAnimation = false

    DebugPrint("Forced scenario exit")

  elseif ChosenDict == "Scenario" and IsInAnimation then

    ClearPedTasksImmediately(PlayerPedId())

    IsInAnimation = false

    DebugPrint("Forced scenario exit")

  end



  PtfxNotif = false

  PtfxPrompt = false

  if onDance == true then

    ClearPedTasks(PlayerPedId())

    onDance = false

  end

  if IsInAnimation then

    PtfxStop()

    ClearPedTasks(GetPlayerPed(-1))

    DestroyAllProps()

    IsInAnimation = false

  end

end



function EmoteChatMessage(args)

  exports['mythic_notify']:SendAlert('black', args, 4000)

end



function DebugPrint(args)

  if Config.DebugDisplay then

    print(args)

  end

end



function PtfxStart()

    if PtfxNoProp then

      PtfxAt = PlayerPedId()

    else

      PtfxAt = prop

    end

    UseParticleFxAssetNextCall(PtfxAsset)

    Ptfx = StartNetworkedParticleFxLoopedOnEntityBone(PtfxName, PtfxAt, Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, GetEntityBoneIndexByName(PtfxName, "VFX"), 1065353216, 0, 0, 0, 1065353216, 1065353216, 1065353216, 0)

    SetParticleFxLoopedColour(Ptfx, 1.0, 1.0, 1.0)

    table.insert(PlayerParticles, Ptfx)

end



function PtfxStop()

  for a,b in pairs(PlayerParticles) do

    DebugPrint("Stopped PTFX: "..b)

    StopParticleFxLooped(b, false)

    table.remove(PlayerParticles, a)

  end

end



function EmotesOnCommand(source, args, raw)

  local EmotesCommand = ""

  for a in pairsByKeys(DP.Emotes) do

    EmotesCommand = EmotesCommand .. ""..a..", "

  end

  --EmoteChatMessage(EmotesCommand)

  

end



function pairsByKeys (t, f)

    local a = {}

    for n in pairs(t) do

        table.insert(a, n)

    end

    table.sort(a, f)

    local i = 0      -- iterator variable

    local iter = function ()   -- iterator function

        i = i + 1

        if a[i] == nil then

            return nil

        else

            return a[i], t[a[i]]

        end

    end

    return iter

end



function EmoteMenuStart(args, hard)

    local name = args

    local etype = hard



    if etype == "dances" then

        if DP.Dances[name] ~= nil then

          if OnEmotePlay(DP.Dances[name]) then end

        end

    elseif etype == "props" then

        if DP.PropEmotes[name] ~= nil then

          if OnEmotePlay(DP.PropEmotes[name]) then end

        end

    elseif etype == "emotes" then

        if DP.Emotes[name] ~= nil then

          if OnEmotePlay(DP.Emotes[name]) then end



        else

          if name ~= "🕺 Dance Emotes" then end

        end

    elseif etype == "expression" then

        if DP.Expressions[name] ~= nil then

          if OnEmotePlay(DP.Expressions[name]) then end

        end

    end

end



function EmoteCommandStart(source, args, raw)

    if #args > 0 then

    local name = string.lower(args[1])

    if name == "c" then

        if IsInAnimation then

            EmoteCancel()

        else

            EmoteChatMessage('Nie masz czego zatrzymać')

        end

      return

    elseif name == "help" then

      EmotesOnCommand()

    return end

 

    if DP.Emotes[name] ~= nil then

      if OnEmotePlay(DP.Emotes[name]) then end return

    elseif DP.Dances[name] ~= nil then

      if OnEmotePlay(DP.Dances[name]) then end return

    elseif DP.PropEmotes[name] ~= nil then

      if OnEmotePlay(DP.PropEmotes[name]) then end return

    else

      EmoteChatMessage('Nie ma takiej animacji!')

    end

  end

end



function LoadAnim(dict)

  while not HasAnimDictLoaded(dict) do

    RequestAnimDict(dict)

    Wait(10)

  end

end



function LoadPropDict(model)

  while not HasModelLoaded(GetHashKey(model)) do

    RequestModel(GetHashKey(model))

    Wait(10)

  end

end



function PtfxThis(asset)

  while not HasNamedPtfxAssetLoaded(asset) do

    RequestNamedPtfxAsset(asset)

    Wait(10)

  end

  UseParticleFxAssetNextCall(asset)

end



function DestroyAllProps()

  for _,v in pairs(PlayerProps) do

    DeleteEntity(v)

  end

  PlayerHasProp = false

  DebugPrint("Destroyed Props")

end



function AddPropToPlayer(prop1, bone, off1, off2, off3, rot1, rot2, rot3, canDrop)

  local Player = PlayerPedId()

  local x,y,z = table.unpack(GetEntityCoords(Player))



  if not HasModelLoaded(prop1) then

    LoadPropDict(prop1)

  end



  prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  true,  true, true)

  AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)

  table.insert(PlayerProps, prop)

  PlayerHasProp = true

  SetModelAsNoLongerNeeded(prop1)

  if canDrop then

    exports['mythic_notify']:SendAlert('black', 'Naciśnij <span style="color:LightCoral;">[G] </span>aby położyć obiekt <span style="color:LightCoral;">na ziemie!</span>', 5000)

    PlayerHasProp = true

      while PlayerHasProp do

        Wait(5)



        if IsControlJustPressed(0, 47) then

          droppingItem = true

          exports['mythic_notify']:SendAlert('black', 'Naciśnij <span style="color:LightCoral;">[DELETE] </span>aby przerwać animację i usunąć obiekt!', 5000)

          DestroyAllProps()

          exports['pixa_misc']:PlayAnimation('anim@heists@money_grab@briefcase', 'put_down_case')

          prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  true,  true, true)

          AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)

          SetModelAsNoLongerNeeded(prop1)

          Citizen.Wait(3000)

          

          DeleteObject(prop)

          ClearPedSecondaryTask(PlayerPedId())

          

          local playerPed = PlayerPedId()

          local coords    = GetEntityCoords(playerPed)

          local forward   = GetEntityForwardVector(playerPed)

          local x, y, z   = table.unpack(coords + forward * 1.0)

            ESX.Game.SpawnObject(prop1, {

              x = x,

              y = y,

              z = z

            }, function(obj)

              SetEntityHeading(obj, GetEntityHeading(playerPed))

              PlaceObjectOnGroundProperly(obj)

              SetEntityAsMissionEntity(obj, true, false)

              FreezeEntityPosition(obj, true)

              prop = obj

              table.insert(PlayerProps, prop)

            end)

            droppingItem = false

        end

      end

  end

end









-----------------------------------------------------------------------------------------------------

-- V -- This could be a whole lot better, i tried messing around with "IsPedMale(ped)"

-- V -- But i never really figured it out, if anyone has a better way of gender checking let me know.

-- V -- Since this way doesnt work for ped models.

-- V -- in most cases its better to replace the scenario with an animation bundled with prop instead.

-----------------------------------------------------------------------------------------------------



function CheckGender()

  local hashSkinMale = GetHashKey("mp_m_freemode_01")

  local hashSkinFemale = GetHashKey("mp_f_freemode_01")



  if GetEntityModel(PlayerPedId()) == hashSkinMale then

    PlayerGender = "male"

  elseif GetEntityModel(PlayerPedId()) == hashSkinFemale then

    PlayerGender = "female"

  end

  DebugPrint("Set gender as = ("..PlayerGender..")")

end



-----------------------------------------------------------------------------------------------------

------ This is the major function for playing emotes! -----------------------------------------------

-----------------------------------------------------------------------------------------------------



function OnEmotePlay(EmoteName)

  if droppingItem then return end

  InVehicle = IsPedInAnyVehicle(PlayerPedId(), true)

  if EmoteName.AnimationOptions and not EmoteName.AnimationOptions.AllowedInCar and InVehicle == 1 then

    return

  end



  if not DoesEntityExist(GetPlayerPed(-1)) then

    return false

  end



  if Config.DisarmPlayer then

    if IsPedArmed(GetPlayerPed(-1), 7) then

      SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey('WEAPON_UNARMED'), true)

    end

  end



  ChosenDict,ChosenAnimation,ename = table.unpack(EmoteName)

  lastAnimName = EmoteName

  AnimationDuration = -1



  if ename == 'Yoga' then

    exports['pixa_misc']:ProgressBar('yoga_dpemotes', 30000, 'Wykonujesz yoge', true, true, true, function(finished)

      if finished then

        exports['pixa_boosters']:AddBooster('yoga', 10)

      else

        IsInAnimation = false

        ClearPedTasks(PlayerPedId())

      end

    end)

  end



  if PlayerHasProp then

    DestroyAllProps()

  end



  if ChosenDict == "Expression" then

    SetFacialIdleAnimOverride(PlayerPedId(), ChosenAnimation, 0)

    return

  end



  if ChosenDict == "MaleScenario" or "Scenario" then 

    CheckGender()

    if ChosenDict == "MaleScenario" then if InVehicle then return end

      if PlayerGender == "male" then

        ClearPedTasks(GetPlayerPed(-1))

        TaskStartScenarioInPlace(GetPlayerPed(-1), ChosenAnimation, 0, true)

        DebugPrint("Playing scenario = ("..ChosenAnimation..")")

        IsInAnimation = true

      else

        EmoteChatMessage('Ta animacja jest tylko dla mezczyzn!')

      end return

    elseif ChosenDict == "ScenarioObject" then if InVehicle then return end

      BehindPlayer = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0 - 0.5, -0.5);

      ClearPedTasks(GetPlayerPed(-1))

      TaskStartScenarioAtPosition(GetPlayerPed(-1), ChosenAnimation, BehindPlayer['x'], BehindPlayer['y'], BehindPlayer['z'], GetEntityHeading(PlayerPedId()), 0, 1, false)

      DebugPrint("Playing scenario = ("..ChosenAnimation..")")

      IsInAnimation = true

      return

    elseif ChosenDict == "Scenario" then if InVehicle then return end

      ClearPedTasks(GetPlayerPed(-1))

      TaskStartScenarioInPlace(GetPlayerPed(-1), ChosenAnimation, 0, true)

      DebugPrint("Playing scenario = ("..ChosenAnimation..")")

      IsInAnimation = true

    return end 

  end



  LoadAnim(ChosenDict)



  if EmoteName.AnimationOptions then

    if EmoteName.AnimationOptions.EmoteLoop then

      MovementType = 1

    if EmoteName.AnimationOptions.EmoteMoving then

      MovementType = 51

  end



  elseif EmoteName.AnimationOptions.EmoteMoving then

    MovementType = 51

  elseif EmoteName.AnimationOptions.EmoteMoving == false then

    MovementType = 0

  elseif EmoteName.AnimationOptions.EmoteStuck then

    MovementType = 50

  end



  else

    MovementType = 0

  end



  if InVehicle == 1 then

    MovementType = 51

  end

  if EmoteName.AnimationOptions then

    if EmoteName.AnimationOptions.EmoteDuration == nil then 

      EmoteName.AnimationOptions.EmoteDuration = -1

      AttachWait = 0

    else

      AnimationDuration = EmoteName.AnimationOptions.EmoteDuration

      AttachWait = EmoteName.AnimationOptions.EmoteDuration

    end



    if EmoteName.AnimationOptions.PtfxAsset then

      PtfxAsset = EmoteName.AnimationOptions.PtfxAsset

      PtfxName = EmoteName.AnimationOptions.PtfxName

      if EmoteName.AnimationOptions.PtfxNoProp then

        PtfxNoProp = EmoteName.AnimationOptions.PtfxNoProp

      else

        PtfxNoProp = false

      end

      Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, PtfxScale = table.unpack(EmoteName.AnimationOptions.PtfxPlacement)

      PtfxInfo = EmoteName.AnimationOptions.PtfxInfo

      PtfxWait = EmoteName.AnimationOptions.PtfxWait

      PtfxNotif = false

      PtfxPrompt = true

      PtfxThis(PtfxAsset)

    else

      DebugPrint("Ptfx = none")

      PtfxPrompt = false

    end

  end



  TaskPlayAnim(GetPlayerPed(-1), ChosenDict, ChosenAnimation, 2.0, 2.0, AnimationDuration, MovementType, 0, false, false, false)

  if ename == 'Zerkanie na zegarek' then



    exports['pixa_misc']:ProgressBar('zegarek', 5000, 'Zerkasz na zegarek', true, false, true, function(finished)

      if finished then

        local dayInt = GetClockDayOfWeek()

        local day = ''

    

        if dayInt == 0 then

          day = 'Niedziela'

        elseif dayInt == 1 then

          day = 'Poniedziałek'

        elseif dayInt == 2 then

          day = 'Wtorek'

        elseif dayInt == 3 then

          day = 'Środa'

        elseif dayInt == 4 then

          day = 'Czwartek'

        elseif dayInt == 5 then

          day = 'Piątek'

        elseif dayInt == 6 then

          day = 'Sobota'

        end

    

        local hourInt = GetClockHours()

        local hour = ''

        if string.len(tostring(hourInt)) == 1 then

          hour = '0'..hourInt

        else

          hour = hourInt

        end

    

        local minuteInt = GetClockMinutes()

        local minute = ''

        if string.len(tostring(minuteInt)) == 1 then

          minute = '0'..minuteInt

        else

          minute = minuteInt

        end

          local dayText = hour..':'..minute..' | '..day

          exports['mythic_notify']:SendAlert('black', 'Spoglądasz na zegarek i widzisz</br>' .. hour .. ':' .. minute .. ', ' .. day, 4000)

         -- ClearPedTasks(PlayerPedId())

         ClearPedTasks(PlayerPedId())

      else

        IsInAnimation = false

        ClearPedTasks(PlayerPedId())

      end

  end)

  end



  if ename == 'Pompki' then

    exports['pixa_misc']:ProgressBar('pompki_dpemotes', 20000, 'Wykonujesz pompki', true, true, true, function(finished)

      if finished then

        if exports['pixa_misc']:HasMoreStatus('stress', 95) then

              exports['mythic_notify']:SendAlert('black', 'Twój poziom zmęczenia jest zbyt wysoki!</br>Spróbuj go zbić', 5000)

                  return

              end

              exports["pixa_skill"]:UpdateSkill("Siłacz", 0.4)

              exports['pixa_misc']:AddStatus('stress', 4) -- client side

         

      else

        IsInAnimation = false

        ClearPedTasks(PlayerPedId())

      end

    end)

  end





  RemoveAnimDict(ChosenDict)

  IsInAnimation = true

  MostRecentDict = ChosenDict

  MostRecentAnimation = ChosenAnimation



  if EmoteName.AnimationOptions then

    if EmoteName.AnimationOptions.Prop then

        PropName = EmoteName.AnimationOptions.Prop

        PropBone = EmoteName.AnimationOptions.PropBone

        PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack(EmoteName.AnimationOptions.PropPlacement)

        if EmoteName.AnimationOptions.SecondProp then

          SecondPropName = EmoteName.AnimationOptions.SecondProp

          SecondPropBone = EmoteName.AnimationOptions.SecondPropBone

          SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6 = table.unpack(EmoteName.AnimationOptions.SecondPropPlacement)

          SecondPropEmote = true

        else

          SecondPropEmote = false

        end

        Wait(AttachWait)

        AddPropToPlayer(PropName, PropBone, PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6, EmoteName.AnimationOptions.canDrop)

        if SecondPropEmote then

          AddPropToPlayer(SecondPropName, SecondPropBone, SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6, EmoteName.AnimationOptions.canDrop)

        end

    end

  end

  return true

end









--------------- NP DANCES





local isHandcuffed, isSoftCuffed = false, false





local animations = {

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_flats_female^3", disabled = true},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_male^3", disabled = true},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_flats_female^5", disabled = true},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_flats_female^1", disabled = true},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_flats_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_flats_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_flats_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_flats_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_flats_female^4", disabled = true},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_flats_female^6", disabled = true},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_flats_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_flats_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_flats_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_flats_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_flats_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_flats_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_flats_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_flats_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_flats_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_flats_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_flats_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_flats_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_flats_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_flats_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_flats_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v2_phone^3", disabled = true},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_phone^2", disabled = true},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_flats_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_flats_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_flats_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_vape_01^3", disabled = true},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_flats_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v2_phone^1", disabled = true},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_flats_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_flats_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v1_phone", disabled = true},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_13_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_13_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_13_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_13_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_13_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_15_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_17_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_15_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_17_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_13_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_13_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_13_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_15_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v1_flats_female^4", disabled = true},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_17_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_13_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_13_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_13_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_13_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v1_flats_female^3", disabled = true},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_17_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_17_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_15_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_13_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_15_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_15_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_15_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_17_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_15_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_13_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_13_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_17_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_13_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_15_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_13_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_15_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_15_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v1_flats_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_17_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_15_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v1_flats_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v1_flats_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_17_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_17_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_13_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_13_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_13_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_15_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_15_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_15_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_15_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_15_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_17_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_15_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_13_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_15_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_15_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_17_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_15_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v1_flats_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_15_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_11_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_13_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_13_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_15_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_13_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_15_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v1_female^1"},

 

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_11_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_13_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_09_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_11_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_13_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_09_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_11_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_11_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_13_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_09_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_11_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_09_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_09_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_09_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_09_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_11_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_13_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_11_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_11_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_11_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_11_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_13_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_13_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_13_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_13_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_11_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_11_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_11_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_13_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_11_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_09_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_11_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_13_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_13_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_09_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_13_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_13_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_11_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_13_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_09_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_11_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_11_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_13_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_11_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_13_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_09_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_11_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_13_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_13_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_13_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_09_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_13_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_13_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_11_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_11_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_09_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_13_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_11_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_09_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_09_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_11_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_09_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_09_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_09_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_09_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_09_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_09_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_09_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_09_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_13_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_09_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_13_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_15_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_13_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_17_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_11_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_11_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_17_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_17_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_13_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_11_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_17_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_15_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_09_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_17_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_10_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_11_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_09_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_11_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_09_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_13_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_11_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_13_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_17_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_10_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_17_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_17_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_11_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_11_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_17_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_11_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_15_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_15_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_09_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_15_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_13_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_17_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_15_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_10_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_15_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_13_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_11_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_09_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_13_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_11_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_15_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_17_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_09_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_15_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_15_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_15_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_11_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_09_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_13_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_17_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_15_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_17_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_15_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_09_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_11_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_15_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_15_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_10_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_13_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_13_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_11_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_17_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_15_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_17_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_11_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_13_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_13_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_11_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_11_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_13_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_17_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_13_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_11_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_17_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_11_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_09_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_13_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_11_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_13_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_13_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_10_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_15_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_10_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_13_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_15_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_13_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_17_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_15_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_15_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_11_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_10_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_17_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_11_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_15_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_17_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_15_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_17_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_17_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_09_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_09_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_09_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_10_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_10_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_13_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_10_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_11_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_13_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_10_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_11_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_17_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_13_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_17_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_15_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_10_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_13_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_15_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", anim = "mi_dance_crowd_13_v2_male^3"},

    

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_11_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_09_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_17_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_17_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_15_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_15_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_11_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_17_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_11_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_17_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_09_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_11_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_17_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_11_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_17_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_15_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_15_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_11_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_09_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_15_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_09_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_17_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_11_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_17_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_15_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_11_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_15_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_11_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_09_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_09_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_09_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_11_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_17_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_15_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_09_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_15_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_11_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_11_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_09_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_15_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_17_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_17_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_15_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_09_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_09_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_15_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_09_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_17_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_15_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_11_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_09_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_crowd_prop_15_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_09_v1_male^3_face"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_09_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_15_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_17_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_crowd_prop_15_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_crowd_prop_15_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_15_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_11_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_11_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_09_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_17_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_15_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_11_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_15_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_15_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_crowd_prop_15_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_15_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_17_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_11_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_09_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_17_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_crowd_prop_15_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_09_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_15_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_11_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_09_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_09_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_17_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_09_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_15_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_17_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_crowd_prop_15_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_crowd_prop_15_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_15_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_17_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_09_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v2_male^5_face"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_11_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v2_male^3_face"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_09_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_09_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_crowd_prop_15_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_15_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v2_male^6_face"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_17_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_crowd_prop_15_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_11_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_crowd_prop_15_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_crowd_prop_15_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_11_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_09_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_17_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_15_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_17_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_17_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_13_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_17_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_crowd_prop_15_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_11_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_11_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@low_intensity", anim = "li_dance_prop_11_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_17_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_13_v2_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_15_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_11_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_13_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_17_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_15_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_09_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_13_v2_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_17_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_09_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_17_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_11_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_15_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_15_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_13_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_13_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_09_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_13_v2_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_17_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_15_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_09_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_09_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_13_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_13_v2_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_09_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_17_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_17_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_17_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_09_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_11_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_11_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_11_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_17_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_11_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_09_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_09_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_13_v2_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_15_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_13_v2_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_13_v2_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_09_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_13_v2_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_13_v2_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_13_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_17_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_13_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_15_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_13_v2_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_11_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_13_v2_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_17_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_15_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_13_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_11_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_11_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_11_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_15_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_13_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_11_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_13_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_13_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_15_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_15_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_13_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_15_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_17_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_09_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_13_v2_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_13_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_11_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props@med_intensity", anim = "mi_dance_prop_09_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_mi_09_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_mi_11_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "vehicleweapons_tula"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_li_09_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_mi_11_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_mi_11_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_li_09_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_li_09_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_mi_11_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_mi_09_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_li_09_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_mi_11_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_mi_11_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_mi_09_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_li_09_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_mi_11_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_li_09_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_mi_09_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_mi_09_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_mi_11_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_mi_09_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_li_09_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_mi_09_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_li_09_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_mi_09_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_li_09_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_mi_11_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_mi_09_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_mi_11_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_mi_11_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_mi_09_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_mi_11_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_mi_09_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_mi_11_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_mi_11_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_li_09_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_mi_11_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_mi_09_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_mi_09_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_mi_11_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_mi_09_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_mi_09_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_li_09_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_mi_11_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_mi_11_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_mi_11_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_mi_09_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_mi_09_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_mi_09_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_mi_11_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_mi_11_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_mi_11_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_li_09_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_mi_09_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_mi_09_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_mi_09_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_mi_11_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_dance_prop_hi_to_mi_11_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_mi_09_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_mi_09_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_dance_prop_li_to_hi_07_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_dance_prop_li_to_mi_11_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_crowd_prop_li_to_mi_11_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_crowd_prop_li_to_hi_07_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_crowd_prop_li_to_mi_11_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_dance_prop_li_to_mi_11_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_crowd_prop_li_to_mi_11_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_crowd_prop_li_to_mi_11_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_dance_prop_li_to_mi_11_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_crowd_prop_li_to_hi_07_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_dance_prop_li_to_hi_07_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_dance_prop_li_to_mi_11_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_dance_prop_li_to_hi_07_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_dance_prop_li_to_hi_07_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_crowd_prop_li_to_hi_07_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_dance_prop_li_to_mi_11_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_dance_prop_li_to_hi_07_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_dance_prop_li_to_mi_11_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_dance_prop_li_to_mi_11_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_dance_prop_li_to_hi_07_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_crowd_prop_li_to_mi_11_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_crowd_prop_li_to_mi_11_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_crowd_prop_li_to_mi_11_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_dance_prop_li_to_hi_07_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_dance_prop_li_to_mi_11_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_crowd_prop_li_to_mi_11_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_crowd_prop_li_to_mi_11_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_crowd_prop_li_to_hi_07_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_dance_prop_li_to_hi_07_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_dance_prop_li_to_hi_07_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_dance_prop_li_to_hi_07_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_dance_prop_li_to_hi_07_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_crowd_prop_li_to_hi_07_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_dance_prop_li_to_mi_11_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_crowd_prop_li_to_mi_11_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_crowd_prop_li_to_mi_11_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_dance_prop_li_to_mi_11_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_crowd_prop_li_to_hi_07_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_crowd_prop_li_to_hi_07_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_crowd_prop_li_to_hi_07_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_crowd_prop_li_to_mi_11_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_crowd_prop_li_to_hi_07_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_dance_prop_li_to_mi_11_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_crowd_prop_li_to_hi_07_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_dance_prop_li_to_mi_11_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_crowd_prop_li_to_hi_07_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_dance_prop_li_to_hi_07_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_low_intensity", anim = "trans_crowd_prop_li_to_hi_07_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_dance_prop_mi_to_hi_11_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_li_11_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_li_11_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_li_11_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_hi_11_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_dance_prop_mi_to_li_11_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_dance_prop_mi_to_li_11_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_dance_prop_mi_to_li_11_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_dance_prop_mi_to_hi_11_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_li_11_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_hi_11_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_dance_prop_mi_to_hi_11_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_dance_prop_mi_to_hi_11_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_dance_prop_mi_to_hi_11_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_hi_11_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_dance_prop_mi_to_li_11_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_hi_11_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_dance_prop_mi_to_li_11_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_dance_prop_mi_to_hi_11_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_li_11_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_hi_11_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_dance_prop_mi_to_li_11_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_dance_prop_mi_to_li_11_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_hi_11_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_dance_prop_mi_to_hi_11_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_li_11_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_dance_prop_mi_to_hi_11_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_dance_prop_mi_to_hi_11_v1_male^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_hi_11_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_hi_11_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_li_11_v1_female^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_dance_prop_mi_to_hi_11_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_dance_prop_mi_to_li_11_v1_male^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_hi_11_v1_female^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_li_11_v1_female^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_li_11_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_li_11_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_hi_11_v1_male^3"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_dance_prop_mi_to_hi_11_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_li_11_v1_male^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_li_11_v1_female^2"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_dance_prop_mi_to_li_11_v1_male^6"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_dance_prop_mi_to_li_11_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_dance_prop_mi_to_hi_11_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_hi_11_v1_female^5"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_hi_11_v1_female^4"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_dance_prop_mi_to_li_11_v1_male^1"},

    { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_dance_prop_mi_to_li_11_v1_female^2"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "high_left_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "low_left_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "high_left_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "med_right_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "high_center_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "low_right"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "high_right_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "low_left_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "low_right_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "med_right"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "intro"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "med_right_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "low_right_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "med_left_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "low_center_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "high_right"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "high_center_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "high_center"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "med_center_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "low_center"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "high_right_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "low_left"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "outro", disabled = true},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "med_left_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "med_left"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "high_left"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", anim = "low_center_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "high_left_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "low_left_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "high_left_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "med_right_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "med_center"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "high_center_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "med_center_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "low_right"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "high_right_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "low_left_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "low_right_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "med_right"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "intro"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "med_right_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "low_right_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "med_left_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "low_center_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "high_right"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "high_center_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "high_center"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "med_center_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "low_center"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "high_right_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "low_left"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "outro"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "med_left_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "med_left"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "high_left"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@jumper@", anim = "low_center_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "high_left_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "low_left_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "high_left_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "med_right_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "med_center"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "high_center_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "med_center_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "low_right"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "high_right_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "low_left_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "low_right_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "med_right"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "intro", disabled = true},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "med_right_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "low_right_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "med_left_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "low_center_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "high_right"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "high_center_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "high_center"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "med_center_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "low_center"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "high_right_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "low_left"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "outro"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "med_left_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "med_left"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "high_left"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@sand_trip@", anim = "low_center_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "high_left_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "low_left_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "high_left_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "med_right_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "med_center"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "high_center_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "med_center_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "low_right"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "high_right_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "low_left_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "low_right_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "med_right"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "intro"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "med_right_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "low_right_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "med_left_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "low_center_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "high_right"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "high_center_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "high_center"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "med_center_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "low_center"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "high_right_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "low_left"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "outro"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "med_left_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "med_left"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "high_left"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "low_center_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "high_left_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "low_left_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "high_left_down", disabled = true},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "med_right_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "med_center"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "high_center_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "med_center_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "low_right"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "high_right_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "low_left_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "low_right_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "med_right"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "intro"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "med_right_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "low_right_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "med_left_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "low_center_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "high_right"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "high_center_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "high_center"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "med_center_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "low_center"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "high_right_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "low_left"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "outro"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "med_left_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "med_left"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "high_left"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", anim = "low_center_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "high_left_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "low_left_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "high_left_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "med_right_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "med_center"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "high_center_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "med_center_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "low_right"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "high_right_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "low_left_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "low_right_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "med_right"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "intro", disabled = true},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "med_right_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "low_right_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "med_left_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "low_center_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "high_right"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "high_center_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "high_center"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "med_center_down"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "low_center"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "high_right_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "low_left"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "outro"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "med_left_up"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "med_left"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "high_left"},

    { dict = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "low_center_down"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_idle_c_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_idle_c_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_to_hi_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_to_hi_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_idle_a_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_idle_a_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_to_li_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_to_li_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_to_li_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_to_li_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_idle_c_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_d_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_d_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_d_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_d_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_c_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_c_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_c_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_c_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_idle_c_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_idle_c_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_idle_c_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_idle_c_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_to_mi_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_to_mi_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_to_mi_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_to_mi_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_d_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_to_li_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_to_mi_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_c_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_idle_a_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_idle_a_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_idle_a_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_loop_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_loop_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_idle_a_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_idle_a_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_loop_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_loop_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_loop_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_loop_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_loop_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_loop_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_loop_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_loop_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_idle_b_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_idle_b_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_idle_b_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_idle_b_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_to_li_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_to_li_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_to_li_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_to_li_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_to_ti_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_to_ti_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_to_hi_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_to_hi_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_idle_a_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_loop_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_idle_b_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_idle_b_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_idle_b_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_idle_b_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_to_li_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_idle_b_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_idle_a_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_idle_b_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_loop_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_loop_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_to_hi_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_to_hi_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_loop_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_loop_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_to_ti_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_to_ti_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_d_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_idle_b_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_idle_b_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_to_ti_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_to_ti_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_to_ti_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_d_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_idle_b_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_idle_b_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_idle_c_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_idle_b_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_idle_b_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_idle_c_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_idle_d_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_idle_d_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_loop_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_loop_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_to_mi_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_to_mi_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_b_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_loop_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_to_ti_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_loop_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_loop_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_loop_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_loop_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_to_ti_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_loop_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_loop_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_to_li_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_to_li_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_to_li_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_to_li_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_to_hi_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_to_hi_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_to_hi_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_b_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_b_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_b_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_b_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_to_hi_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_to_hi_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_to_hi_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_to_hi_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_b_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_b_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_to_hi_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_to_hi_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_to_hi_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_to_hi_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_to_hi_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_to_hi_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_to_mi_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_idle_d_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_to_mi_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_to_mi_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_to_mi_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_a_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_a_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_a_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_a_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_idle_a_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_idle_a_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_idle_a_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_idle_a_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_idle_a_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_to_ti_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_to_ti_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_to_ti_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_idle_c_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_idle_c_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_to_mi_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_to_mi_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_to_mi_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_idle_c_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_idle_c_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_to_ti_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_to_ti_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_idle_a_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_idle_a_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_idle_a_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_to_mi_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_to_mi_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_to_li_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_idle_c_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_idle_c_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_idle_c_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_idle_a_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_idle_a_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_to_li_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_to_li_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_to_li_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_to_li_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_a_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_a_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_to_ti_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_to_ti_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_to_mi_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_to_mi_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_to_mi_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_to_mi_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_to_mi_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_to_ti_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_to_ti_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_to_ti_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_idle_b_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_idle_b_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_idle_c_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_idle_c_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_idle_c_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_to_li_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_idle_b_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_idle_b_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_idle_b_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_to_li_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_c_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_c_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_idle_c_m05"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_idle_c_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_to_ti_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_loop_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_loop_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_to_ti_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_to_hi_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "li_to_hi_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_loop_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "mi_loop_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_a_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_idle_a_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdance@", anim = "ti_idle_a_f01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_idle_c_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_to_mi_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_loop_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_idle_f_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_loop_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_idle_a_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_idle_c_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_idle_c_f1"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_loop_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_to_li_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_idle_a_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_idle_b_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_loop_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_to_ti_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_idle_e_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_loop_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_loop_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_idle_a_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_to_mi_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_idle_a_f1"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_idle_a_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_idle_a_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_to_mi_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_idle_b_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_idle_c_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_to_mi_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_idle_b_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_idle_b_f1"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_to_li_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_idle_b_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_idle_a_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_idle_c_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_idle_b_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_to_mi_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_idle_c_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_idle_a_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_idle_c_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_idle_c_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_idle_b_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_to_mi_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_idle_a_f1"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_idle_b_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_idle_c_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_idle_a_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_to_mi_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_to_mi_drop_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_idle_a_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_idle_b_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_to_li_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_loop_f1"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_loop_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_idle_c_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_to_mi_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_loop_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_idle_d_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_loop_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_to_li_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_to_ti_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_to_ti_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_loop_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_to_ti_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_idle_b_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_to_mi_drop_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_idle_d_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_idle_a_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_to_ti_f1"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_to_ti_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_to_li_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_idle_c_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_to_ti_f1"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_to_mi_f1", disabled = true},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_to_li_f1"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_to_mi_drop_f1"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_idle_c_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_idle_a_f1"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_idle_b_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_idle_b_f1"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_idle_c_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_idle_a_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_idle_d_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_to_ti_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_idle_b_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_idle_a_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_idle_e_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_idle_c_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_loop_f1"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_idle_c_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_idle_a_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_loop_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_idle_c_f1"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_loop_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_to_li_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_idle_b_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_to_li_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_loop_f1"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_idle_b_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_idle_a_m02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_idle_c_f1"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_to_ti_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_loop_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_to_ti_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_idle_c_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_loop_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_to_ti_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_to_ti_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_to_mi_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_to_li_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_idle_b_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_idle_b_f1"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "ti_to_li_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_to_li_f1"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_to_li_m01"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_idle_a_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "li_idle_b_m03"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprop@", anim = "mi_loop_f02"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprops@male@", anim = "mi_idle_b_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprops@male@", anim = "mi_idle_c_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprops@male@", anim = "ti_to_li_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprops@male@", anim = "mi_loop_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprops@male@", anim = "mi_to_ti_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprops@male@", anim = "ti_idle_a_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprops@male@", anim = "li_idle_b_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprops@male@", anim = "li_to_mi_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprops@male@", anim = "mi_idle_a_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprops@male@", anim = "li_idle_a_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprops@male@", anim = "li_to_ti_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprops@male@", anim = "ti_to_mi_drop_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprops@male@", anim = "li_loop_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprops@male@", anim = "ti_idle_c_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprops@male@", anim = "ti_idle_b_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprops@male@", anim = "li_idle_c_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprops@male@", anim = "ti_loop_m04"},

    { dict = "anim@amb@nightclub_island@dancers@beachdanceprops@male@", anim = "mi_to_li_m04"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_idle_c_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_idle_c_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_idle_c_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_to_hi_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_to_hi_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_idle_a_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_idle_a_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_idle_a_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_to_hi_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_idle_f_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_li_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_li_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_c_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_d_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_d_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_d_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_c_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_c_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_c_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_c_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_to_mi_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_to_mi_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_li_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_idle_a_f04"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_to_mi_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_e_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_c_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_idle_a_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_loop_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_loop_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_idle_a_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_idle_a_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_loop_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_loop_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_loop_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_loop_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_idle_b_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_idle_b_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_idle_b_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_to_li_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_to_li_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_to_li_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_to_ti_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_to_ti_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_to_ti_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_idle_e_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_a_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_b_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_b_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_b_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_a_f04"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_a_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_a_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_loop_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_to_hi_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_to_hi_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_to_hi_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_loop_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_loop_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_ti_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_ti_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_d_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_b_f04"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_b_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_b_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_b_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_ti_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_d_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_d_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_idle_b_f04"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_idle_b_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_idle_b_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_idle_b_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_idle_c_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_idle_b_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_idle_b_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_idle_c_f04"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_idle_b_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_idle_c_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_idle_c_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_d_f04"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_d_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_loop_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_loop_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_loop_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_to_mi_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_to_mi_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_to_mi_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_b_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_to_ti_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_to_ti_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_loop_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_loop_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_loop_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_to_ti_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_loop_f04"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_loop_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_loop_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_loop_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_li_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_li_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_li_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_to_li_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_to_li_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_to_li_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_idle_d_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_to_hi_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_to_hi_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_to_hi_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_b_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_b_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_to_hi_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_to_hi_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_b_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_to_hi_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_b_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_b_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_to_hi_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_to_hi_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_to_hi_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_to_mi_f04"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_to_mi_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_mi_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_idle_d_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_f_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_mi_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_mi_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_to_mi_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_to_mi_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_a_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_a_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_a_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_a_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_a_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_to_ti_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_to_ti_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_c_f04"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_c_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_c_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_c_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_mi_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_idle_c_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_idle_c_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_idle_d_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_to_ti_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_idle_a_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_mi_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_mi_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_idle_c_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_idle_a_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_idle_a_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_to_li_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_to_li_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_to_li_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_a_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_a_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_a_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_to_mi_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_to_mi_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_to_mi_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_si_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_e_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_to_ti_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_to_ti_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_to_ti_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_to_li_f04"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_idle_c_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_idle_c_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_idle_c_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_to_li_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_to_li_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_idle_f_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_idle_b_m03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_idle_b_m02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_idle_b_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_to_li_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_c_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_c_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_c_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_ti_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_ti_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_loop_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_loop_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_to_ti_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_loop_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_to_hi_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_to_hi_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "li_to_hi_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_loop_f04"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_loop_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_loop_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "mi_loop_f01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_idle_e_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_a_m01"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_idle_a_f03"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_idle_a_f02"},

    { dict = "anim@amb@nightclub_island@dancers@club@", anim = "ti_idle_a_f01"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_13_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_15_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_15_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_11_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_13_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_13_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_13_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_17_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_13_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_d_11_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_13_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_17_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_13_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_11_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_11_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_11_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_13_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_17_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_11_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_17_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_17_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_09_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_09_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_17_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_09_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_09_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_13_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_17_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_11_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_13_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_13_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_17_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_d_11_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_17_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_17_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_13_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_09_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_11_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_15_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_13_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_17_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_11_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_d_11_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_15_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_13_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_11_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_17_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_d_11_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_09_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_11_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_17_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_09_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_17_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_09_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_17_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_11_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_13_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_13_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_15_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_15_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_11_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_09_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_11_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_09_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_09_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_17_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_17_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_11_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_13_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_09_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_09_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_13_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_11_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_13_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_17_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_15_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_13_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_17_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_13_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_15_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_13_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_17_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_17_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_13_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_13_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_13_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_09_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_11_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_15_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_09_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_17_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_15_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_09_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_11_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_13_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_09_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_13_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_11_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_13_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_09_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_17_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_17_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_17_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_15_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_13_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_09_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_13_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_13_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_17_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_17_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_15_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_11_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_11_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_17_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_13_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_09_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_17_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_17_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_17_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_11_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_17_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_09_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_15_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_13_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_11_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_13_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_d_11_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_15_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_13_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_13_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_09_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_17_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_17_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_11_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_13_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_13_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_d_11_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_13_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_13_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_17_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_17_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_17_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_13_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_13_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_d_11_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_09_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_17_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_17_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_13_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_17_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_17_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_11_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_13_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_17_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_17_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_09_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_13_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_17_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_17_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_11_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_13_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_17_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_11_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_09_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_17_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_11_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_09_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_11_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_13_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_17_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_13_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_17_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_d_11_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_13_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_09_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_13_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_17_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_17_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_11_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_09_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_13_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_13_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_09_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_17_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_11_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_17_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_13_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_17_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_13_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_13_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_13_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_17_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_13_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_15_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_15_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_17_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_13_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_17_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_13_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_09_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_09_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_11_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_09_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_17_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_13_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_09_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_13_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_09_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_17_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_11_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_09_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_15_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_09_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_17_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_13_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_13_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_09_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_11_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_13_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_09_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_17_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_17_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_13_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_15_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_11_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_11_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_13_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_11_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_17_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_09_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_13_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_17_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_09_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_d_11_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_17_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_11_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_d_11_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_11_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_13_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_17_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_15_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_09_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_11_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_d_11_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_11_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_17_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_11_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_09_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_17_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_09_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_13_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_13_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_09_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_17_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_11_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_13_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_13_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_11_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_17_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_13_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_17_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_13_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_15_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_13_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_17_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_15_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_13_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_11_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_09_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_11_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_17_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_17_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_17_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_17_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_13_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_11_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_09_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_11_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_15_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_17_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_11_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_15_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_17_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_13_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_d_11_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_17_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_11_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_09_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_09_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_11_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_11_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_09_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_09_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_17_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_11_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_13_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_13_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_15_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_13_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_17_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_13_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_11_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_17_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_13_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_17_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_11_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_13_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "li_dance_facedj_17_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_hu_15_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_hu_13_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_hu_13_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_hu_13_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_d_11_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_hu_13_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_d_11_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_d_11_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_d_11_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_hu_15_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_hu_15_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_d_11_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_hu_15_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_hu_13_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_hu_13_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_hu_13_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_hu_15_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_d_11_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_hu_15_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_d_11_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_hu_15_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_hu_13_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_hu_13_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_d_11_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_hu_15_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_d_11_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_hu_13_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_hu_13_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_hu_15_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_d_11_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_hu_15_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_hu_15_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_d_11_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_hu_13_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_hu_15_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_d_11_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_15_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_13_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_11_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_17_v2_female^2"},

    

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "trans_dance_crowd_mi_to_li_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "mi_dance_crowd_11_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "mi_dance_crowd_17_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "li_dance_crowd_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "trans_dance_crowd_mi_to_hi_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "trans_dance_crowd_li_to_mi_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "trans_dance_crowd_hi_to_li_07_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "mi_dance_crowd_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "trans_dance_crowd_li_to_hi_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "trans_dance_crowd_hi_to_li_07_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "hi_dance_crowd_17_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "trans_dance_crowd_li_to_hi_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "li_dance_crowd_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "mi_dance_crowd_11_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "li_dance_crowd_11_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "trans_dance_crowd_mi_to_hi_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "hi_dance_crowd_13_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "li_dance_crowd_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "trans_dance_crowd_hi_to_mi_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "mi_dance_crowd_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "trans_dance_crowd_mi_to_li_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "hi_dance_crowd_15_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "hi_dance_crowd_13_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "mi_dance_crowd_15_v1_prop_npc_phone^heel"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "trans_dance_crowd_mi_to_hi_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "li_dance_crowd_11_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "mi_dance_crowd_15_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "li_dance_crowd_17_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "li_dance_crowd_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "hi_dance_crowd_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "hi_dance_crowd_17_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "hi_dance_crowd_13_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "hi_dance_crowd_11_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "hi_dance_crowd_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "hi_dance_crowd_13_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "trans_dance_crowd_mi_to_li_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "li_dance_crowd_15_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "hi_dance_crowd_15_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "trans_dance_crowd_li_to_hi_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "mi_dance_crowd_13_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "trans_dance_crowd_li_to_mi_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "li_dance_crowd_17_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "mi_dance_crowd_13_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "li_dance_crowd_15_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "mi_dance_crowd_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "mi_dance_crowd_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "mi_dance_crowd_13_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "li_dance_crowd_13_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "hi_dance_crowd_17_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "trans_dance_crowd_mi_to_li_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "trans_dance_crowd_hi_to_li_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "trans_dance_crowd_li_to_hi_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "mi_dance_crowd_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "hi_dance_crowd_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "li_dance_crowd_17_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "li_dance_crowd_13_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "hi_dance_crowd_15_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "trans_dance_crowd_hi_to_mi_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "mi_dance_crowd_15_v1_prop_npc_phone^flat"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "li_dance_crowd_15_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "li_dance_crowd_13_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "mi_dance_crowd_13_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "trans_dance_crowd_hi_to_mi_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "hi_dance_crowd_15_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "trans_dance_crowd_mi_to_hi_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "trans_dance_crowd_li_to_mi_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "trans_dance_crowd_hi_to_mi_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "li_dance_crowd_13_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "li_dance_crowd_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "trans_dance_crowd_hi_to_li_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "mi_dance_crowd_15_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "mi_dance_crowd_15_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "hi_dance_crowd_11_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "trans_dance_crowd_li_to_mi_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "mi_dance_crowd_17_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "hi_dance_crowd_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "mi_dance_crowd_17_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "li_dance_crowd_15_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "mi_dance_crowd_17_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "mi_dance_crowd_15_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "li_dance_crowd_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "mi_dance_crowd_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "hi_dance_crowd_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "li_dance_crowd_17_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupa@", anim = "hi_dance_crowd_17_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "hi_dance_crowd_11_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "mi_dance_crowd_11_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_13_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "mi_dance_crowd_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "mi_dance_crowd_17_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "hi_dance_crowd_11_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "trans_dance_crowd_li_to_mi_11_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "trans_dance_crowd_li_to_mi_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "mi_dance_crowd_17_v1_prop_npc_phone^heel"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "hi_dance_crowd_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "trans_dance_crowd_li_to_mi_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "mi_dance_crowd_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "trans_dance_crowd_li_to_hi_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "trans_dance_crowd_hi_to_li_07_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_15_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "hi_dance_crowd_17_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_17_v1_prop_npc_phone^heel"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "mi_dance_crowd_13_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "mi_dance_crowd_17_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_09_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "hi_dance_crowd_13_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "trans_dance_crowd_mi_to_hi_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "hi_dance_crowd_13_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "mi_dance_crowd_09_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "hi_dance_crowd_17_v1_prop_npc_phone^heel"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "mi_dance_crowd_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "trans_dance_crowd_mi_to_li_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "hi_dance_crowd_15_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_13_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_11_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "hi_dance_crowd_17_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_11_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_11_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "mi_dance_crowd_15_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_17_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_11_v2_ba_prop_battle_vape_01^heel", disabled = true},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "hi_dance_crowd_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "hi_dance_crowd_11_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "hi_dance_crowd_15_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "trans_dance_crowd_hi_to_mi_09_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "hi_dance_crowd_09_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "mi_dance_crowd_15_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "hi_dance_crowd_13_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "mi_dance_crowd_13_v2_prop_npc_phone^heel", disabled = true},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "hi_dance_crowd_17_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "hi_dance_crowd_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "trans_dance_crowd_mi_to_li_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "trans_dance_crowd_mi_to_li_11_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "trans_dance_crowd_hi_to_li_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "hi_dance_crowd_15_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "hi_dance_crowd_15_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "trans_dance_crowd_hi_to_li_07_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "mi_dance_crowd_13_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_15_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "mi_dance_crowd_13_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "hi_dance_crowd_17_v1_prop_npc_phone^flat"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "hi_dance_crowd_13_v2_prop_npc_phone^flat"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "mi_dance_crowd_13_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "hi_dance_crowd_13_v2_prop_npc_phone^heel"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "trans_dance_crowd_mi_to_li_09_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "trans_dance_crowd_li_to_hi_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "hi_dance_crowd_17_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "trans_dance_crowd_li_to_hi_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "hi_dance_crowd_13_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "mi_dance_crowd_11_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "mi_dance_crowd_17_v1_prop_npc_phone^flat"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "mi_dance_crowd_11_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_11_v2_ba_prop_battle_vape_01^flat"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "trans_dance_crowd_hi_to_mi_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "mi_dance_crowd_15_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_11_v2_prop_npc_phone^heel"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_15_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_13_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "trans_dance_crowd_hi_to_mi_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_15_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "trans_dance_crowd_li_to_hi_09_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "mi_dance_crowd_13_v2_prop_npc_phone^flat"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "trans_dance_crowd_mi_to_hi_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_13_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_15_v2_prop_npc_phone^flat"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "trans_dance_crowd_hi_to_li_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_17_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "mi_dance_crowd_15_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "trans_dance_crowd_li_to_mi_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "mi_dance_crowd_17_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_15_v2_prop_npc_phone^heel"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_11_v2_prop_npc_phone^flat"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "li_dance_crowd_17_v1_prop_npc_phone^flat"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "mi_dance_crowd_17_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "trans_dance_crowd_hi_to_mi_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "mi_dance_crowd_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupb@", anim = "hi_dance_crowd_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "trans_dance_crowd_mi_to_li_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "trans_dance_crowd_li_to_mi_09_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "hi_dance_crowd_15_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "li_dance_crowd_15_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "hi_dance_crowd_09_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "li_dance_crowd_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "trans_dance_crowd_hi_to_li_07_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "trans_dance_crowd_li_to_hi_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "mi_dance_crowd_11_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "li_dance_crowd_11_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "trans_dance_crowd_hi_to_mi_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "trans_dance_crowd_hi_to_mi_09_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "mi_dance_crowd_15_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "trans_dance_crowd_li_to_hi_09_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "mi_dance_crowd_09_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "hi_dance_crowd_13_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "trans_dance_crowd_mi_to_hi_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "li_dance_crowd_11_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "trans_dance_crowd_hi_to_li_07_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "hi_dance_crowd_11_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "li_dance_crowd_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "hi_dance_crowd_13_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "hi_dance_crowd_17_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "hi_dance_crowd_13_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "hi_dance_crowd_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "hi_dance_crowd_17_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "li_dance_crowd_17_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "li_dance_crowd_15_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "trans_dance_crowd_li_to_hi_09_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "mi_dance_crowd_17_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "mi_dance_crowd_17_v1_prop_npc_phone"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "mi_dance_crowd_11_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "trans_dance_crowd_mi_to_li_11_v1_ba_prop_battle_vape_01"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "hi_dance_crowd_09_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "trans_dance_crowd_li_to_hi_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "hi_dance_crowd_17_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "hi_dance_crowd_15_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "li_dance_crowd_17_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "mi_dance_crowd_13_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "mi_dance_crowd_15_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "mi_dance_crowd_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "mi_dance_crowd_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "mi_dance_crowd_11_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "trans_dance_crowd_mi_to_hi_09_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "li_dance_crowd_09_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "li_dance_crowd_13_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "li_dance_crowd_15_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "trans_dance_crowd_mi_to_li_11_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "trans_dance_crowd_mi_to_li_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "trans_dance_crowd_hi_to_li_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "mi_dance_crowd_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "hi_dance_crowd_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "hi_dance_crowd_13_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "trans_dance_crowd_mi_to_li_11_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "mi_dance_crowd_13_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "li_dance_crowd_13_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "hi_dance_crowd_15_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "mi_dance_crowd_15_v1_prop_npc_phone"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "mi_dance_crowd_09_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "mi_dance_crowd_13_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "hi_dance_crowd_13_v1_prop_npc_phone", disabled = true},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "hi_dance_crowd_15_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "mi_dance_crowd_17_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "li_dance_crowd_09_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "trans_dance_crowd_hi_to_mi_09_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "trans_dance_crowd_li_to_mi_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "hi_dance_crowd_11_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "trans_dance_crowd_hi_to_mi_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "mi_dance_crowd_13_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "mi_dance_crowd_15_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "hi_dance_crowd_11_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "trans_dance_crowd_mi_to_li_11_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "mi_dance_crowd_17_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "li_dance_crowd_11_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "hi_dance_crowd_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "mi_dance_crowd_17_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "li_dance_crowd_15_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "trans_dance_crowd_mi_to_li_09_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "mi_dance_crowd_15_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "li_dance_crowd_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "li_dance_crowd_13_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "trans_dance_crowd_hi_to_li_09_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "li_dance_crowd_13_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupc@", anim = "hi_dance_crowd_17_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_17_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_hi_to_mi_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_15_v2_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_17_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_mi_to_li_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_13_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_li_to_hi_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_15_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_11_v2_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_li_to_hi_09_v2_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_13_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_hi_to_li_09_v1_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_09_v2_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_11_v1_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_15_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_13_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_11_v2_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_15_v2_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_15_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_15_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_13_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_13_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_mi_to_li_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_15_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_li_to_mi_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_15_v1_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_09_v1_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_mi_to_hi_09_v1_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_15_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_li_to_mi_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_15_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_mi_to_li_09_v2_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_hi_to_li_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_11_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_li_to_mi_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_15_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_li_to_hi_09_v1_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_mi_to_li_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_13_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_11_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_17_v1_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_15_v1_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_mi_to_li_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_15_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_17_v1_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_hi_to_mi_09_v1_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_09_v1_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_17_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_hi_to_mi_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_15_v1ba_prop_battle_vape_01^heel"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_13_v2_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_17_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_17_v1_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_hi_to_li_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_mi_to_li_11_v1_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_13_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_09_v2_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_hi_to_mi_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_11_v1_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_09_v2_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_li_to_mi_11_v1_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_13_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_li_to_mi_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_17_v2_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_13_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_17_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_15_v2_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_li_to_hi_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_mi_to_hi_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_17_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_13_v1_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_mi_to_hi_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_11_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_17_v2_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_13_v1_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_li_to_hi_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_13_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_15_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_11_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_17_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_11_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_13_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_15_v1ba_prop_battle_vape_01^flat"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_13_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_13_v1_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_09_v1_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_15_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_17_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_15_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_li_to_mi_09_v1_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_13_v2_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_15_v1_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_17_v1ba_prop_battle_vape_01^flat^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_hi_to_mi_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_11_v2_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_13_v2_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_17_v1ba_prop_battle_vape_01^heel^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_17_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "hi_dance_crowd_11_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_hi_to_mi_09_v2_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_17_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "li_dance_crowd_11_v1_male_^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "trans_dance_crowd_li_to_hi_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_17_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_mi_to_hi_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_hi_to_mi_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_11_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_17_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_mi_to_li_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_13_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_li_to_mi_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_li_to_hi_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_15_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_17_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_13_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_15_v2_prop_npc_phone^flat"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_11_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_15_v1_prop_npc_phone^flat"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_15_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_li_to_hi_09_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_13_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_13_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_15_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_15_v1_prop_npc_phone^heel"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_15_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_13_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_17_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_li_to_mi_09_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_13_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_15_v2_prop_npc_phone^heel"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_mi_to_li_09_v2_female^1", disabled = true},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_15_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_mi_to_li_11_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_17_v1_prop_npc_phone^flat", disabled = true},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_15_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_li_to_mi_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_15_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_11_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_hi_to_mi_09_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_17_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_15_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_li_to_hi_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_15_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_li_to_mi_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_15_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_hi_to_li_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_11_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_li_to_mi_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_mi_to_li_11_v1_prop_npc_phone^heel"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_li_to_mi_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_15_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_15_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_mi_to_li_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_13_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_11_v2_prop_npc_phone^heel", disabled = true},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_mi_to_li_09_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_13_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_11_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_11_v2_prop_npc_phone^flat", disabled = true},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_mi_to_li_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_17_v1_prop_npc_phone^heel"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_15_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_hi_to_li_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_13_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_13_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_17_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_hi_to_mi_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_17_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_hi_to_li_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_11_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_11_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_13_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_hi_to_mi_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_13_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_mi_to_li_11_v1_prop_npc_phone^flat"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_13_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_li_to_mi_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_13_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_17_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_li_to_hi_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_mi_to_hi_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_17_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_17_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_13_v1_prop_npc_phone^flat"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_mi_to_hi_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_11_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_li_to_hi_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_13_v1_prop_npc_phone^heel"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_13_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_15_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_11_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_17_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_11_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_13_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_13_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_li_to_mi_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_15_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_17_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_15_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_09_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_li_to_mi_11_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_15_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_11_v2_prop_npc_phone^flat"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_09_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_15_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_09_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_hi_to_mi_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_09_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_13_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_11_v2_prop_npc_phone^heel", disabled = true},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_11_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_17_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_17_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "hi_dance_crowd_11_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_17_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_hi_to_mi_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "mi_dance_crowd_17_v1_prop_npc_phone^flat"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "li_dance_crowd_17_v1_prop_npc_phone^heel"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@groupe@", anim = "trans_dance_crowd_li_to_hi_09_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v1_vape"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v1_mobile"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v1_mobile_heel"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v1_gropub_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v1_gropub_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v1_vap_heel", disabled = true},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_15_v1_vape_heel"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_17_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_17_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_13_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_13_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_13_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_13_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_13_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_13_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_11_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_11_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_11_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_11_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_11_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_13_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_13_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_13_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_13_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_13_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_13_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_17_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_17_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_17_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_11_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_11_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_11_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_17_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_17_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_17_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_09_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_09_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_09_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_09_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_09_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_17_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_17_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_17_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_17_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_17_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_17_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_09_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_09_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_09_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_09_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_13_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_13_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_13_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_13_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_13_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_15_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_15_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_15_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_15_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_15_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_13_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_13_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_13_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_13_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_13_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_13_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_13_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_13_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_13_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_13_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_13_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_13_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_09_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_09_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_09_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_09_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_09_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_17_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_17_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_17_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_17_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_17_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_17_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_13_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_11_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_11_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_11_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_11_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_11_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_13_v2_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_13_v2_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_11_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_11_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_11_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_13_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_13_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_13_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_13_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_13_v2_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_13_v2_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_13_v2_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_13_v2_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_15_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_11_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_11_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_13_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_13_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_13_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_13_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_13_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_13_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_13_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_13_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_15_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_15_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_15_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_15_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_17_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_15_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_17_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_17_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_17_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_17_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_17_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_15_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_09_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_09_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_09_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_17_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_17_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_17_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_09_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_13_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_17_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_17_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_17_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_15_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_15_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_15_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_15_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_15_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_15_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_13_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_13_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_13_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_13_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_13_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_13_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_13_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_13_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_13_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_13_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_13_v2_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_13_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_15_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_15_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_15_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_15_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_15_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_15_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_13_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_13_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_13_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_13_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_13_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_13_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_15_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_15_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_15_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_15_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_15_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_09_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_09_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_09_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_09_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_09_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_15_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_15_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_11_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_15_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_15_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_15_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_15_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_11_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_11_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_11_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_11_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_11_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_11_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_09_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_17_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_17_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_17_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_17_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_15_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_09_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_09_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_09_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_11_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_11_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_11_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_11_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_11_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "hi_dance_prop_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_13_v2_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_13_v2_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_13_v2_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_13_v2_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "li_dance_prop_13_v2_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_mi_to_li_11_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_mi_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_li_to_mi_11_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_mi_to_li_11_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_mi_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_li_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_mi_11_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_mi_11_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_li_09_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_li_09_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_li_to_mi_11_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_mi_09_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_li_to_hi_07_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_li_to_hi_07_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_li_09_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_mi_11_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_mi_09_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_li_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_mi_to_li_11_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_mi_to_li_11_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_mi_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_li_09_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_mi_09_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_mi_09_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_mi_11_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_mi_to_li_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_mi_09_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_mi_to_hi_11_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_li_to_mi_11_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_li_09_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_li_to_mi_11_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_mi_to_hi_11_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_mi_09_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_li_09_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_mi_to_li_11_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_li_to_hi_07_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_mi_to_hi_11_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_mi_to_li_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_mi_to_hi_11_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_li_09_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_li_to_mi_11_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_mi_09_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_mi_to_li_11_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_mi_to_hi_11_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_li_to_hi_07_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_mi_09_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_li_to_mi_11_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_li_to_mi_11_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_mi_to_li_11_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_mi_11_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_li_to_hi_07_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_mi_to_hi_11_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_mi_11_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_li_09_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_li_to_hi_07_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_mi_to_hi_11_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_mi_09_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_mi_to_hi_11_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_li_to_hi_07_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_mi_to_hi_11_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_li_to_mi_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_mi_09_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_li_09_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_mi_to_hi_11_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_li_to_mi_11_v1_male^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_li_to_hi_07_v1_male^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_mi_11_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_li_to_mi_11_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_mi_to_li_11_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_mi_09_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_li_to_hi_07_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_mi_11_v1_female^3"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_li_to_hi_07_v1_male^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_mi_11_v1_male^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_li_09_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_li_to_mi_11_v1_female^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_mi_to_li_11_v1_female^5"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_mi_to_li_11_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_li_to_hi_07_v1_male^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_li_to_hi_07_v1_male^2"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_mi_to_hi_11_v1_female^6"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_mi_to_hi_11_v1_female^1"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_hi_to_mi_11_v1_female^4"},

    { dict = "anim@amb@nightclub_island@dancers@crowddance_single_props_transitions@", anim = "trans_dance_prop_li_to_mi_11_v1_male^1"},

}







function LoadAnimationDic(dict)

    if not HasAnimDictLoaded(dict) then

        RequestAnimDict(dict)

        

        while not HasAnimDictLoaded(dict) do

            Citizen.Wait(0)

        end

    end

end







RegisterNetEvent('np:dances:dance')

AddEventHandler('np:dances:dance', function()

   

        local noAnimations = #animations

            pDance = math.random(noAnimations)

        LoadAnimationDic(animations[pDance].dict)

        TaskPlayAnim(PlayerPedId(), animations[pDance].dict, animations[pDance].anim, 3.0, 3.0, -1, 1, 0, 0, 0, 0)

        onDance = true

end)







Citizen.CreateThread(function()

  for k, v in pairs(DP.Emotes) do

   TriggerEvent("chat:addSuggestion", "/e " .. k, v[3])

 end

 for k, v in pairs(DP.PropEmotes) do

  TriggerEvent("chat:addSuggestion", "/e " .. k, v[3])

end

end)





Citizen.CreateThread(function()

  for k, v in pairs(DP.Walks) do

    local nazwa = string.lower(k)

   TriggerEvent("chat:addSuggestion", "/walk " .. nazwa, k)

 end

end)







function GetEmotes()

return DP.Emotes

end
