[
	// Global var name
	"MAI_AiEnable",
	// Setting type
	"CHECKBOX",
	// Title, Tooltip
	[
		localize "STR_MAI_AiEnable",
		localize "STR_MAI_AiEnableShort"
	],
	// Category, Subcategory
	["Madin AI", "1. Main"],
	// Extra params, depending on settings type
	true,
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_moveDistance",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		localize "STR_MAI_moveDistance",
		localize "STR_MAI_moveDistanceShort"
	],
	// Category, Subcategory
	["Madin AI", "1. Main"],
	// Extra params, depending on settings type
	[0, 1000, 300, 0],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_AiForceFormation",
	// Setting type
	"CHECKBOX",
	// Title, Tooltip
	[
		localize "STR_MAI_AiForceFormation",
		localize "STR_MAI_AiForceFormationShort"
	],
	// Category, Subcategory
	["Madin AI", "1. Main"],
	// Extra params, depending on settings type
	false,
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_PTSDsuppress",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		localize "STR_MAI_PTSDsuppress",
		localize "STR_MAI_PTSDsuppressShort"
	],
	// Category, Subcategory
	["Madin AI", "2. AI PTSD"],
	// Extra params, depending on settings type
	[0, 1, 0.1, 3],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_suppressFactor",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		localize "STR_MAI_suppressFactor",
		localize "STR_MAI_suppressFactorShort"
	],
	// Category, Subcategory
	["Madin AI", "2. AI PTSD"],
	// Extra params, depending on settings type
	[0, 0.9, 0, 3],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_PTSDfactor",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		localize "STR_MAI_PTSDfactor",
		localize "STR_MAI_PTSDfactorShort"
	],
	// Category, Subcategory
	["Madin AI", "2. AI PTSD"],
	// Extra params, depending on settings type
	[0.01, 1, 0.03, 3],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_PTSDhit",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		localize "STR_MAI_PTSDhit",
		localize "STR_MAI_PTSDhitShort"
	],
	// Category, Subcategory
	["Madin AI", "2. AI PTSD"],
	// Extra params, depending on settings type
	[0, 1, 0, 3],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_PTSDkilled",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		localize "STR_MAI_PTSDkilled",
		localize "STR_MAI_PTSDkilledShort"
	],
	// Category, Subcategory
	["Madin AI", "2. AI PTSD"],
	// Extra params, depending on settings type
	[0, 1, 0.1, 3],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_PTSDstopMove",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"STR_MAI_PTSDstopMove",
		"STR_MAI_PTSDstopMoveShort"
	],
	// Category, Subcategory
	["Madin AI", "2. AI PTSD"],
	// Extra params, depending on settings type
	[0, 10, 0.5, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_allowFlee",
	// Setting type
	"CHECKBOX",
	// Title, Tooltip
	[
		localize "STR_MAI_allowFlee",
		localize "STR_MAI_allowFleeShort"
	],
	// Category, Subcategory
	["Madin AI", "2. AI PTSD"],
	// Extra params, depending on settings type
	false,
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_PTSDflee",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"STR_MAI_PTSDflee",
		"STR_MAI_PTSDfleeShort"
	],
	// Category, Subcategory
	["Madin AI", "2. AI PTSD"],
	// Extra params, depending on settings type
	[0, 10, 1.5, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_PTSDfleeDistance",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"STR_MAI_PTSDfleeDistance",
		"STR_MAI_PTSDfleeDistanceShort"
	],
	// Category, Subcategory
	["Madin AI", "2. AI PTSD"],
	// Extra params, depending on settings type
	[100, 500, 150, 0],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_objSightDistance",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		localize "STR_MAI_objSightDistance",
		localize "STR_MAI_objSightDistanceShort"
	],
	// Category, Subcategory
	["Madin AI", "3. Sight Adjust"],
	// Extra params, depending on settings type
	[0, 50, 30, 0],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_AiSightCoefFactor",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		localize "STR_MAI_AiSightCoefFactor",
		localize "STR_MAI_AiSightCoefFactorShort"
	],
	// Category, Subcategory
	["Madin AI", "3. Sight Adjust"],
	// Extra params, depending on settings type
	[0, 1, 0.02, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_camoObjDistance",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		localize "STR_MAI_camoObjDistance",
		localize "STR_MAI_camoObjDistanceShort"
	],
	// Category, Subcategory
	["Madin AI", "3. Sight Adjust"],
	// Extra params, depending on settings type
	[0, 50, 20, 0],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_camoCoefFactor",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		localize "STR_MAI_camoCoefFactor",
		localize "STR_MAI_camoCoefFactorShort"
	],
	// Category, Subcategory
	["Madin AI", "3. Sight Adjust"],
	// Extra params, depending on settings type
	[0, 1, 0.05, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_AiSkillAdjust",
	// Setting type
	"CHECKBOX",
	// Title, Tooltip
	[
		localize "STR_MAI_AiSkillAdjust",
		localize "STR_MAI_AiSkillAdjustShort"
	],
	// Category, Subcategory
	["Madin AI - AI skill", "AI skill"],
	// Extra params, depending on settings type
	true,
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_aimingAccuracy",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Aiming accuracy",
		"Affects how well the AI compensates for weapon dispersion."
	],
	// Category, Subcategory
	["Madin AI - AI skill", "AI skill"],
	// Extra params, depending on settings type
	[0, 1, 0.35, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_aimingShake",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Aiming shake",
		"Affects how quickly the AI can rotate and stabilize its aim."
	],
	// Category, Subcategory
	["Madin AI - AI skill", "AI skill"],
	// Extra params, depending on settings type
	[0, 1, 0.35, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_spotDistance",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Spot distance",
		"Affects the AI ability to spot targets within it's visual or audible range."
	],
	// Category, Subcategory
	["Madin AI - AI skill", "AI skill"],
	// Extra params, depending on settings type
	[0, 1, 0.8, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_spotTime",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Spot time",
		"Affects how quick the AI react to death, damage or observing an enemy."
	],
	// Category, Subcategory
	["Madin AI - AI skill", "AI skill"],
	// Extra params, depending on settings type
	[0, 1, 0.8, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_courage",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Courage",
		"Affects unit's subordinates morale / suppression time."
	],
	// Category, Subcategory
	["Madin AI - AI skill", "AI skill"],
	// Extra params, depending on settings type
	[0, 1, 0, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_Commanding",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"commanding",
		"Affects how quickly recognized targets are shared with the group."
	],
	// Category, Subcategory
	["Madin AI - AI skill", "AI skill"],
	// Extra params, depending on settings type
	[0, 1, 1, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_aimingSpeed",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Aiming speed",
		"Affects how quickly the AI can rotate and stabilize its aim."
	],
	// Category, Subcategory
	["Madin AI - AI skill", "AI skill"],
	// Extra params, depending on settings type
	[0, 1, 0.7, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_general",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"General",
		"Raw 'Skill', value is distributed to sub-skills unless defined otherwise. Affects the AI's decision making."
	],
	// Category, Subcategory
	["Madin AI - AI skill", "AI skill"],
	// Extra params, depending on settings type
	[0, 1, 1, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_endurance",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Endurance",
		"Disabled in Arma3(?). Can be set, so it stays here."
	],
	// Category, Subcategory
	["Madin AI - AI skill", "AI skill"],
	// Extra params, depending on settings type
	[0, 1, 1, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_reloadSpeed",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Reload speed",
		"Affects the delay between switching or reloading a weapon."
	],
	// Category, Subcategory
	["Madin AI - AI skill", "AI skill"],
	// Extra params, depending on settings type
	[0, 1, 0.8, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_randomSkill",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Random skill",
		"Randomly sets higher/lower every skill by 0 to this number."
	],
	// Category, Subcategory
	["Madin AI - AI skill", "AI skill"],
	// Extra params, depending on settings type
	[0, 1, 0.15, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_AiBonusMags",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"STR_MAI_AiBonusMags",
		"STR_MAI_AiBonusMagsShort"
	],
	// Category, Subcategory
	["Madin AI - AI skill", "AI Additional options"],
	// Extra params, depending on settings type
	[-1, 100, -1, 0],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;


