
package.path = GetScriptsDir() .. "MKW/CSV_Handler.lua"
local csv_handler = require("CSV_Handler")
package.path = GetScriptsDir() .. "MKW/MKW_RKG_saver.lua"
local rkg_saver = require("MKW_RKG_saver")
package.path = GetScriptsDir() .. "MKW/MKW_Pointers.lua"
local pointers = require("MKW_Pointers")
package.path = GetScriptsDir() .. "config/TASToolKit_config.lua"
local config = require("TASToolKit_config")

function onScriptStart()
	MsgBox("Script started.")
	
	
	local trackID = ReadValue32(pointers.getRaceDataPointer(), 0xB68)
	local vehicleID = ReadValue32(pointers.getRaceDataPointer(), 0x30)
	local characterID = ReadValue32(pointers.getRaceDataPointer(), 0x34)
	local driftID = ReadValue16(pointers.getInputDataPointer(), 0xC4)
	
	local csv_loaded, input_list = csv_handler.loadCSV(config.textFilePath.player)
	
	if (csv_loaded) then
		local rkgString, crc = rkg_saver.createRKGFile(input_list, trackID, vehicleID, characterID, driftID)
		
		local write_file = io.open(config.saveProgress.rkgFilePath, "wb")
		io.output(write_file)
		io.write(rkgString .. crc)
	
		if (config.saveProgress.createRKSYScopy) then
			rkg_saver.storeDownloadedGhost(rkgString, config.saveProgress.originalRksysPath, config.saveProgress.rksysCopyFilePath)
		end
	end

	CancelScript()
end

function onScriptCancel()
	MsgBox("Script ended.")
end
