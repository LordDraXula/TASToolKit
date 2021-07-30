-- general TAS Toolkit
-- used to do inputs of yourself and your ghost simultaneously


package.path = GetScriptsDir() .. "/MKW/MKW_core.lua"
local core = require("MKW_core")
package.path = GetScriptsDir() .. "/MKW/MKW_ghost_core.lua"
local ghost_core = require("MKW_ghost_core")
package.path = GetScriptsDir() .. "MKW/CSV_Handler.lua"
local csv_handler = require("CSV_Handler")
package.path = GetScriptsDir() .. "MKW/TTK_Lib.lua"
local TTK_Lib = require("TTK_Lib")
package.path = GetScriptsDir() .. "config/TASToolKit_config.lua"
local config = require("TASToolKit_config")

local input_ghost = {}
local input_runner = {}

local runner_loaded = false
local ghost_loaded = false

local activeState = 1
local stateAddress = 0x1500050

local prevFrame = core.getFrameOfInput() + 1

-- ###############################

function containsFrame(input_table, frame)
	return input_table[frame] ~= nil
end

-- ###############################

function onScriptStart()
	MsgBox("Script started.")
	
	WriteValue8(stateAddress, 0)
	WriteValue8(stateAddress + 0x1, 0)
	
	runner_loaded, input_runner = csv_handler.loadCSV(config.textFilePath.player)
	ghost_loaded, input_ghost = csv_handler.loadCSV(config.textFilePath.ghost)
	
	if (core.isSinglePlayer()) then
		ghost_loaded = false
	end

	if(ghost_loaded) then
		ghost_core.writeInputsIntoRKG(input_ghost)
	end
end

function onScriptCancel()
	MsgBox("Script ended.")
end

function onScriptUpdate()
	local currentFrame = core.getFrameOfInput() + 1
	local saveProg = 0
	
	if (prevFrame > currentFrame) or ((prevFrame + 3) < currentFrame) then
		WriteValue8(stateAddress, activeState)
	else
		activeState = ReadValue8(stateAddress)
		saveProg = ReadValue8(stateAddress + 0x1)		
	end

	
	if (saveProg == 1) then
		WriteValue8(stateAddress + 0x1, 0)
	
		local input_list = TTK_Lib.readFullDecodedRKGData(TTK_Lib.PlayerTypeEnum.player)
		if (input_list == nil) then
			MsgBox("The Script can't be used after the race ended")
		else
			if (csv_handler.writeCSV(config.textFilePath.player, input_list) == 1) then
				MsgBox(config.textFilePath.player .. " is currently locked by another program, make sure to close it there first.")
			end
			if (csv_handler.writeCSV(config.textFilePath.ghost, input_list) == 1) then
				MsgBox(config.textFilePath.ghost .. " is currently locked by another program, make sure to close it there first.")
			end
		end
	end
	
	
	if (activeState == 1) then
		if(runner_loaded) then
			if containsFrame(input_runner, currentFrame) then
				TTK_Lib.runInput(input_runner[currentFrame])
			end
		end

		if (prevFrame > currentFrame) or ((prevFrame + 3) < currentFrame) then
			runner_loaded, input_runner = csv_handler.loadCSV(config.textFilePath.player)
			ghost_loaded, input_ghost = csv_handler.loadCSV(config.textFilePath.ghost)
			if (core.isSinglePlayer()) then
				ghost_loaded = false
			end
			if(ghost_loaded) then
				ghost_core.writeInputsIntoRKG(input_ghost)
			end
		end

	end
	
	prevFrame = currentFrame
end

function onStateLoaded()
	runner_loaded, input_runner = csv_handler.loadCSV(config.textFilePath.player)
	ghost_loaded, input_ghost = csv_handler.loadCSV(config.textFilePath.ghost)
	if (core.isSinglePlayer()) then
		ghost_loaded = false
	end
	if(ghost_loaded) then
		ghost_core.writeInputsIntoRKG(input_ghost)
	end
	
	prevFrame = core.getFrameOfInput() + 1
end

function onStateSaved()

end