[
	// Global var name
	"MAI_enableAimPenalty",
	// Setting type
	"CHECKBOX",
	// Title, Tooltip
	[
		"STR_MAI_enableAimPenalty",
		"STR_MAI_enableAimPenaltyShort"
	],
	// Category, Subcategory
	["Madin AI - AI skill", "AI Penalty"],
	// Extra params, depending on settings type
	false,
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_aimPenaltyTime",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"STR_MAI_aimPenaltyTime",
		"STR_MAI_aimPenaltyTimeShort"
	],
	// Category, Subcategory
	["Madin AI - AI skill", "AI Penalty"],
	// Extra params, depending on settings type
	[1, 120, 30, 0],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_aimPenaltyStrength",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"STR_MAI_aimPenaltyStrength",
		"STR_MAI_aimPenaltyStrengthShort"
	],
	// Category, Subcategory
	["Madin AI - AI skill", "AI Penalty"],
	// Extra params, depending on settings type
	[0, 5, 1, 1],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"MAI_aimPenaltyMax",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"STR_MAI_aimPenaltyMax",
		"STR_MAI_aimPenaltyMaxShort"
	],
	// Category, Subcategory
	["Madin AI - AI skill", "AI Penalty"],
	// Extra params, depending on settings type
	[0, 100, 30, 0],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;