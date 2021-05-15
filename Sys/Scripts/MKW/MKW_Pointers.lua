local Pointers = {}

local function getInputDataPointer()
  local inputData
  if GetGameID() == "RMCP01" then inputData = 0x9BD70C
  elseif GetGameID() == "RMCE01"then inputData = 0x9B8F4C
  elseif GetGameID() == "RMCJ01" then inputData = 0x9BC76C
  elseif GetGameID() == "RMCK01" then inputData = 0x9ABD4C
  end
  return inputData
end
Pointers.getInputDataPointer = getInputDataPointer

local function getRaceDataPointer()
  local raceData
  if GetGameID() == "RMCP01" then raceData = 0x9BD728
  elseif GetGameID() == "RMCE01"then raceData = 0x9B8F68
  elseif GetGameID() == "RMCJ01" then raceData = 0x9BC788
  elseif GetGameID() == "RMCK01" then raceData = 0x9ABD68
  end
  return raceData
end
Pointers.getRaceDataPointer = getRaceDataPointer

local function getRaceData2Pointer(Offset)
  local raceData2
  if GetGameID() == "RMCP01" then raceData2 = 0x9BD730
  elseif GetGameID() == "RMCE01"then raceData2 = 0x9B8F70
  elseif GetGameID() == "RMCJ01" then raceData2 = 0x9BC790
  elseif GetGameID() == "RMCK01" then raceData2 = 0x9ABD70
  end
  return GetPointerNormal(raceData2, 0xC, Offset)
end
Pointers.getRaceData2Pointer = getRaceData2Pointer

local function getInputPointer(Offset)
  return ReadValue32(getRaceData2Pointer(Offset), 0x48, 0x4)
end
Pointers.getInputPointer = getInputPointer

local function getRKSYSPointer()
  local saveData
  if GetGameID() == "RMCP01" then saveData = 0x9BD748
  elseif GetGameID() == "RMCE01"then saveData = 0x9B8F88
  elseif GetGameID() == "RMCJ01" then saveData = 0x9BC7A8
  elseif GetGameID() == "RMCK01" then saveData = 0x9ABD88
  end
  return GetPointerNormal(saveData, 0x14, 0x0)
end
Pointers.getRKSYSPointer = getRKSYSPointer

local function getPrevPositionPointer(Offset)
  local pointer
  if GetGameID() == "RMCP01" then pointer = 0x9C18F8
  elseif GetGameID() == "RMCE01"then pointer = 0x9BD110
  elseif GetGameID() == "RMCJ01" then pointer = 0x9C0958
  elseif GetGameID() == "RMCK01" then pointer = 0x9AFF38
  end
  return GetPointerNormal(pointer, 0xC, 0x10, Offset, 0x0, 0x8, 0x90)
end
Pointers.getPrevPositionPointer = getPrevPositionPointer

local function getPositionPointer(Offset)
  local pointer
  if GetGameID() == "RMCP01" then pointer = 0x9C18F8
  elseif GetGameID() == "RMCE01"then pointer = 0x9BD110
  elseif GetGameID() == "RMCJ01" then pointer = 0x9C0958
  elseif GetGameID() == "RMCK01" then pointer = 0x9AFF38
  end
  return GetPointerNormal(pointer, 0xC, 0x10, Offset, 0x0, 0x8, 0x90, 0x4)
end
Pointers.getPositionPointer = getPositionPointer

local function getPlayerBasePointer(Offset)
  local pointer
  if GetGameID() == "RMCP01" then pointer = 0x9C18F8
  elseif GetGameID() == "RMCE01"then pointer = 0x9BD110
  elseif GetGameID() == "RMCJ01" then pointer = 0x9C0958
  elseif GetGameID() == "RMCK01" then pointer = 0x9AFF38
  end
  return ReadValue32(pointer, 0xC, 0x10, Offset, 0x10, 0x10)
end
Pointers.getPlayerBasePointer = getPlayerBasePointer

local function getFrameOfInputAddress()
  local frameaddress
  if GetGameID() == "RMCP01" then frameaddress = 0x9C38C0
  elseif GetGameID() == "RMCE01" then frameaddress = 0x9BF0B8
  elseif GetGameID() == "RMCJ01" then frameaddress = 0x9C2920
  elseif GetGameID() == "RMCK01" then frameaddress = 0x9B1F00
  end
  return frameaddress
end
Pointers.getFrameOfInputAddress = getFrameOfInputAddress

return Pointers
