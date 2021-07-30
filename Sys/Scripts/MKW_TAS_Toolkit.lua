-- general TAS Toolkit
-- used to do inputs of yourself and your ghost simultaneously

-- IMPORTANT: to use this, you first need to create a mkw_input_reader_ghost.lua file by running the MKW_ghost_store_inputs.lua script after the ghost and track has been fully loaded
-- ALSO: use MKW_ghost_store_inputs_runner.lua to both create a runner and a ghost file

-- once both created files are existing, you don't need to run the named script again and can edit both runner and ghost according to the pattern it was created, including adding and deleting lines

-- WARNING: this version reloads the input files on every frame, which causes huge frame drops, only use with the attempt of TASing


package.path = GetScriptsDir() .. "/MKW/MKW_Core.lua"
local core = require("MKW_Core")
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

local prevFrame = core.getFrameOfInput() + 1

-- ###############################

function containsFrame(input_table, frame)
	return input_table[frame] ~= nil
end

-- ###############################

function onScriptStart()
	MsgBox("Script started.")
	
	runner_loaded, input_runner = csv_handler.loadCSV(config.textFilePath.player)
	ghost_loaded, input_ghost = csv_handler.loadCSV(config.textFilePath.ghost)

	MsgBox(string.format("%s, %s", tostring(runner_loaded), tostring(ghost_loaded)))

	if(ghost_loaded) then
		ghost_core.writeInputsIntoRKG(input_ghost)
	end
end

function onScriptCancel()
	MsgBox("Script ended.")
end

function onScriptUpdate()
	local currentFrame = core.getFrameOfInput() + 1

	if(runner_loaded) then
		if containsFrame(input_runner, currentFrame) then
			TTK_Lib.runInput(input_runner[currentFrame])
		end
	end

	if currentFrame < prevFrame then
		if(runner_loaded) then
			_, input_runner = csv_handler.loadCSV(config.textFilePath.player)
		end
		if(ghost_loaded) then
			_, input_ghost = csv_handler.loadCSV(config.textFilePath.ghost)
			ghost_core.writeInputsIntoRKG(input_ghost)
		end
	end

	prevFrame = currentFrame

end

function onStateLoaded()
	if(runner_loaded) then
		_, input_runner = csv_handler.loadCSV(config.textFilePath.player)
	end
	if(ghost_loaded) then
		_, input_ghost = csv_handler.loadCSV(config.textFilePath.ghost)
		ghost_core.writeInputsIntoRKG(input_ghost)
	end
	prevFrame = core.getFrameOfInput() + 1
end

function onStateSaved()

end
