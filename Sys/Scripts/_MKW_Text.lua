----- GLOBAL VARIABLES -----
package.path = GetScriptsDir() .. "MKW/MKW_core.lua"
local core = require("MKW_core")
package.path = GetScriptsDir() .. "MKW/Math_core.lua"
local math_core = require("Math_core")

package.path = GetScriptsDir() .. "MKW/MKW_Pointers.lua"
local Pointers = require("MKW_Pointers")
--Add an underscore (_) to the beginning of the filename if you want the script to auto launch once you start a game!


function onScriptStart()
	if GetGameID() ~= "RMCP01" and GetGameID() ~= "RMCJ01" and GetGameID() ~= "RMCE01" and GetGameID() ~= "RMCK01" then
		SetScreenText("")
		CancelScript()
	end
end

function onScriptCancel()
	SetScreenText("")
end

function onScriptUpdate()

  local text = ""
	text = text .. string.format("\nFrame: %d\n", core.getFrameOfInput())
	text = text .. "\n\n===== Speed ====="
	text = text .. string.format("\nX: %12.6f\nY: %12.6f\nZ: %12.6f\nXZ: %11.6f\nXYZ: %10.6f", core.getSpd().X, core.getSpd().Y, core.getSpd().Z, core.getSpd().XZ, core.getSpd().XYZ)
	text = text .. "\n\n===== Rotation (Facing|Moving) ====="
	text = text .. string.format("\nX: %6.2f | %6.2f \nY: %6.2f | %6.2f \nZ: %6.2f | %6.2f", core.calculateEuler().X, core.calculateDirectX(), core.calculateEuler().Y, core.calculateDirectY(), core.calculateEuler().Z, core.calculateDirectZ())
	local playerStart, playerMoveFull, ghostStart, ghostMoveFull = core.getPos(), core.getSpd(), core.getPosGhost(), core.getSpdGhost()
	local playerMove = {X = playerMoveFull.X, Y = playerMoveFull.Y, Z = playerMoveFull.Z}
if core.isSinglePlayer() == false then
	local ghostMove = {X = ghostMoveFull.X, Y = ghostMoveFull.Y, Z = ghostMoveFull.Z}
	local distance = math_core.vectorMovementDifferenceXZ(playerStart, playerMove, ghostStart, ghostMove)
	local avgSpeed = (playerMoveFull.XZ + ghostMoveFull.XZ) / 2
	
	text = text .. "\n\n===== Time Difference ====="
	text = text .. string.format("\nDistance: %11.6f \nFrames: %11.6f \nTime: %11.6f", distance, distance/avgSpeed, (distance/avgSpeed)/60)
end
	local finishLine = core.getFinishLine()
	local XYZ1, XYZ2 = {X = finishLine.X1, Y = 0, Z = finishLine.Z1}, {X = finishLine.X2, Y = 0, Z = finishLine.Z2}
	
	local distance = math_core.distanceToLineXZ(playerStart, playerMove, XYZ1, math_core.subtractVector(XYZ2, XYZ1))

	text = text .. "\n\n===== Distance to Finish line ====="
	text = text .. string.format("\nDistance: %11.6f \nFrames: %11.6f \nTime: %11.6f", distance, distance/playerMoveFull.XZ, (distance/playerMoveFull.XZ)/60)

	SetScreenText(text)
end

function onStateLoaded()

end

function onStateSaved()

end
