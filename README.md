# TASToolKit
LUA Script Repository for [Dolphin LUA](https://github.com/SwareJonge/Dolphin-Lua-Core) by [SwareJonge](https://github.com/SwareJonge).

Check [TASToolKit Editor](https://github.com/malleoz/TASToolKitEditor) by [Malleo](https://github.com/malleoz) for a custom textfile editor regarding this toolkit.

This is made to enhance Mario Kart Kart TASing using Textfile-TASing and other various scripts.
TAS ToolKit (TTK) eliminates the tedious process of having to finish races and use TAS Code to follow your ghost path until you can make an improvement.
Loaded Ghost decoding/encoding allow for quick text-/table file saving and editing and lets the user steer the character with these. 

TTK comes with an progress autosave feature, so progress made that was not saved by accidentally loading a savestate is still stored.

### How to use:
* Download Swarejonge's custom LUA Dolphin Version
* Merge this folder with the custom LUA Dolphin version, so that the folder "Sys/Scripts/" gets merged and "MKW_Inputs/" appears in your Dolphin Root Folder
  * IF THE "MKW_Inputs/" FOLDER DOES NOT EXIST, THE SCRIPTS WILL CEASE TO WORK
  * The filePath is exchangable in [TASToolKit_config.lua](https://github.com/LordDraXula/TASToolKit/blob/master/Sys/Scripts/config/TASToolKit_config.lua)
* Follow the instructions on how to run a script in the [Dolphin LUA](https://github.com/SwareJonge/Dolphin-Lua-Core) repository


## TASing Tools / Scripts

```
MKW_GHOST_store_inputs.lua (stores the ghosts input from the internal mkw memory into the ~/MKW_Ghost_Inputs.csv input file)
MKW_GHOST_store_inputs_runner.lua (stores the ghosts input from the internal mkw memory into BOTH ~/MKW_Ghost_Inputs.csv AND ~/MKW_Player_Inputs.csv input files)
MKW_LUA_to_CSV.lua (copies the old ~/MKW_Inputs/MKW_Ghost_Inputs.lua to ~/MKW_Inputs/MKW_Ghost_Inputs.csv and the old ~/MKW_Inputs/MKW_Player_Inputs.lua to ~/MKW_Inputs/MKW_Player_Inputs.csv)
MKW_TAS_save_RKG_from_csv.lua (loads ~/MKW_Player_Inputs.csv and saves the input string into MKW_Player_Inputs.rkg and a copied rksys.dat save file)
```

### [MKW_TAS_Toolkit.lua](https://github.com/LordDraXula/TASToolKit/blob/master/Sys/Scripts/MKW_TAS_Toolkit.lua)
* Heart of the TASToolKit, used to run input text-files
* When loaded, uses MKW_Ghost_Inputs.csv AND MKW_Player_Inputs.csv input files to influence the ghosts and runners inputs
  * Player inputs are run by playing back the table they are loaded from, matching the current frame they are on
  * Ghost inputs are run by encoding the loaded table into *.rkg format and overwriting the data in the memory
* Updates with reloading the files after using a savestate to go back to an earlier frame than the current one

### [MKW_TAS_save_progress.lua](https://github.com/LordDraXula/TASToolKit/blob/master/Sys/Scripts/MKW_TAS_save_progress.lua)
* Saves your current progress made by decoding the temporary data in the memory
  * Saves your current driven Lap into MKW_Player_Inputs.csv
  * Saves an MKW_Player_Inputs.rkg ghost file
  * Can create a copy of the rksys.dat save file with the saved MKW_Player_Inputs.rkg in it
    * This is determined in [TASToolKit_config.lua](https://github.com/LordDraXula/TASToolKit/blob/master/Sys/Scripts/config/TASToolKit_config.lua)
* Can be run at any point during a Race, but neither before nor after
* highly enables Controller/TAS-Input TASing, as your full progress is immediately saved

### [_TTK_Autosave.lua](https://github.com/LordDraXula/TASToolKit/blob/master/Sys/Scripts/_TTK_Autosave.lua)
* Auto-runnable script, that starts at the beginning of the emulation
* Creates backup files from your current progress
* Creates an MKW_Inputs/_backup.csv file whenever a savestate is loaded
  * Settings are determined in [TASToolKit_config.lua](https://github.com/LordDraXula/TASToolKit/blob/master/Sys/Scripts/config/TASToolKit_config.lua)

## TTK_Lib

Includes a variety of functions for writing own ghost storage data based scripts.
More information can be found in the [TTK_Lib_READMII](https://github.com/LordDraXula/TASToolKit/blob/master/TTK_Lib_READMII.txt) or in the comments of [TTK_Lib.lua](https://github.com/LordDraXula/TASToolKit/blob/master/Sys/Scripts/MKW/TTK_Lib.lua)

To use TTK_Lib include the following lines in your script:
```lua
package.path = GetScriptsDir() .. "MKW/TTK_Lib.lua"
local TTK_Lib = require("TTK_Lib")
```

### List of functions

```lua
-- Enum constants:
TTK_Lib.PlayerTypeEnum = {player = 0, ghost = 1}
TTK_Lib.ControllerInputTypeEnum = {faceButton = 0, directionInput = 1, trickInput = 2}


-- Input encoding/decoding functions:
function decodeFaceButton(byte) -> byte, byte, byte
function decodeDirectionInput(byte) -> byte, byte
function decodeTrickInput(byte) -> byte
function encodeFaceButton(byte, byte, byte, byte) -> byte
function encodeDirectionInput(byte, byte) -> byte
function encodeTrickInput(byte) -> byte

-- Input-list encoding/decoding functions:
function decodeRKGData(table(byte), TTK_Lib.ControllerInputTypeEnum, table([byte, byte, byte, byte, byte, byte])) -> table([byte, byte, byte, byte, byte, byte])
function readRawRKGData(TTK_Lib.PlayerTypeEnum, TTK_Lib.ControllerInputTypeEnum, table(byte)) -> table(byte)
function readFullDecodedRKGData(TTK_Lib.PlayerTypeEnum) -> table([byte, byte, byte, byte, byte, byte])
function encodeRKGData(table([byte, byte, byte, byte, byte, byte])) -> table(byte), byte, byte, byte

-- String and table(byte) tools:
function byteArrayToString(table(byte)) -> string
function stringToByteArray(string) -> table(byte)

-- Misc:
function runInput({byte, byte, byte, byte, byte, byte})
```
