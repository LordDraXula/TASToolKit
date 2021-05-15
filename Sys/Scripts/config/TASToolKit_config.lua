local TTK_config = {}

-- enables [-7, 7] clamp instead of [0, 14]
TTK_config.useNegativeStickInput = false
-- creates up to TTK_config.backupAmount amounts of backup files for your race-inputs while you are TASing
-- set to 0 to disable backups
TTK_config.backupAmount = 8

TTK_config.textFilePath = {
	player = "MKW_Inputs/MKW_Player_Inputs.csv",
	ghost = "MKW_Inputs/MKW_Ghost_Inputs.csv",
	backup = "MKW_Inputs/_backup.csv"
}

-- rksys copy workflow on the saveProgress script:
-- if (createRKSYScopy): read originalRksysPath -> insert created rkg into download slot on license 1 -> save to rksysCopyFilePath
TTK_config.saveProgress = {
	rkgFilePath = "MKW_Inputs/MKW_Player_Inputs.rkg",
	createRKSYScopy = true,
	rksysCopyFilePath = "MKW_Inputs/rksys.dat",
	originalRksysPath = "User/Wii/title/00010004/524d4345/data/rksys.dat"
}

return TTK_config
