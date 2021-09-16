----- GLOBAL VARIABLES -----
package.path = GetScriptsDir() .. "MKW/MKW_core.lua"
local core = require("MKW_core")

package.path = GetScriptsDir() .. "MKW/MKW_Pointers.lua"
local Pointers = require("MKW_Pointers")
--Add an underscore (_) to the beginning of the filename if you want the script to auto launch once you start a game!

local xRotPrev = 0
local yRotPrev = 0
local zRotPrev = 0
local xRot = 0
local yRot = 0
local zRot = 0
local xRotSpeed = 0
local yRotSpeed = 0
local zRotSpeed = 0
local curFrame = 0

function onScriptStart()
	if GetGameID() ~= "RMCP01" and GetGameID() ~= "RMCJ01" and GetGameID() ~= "RMCE01" and GetGameID() ~= "RMCK01" then
		SetScreenText("")
		CancelScript()
	end
	
	xRotPrev = core.calculateEuler().X
	yRotPrev = core.calculateEuler().Y
	zRotPrev = core.calculateEuler().Z
	
	curFrame = GetFrameCount()
end

function onScriptCancel()
	SetScreenText("")
end

function onScriptUpdate()

	if GetFrameCount() ~= curFrame then
		xRot = core.calculateEuler().X
		yRot = core.calculateEuler().Y
		zRot = core.calculateEuler().Z
		xRotSpeed = xRot - xRotPrev
		yRotSpeed = yRot - yRotPrev
		zRotSpeed = zRot - zRotPrev
		xRotPrev = xRot
		yRotPrev = yRot
		zRotPrev = zRot
	end

  local text = ""
	text = text .. string.format("\nFrame: %d", core.getFrameOfInput())
	text = text .. "\n\n===== Speed ====="
	text = text .. string.format("\nX: %8.4f | Y: %8.4f | Z: %8.4f \nXZ: %12.8f | XYZ: %12.8f", core.getSpd().X, core.getSpd().Y, core.getSpd().Z, core.getSpd().XZ, core.getSpd().XYZ)
	text = text .. "\n\n===== Acceleration ====="
	text = text .. string.format("\nAction: %s | %s \nBoost: %d | Normal: %1.4f | Wheelie: %1.4f \nDrift: %1.4f | Offroad: %1.4f", core.AccelRates().A, core.AccelRates().N, core.AccelRates().B, core.AccelRates().H, core.AccelRates().W, core.AccelRates().D, core.AccelRates().O)
if core.isSinglePlayer() == false then
	local fd = core.calculateDifference(core.calculateEuler().Y).D -- facing direction difference
	local fi = core.calculateDifference(core.calculateEuler().Y).I
	local md = core.calculateDifference(core.calculateDirection().Y).D -- moving direction difference
	local mi = core.calculateDifference(core.calculateDirection().Y).I
	local fy = core.calculateDirection().FY -- finish line direction
	local fyd = core.calculateDifference(fy).D -- finish direction difference
	local fyi = core.calculateDifference(fy).I
	text = text .. "\n\n===== Time Difference ====="
	text = text .. string.format("\nFacing: %11.6f | %8.3f f (%s) \nMoving: %11.6f | %8.3f f (%s) \nFinish: %11.6f | %8.4f f (%s)", fd, fd*60, core.differenceText(fd, fi), md, md*60, core.differenceText(md, mi), fyd, fyd*60, core.differenceText(fyd, fyi))
end
	text = text .. "\n\n===== Rotation ====="
	text = text .. string.format("\nFacing X (Pitch): %8.4f \nFacing Y (Yaw): %8.4f \nMoving Y (Yaw) %8.4f \nFacing Z (Roll): %8.4f", core.calculateEuler().X, core.calculateEuler().Y, core.calculateDirection().Y, core.calculateEuler().Z)
	
	SetScreenText(text)
end

function onStateLoaded()

end

function onStateSaved()

end
