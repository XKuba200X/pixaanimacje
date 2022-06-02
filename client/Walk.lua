local latestClipset = nil

function WalkMenuStart(name)
  RequestWalking(name)
  SetPedMovementClipset(PlayerPedId(), name, 0.2)
  latestClipset = name
  --RemoveAnimSet(name)
end


RegisterNetEvent("dp:walkUpdated")
AddEventHandler("dp:walkUpdated", function(nazwaa)
print('styl chodzenia zaktualizowany na ' .. nazwaa)
end)


function RequestWalking(set)
  RequestAnimSet(set)
  while not HasAnimSetLoaded(set) do
    Citizen.Wait(1)
  end 
end

function RequestLatestStyle()
return latestClipset

end

function WalksOnCommand(source, args, raw)
  local WalksCommand = ""
  for a in pairsByKeys(DP.Walks) do
    WalksCommand = WalksCommand .. ""..string.lower(a)..", "
  end
  EmoteChatMessage(WalksCommand)
  EmoteChatMessage("To reset do /walk reset")
end

function WalkCommandStart(source, args, raw)
  local name = firstToUpper(args[1])
    TriggerServerEvent('dp:walkUpdate', name)
  if name == "Reset" then
      ResetPedMovementClipset(PlayerPedId()) 
      latestClipset = nil
      return     
  end


  local name2 = table.unpack(DP.Walks[name])
  if name2 ~= nil then
    WalkMenuStart(name2)
  else
    EmoteChatMessage("'"..name.."' is not a valid walk")
  end
end


function firstToUpper(str)
  return (str:gsub("^%l", string.upper))
end