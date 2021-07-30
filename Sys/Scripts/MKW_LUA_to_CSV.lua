
function onScriptStart()
	MsgBox("Script started.")
	
	package.path = GetScriptsDir() .. "MKW/CSV_Handler.lua"
	local csv_handler = require("CSV_Handler")
	
	package.path = "MKW_Inputs/?.lua"
	local runner_loaded, input_runner = pcall(require, "MKW_Player_Inputs")
	local ghost_loaded, input_ghost = pcall(require, "MKW_Ghost_Inputs")

	MsgBox(string.format("%s, %s", tostring(runner_loaded), tostring(ghost_loaded)))

	if(runner_loaded) then
		csv_handler.writeCSV("MKW_Inputs/MKW_Player_Inputs.csv", input_runner)
	end
	
	if(ghost_loaded) then
		csv_handler.writeCSV("MKW_Inputs/MKW_Ghost_Inputs.csv", input_ghost)
	end

	CancelScript()
end

function onScriptCancel()
	MsgBox("Script ended.")
end
