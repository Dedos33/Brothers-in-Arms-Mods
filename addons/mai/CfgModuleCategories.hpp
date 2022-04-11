
class CfgFactionClasses
{
	class NO_CATEGORY;
	class MAI_Modules: NO_CATEGORY
	{
		displayName = "Brothers in Arms - MAI";
		//side = 7;
	};
};

class CfgVehicles
{
	class Logic;
	class Module_F: Logic
	{
		class AttributesBase
		{
			class Default;
			class Edit; // Default edit box (i.e., text input field)
			class Combo; // Default combo box (i.e., drop-down menu)
			class Checkbox; // Default checkbox (returned value is Bool)
			class CheckboxNumber; // Default checkbox (returned value is Number)
			class ModuleDescription; // Module description
			class Units; // Selection of units on which the module is applied
		};
		// Description base classes, for more information see below
		class ModuleDescription
		{
			class AnyBrain;
		};
	};
	class MAI_ModuleBuildSpawn: Module_F
	{
		// Standard object definitions
		scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = "Build Spawn"; // Name displayed in the menu
		category = "MAI_Modules";

		// Name of function triggered once conditions are met
		function = "MAI_fnc_buildSpawnInitCall";
		// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		functionPriority = 1;
		// 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isGlobal = 0;
		// 1 for module waiting until all synced triggers are activated
		isTriggerActivated = 0;
		// 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
		isDisposable = 1;
		// // 1 to run init function in Eden Editor as well
		is3DEN = 1;

		canSetArea = 1;
		canSetAreaHeight = 0;
		canSetAreaShape = 1;

		// Menu displayed when the module is placed or double-clicked on by Zeus
		//curatorInfoType = "RscDisplayAttributeModuleNuke";

		class AttributeValues
		{
			size2[] = {100, 100};
			size3[] = {100, 100, -1};
			isRectangle=0;
		};

		// Module attributes, uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific
		class Attributes: AttributesBase
		{
			// Arguments shared by specific module type (have to be mentioned in order to be present)

			class activationAdd: Default
  			{
				displayName = "$STR_MAI_activation";
				tooltip = "$STR_MAI_activationShort";
				defaultValue = "500";
				property = "activationAdd";
				expression = "_this setVariable ['%s',_value];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class deactivation: Default
  			{
				displayName = "$STR_MAI_deactivation";
				tooltip = "$STR_MAI_deactivationShort";
				defaultValue = "-1";
				property = "deactivation";
				expression = "_this setVariable ['%s',_value];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class tickets: Default
  			{
				displayName = "$STR_MAI_tickets";
				tooltip = "$STR_MAI_ticketsShort";
				defaultValue = "20";
				property = "tickets";
				expression = "_this setVariable ['%s',_value max 0];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class minDist: Default
  			{
				displayName = "$STR_MAI_minDist";
				tooltip = "$STR_MAI_minDistShort";
				defaultValue = "35";
				property = "minDistance";
				expression = "_this setVariable ['%s',_value max 0];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class groupCount: Default
  			{
				displayName = "$STR_MAI_groupCount";
				tooltip = "$STR_MAI_groupCountShort";
				defaultValue = "1";
				property = "groupCount";
				expression = "_this setVariable ['%s',_value max 0];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class patrolCount: Default
  			{
				displayName = "$STR_MAI_patrolCount";
				tooltip = "$STR_MAI_patrolCountShort";
				defaultValue = "6";
				property = "patrolCount";
				expression = "_this setVariable ['%s',_value max 0];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class minimalCount: Default
  			{
				displayName = "$STR_MAI_minimalCount";
				tooltip = "$STR_MAI_minimalCountShort";
				defaultValue = "2";
				property = "minimalCount";
				expression = "_this setVariable ['%s',_value max 0];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class maxWait: Default
  			{
				displayName = "$STR_MAI_maxWait";
				tooltip = "$STR_MAI_maxWaitShort";
				defaultValue = "180";
				property = "maxWait";
				expression = "_this setVariable ['%s',_value max 0];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class limitBuilding: Default
  			{
				displayName = "$STR_MAI_limitBuilding";
				tooltip = "$STR_MAI_limitBuildingShort";
				defaultValue = "2";
				property = "limitBuilding";
				expression = "_this setVariable ['%s',_value max 1];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class spawnChance: Default
  			{
				displayName = "$STR_MAI_spawnChance";
				tooltip = "$STR_MAI_spawnChanceShort";
				defaultValue = "100";
				property = "spawnChance";
				expression = "_this setVariable ['%s',_value];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class stationaryTime: Default
            {
                displayName = "$STR_MAI_stationaryTime";
                tooltip = "$STR_MAI_stationaryTimeShort";
                property = "stationaryTime";
                defaultValue = "[30,120,180]";
				expression = "_this setVariable ['%s', _value];";
                typeName = "ARRAY";
				control = "Timeout";
            };
			class spawnPerBuilding: Default
            {
                displayName = "$STR_MAI_spawnPerBuilding";
                tooltip = "$STR_MAI_spawnPerBuildingShort";
                property = "spawnPerBuilding";
                defaultValue = "[1,1.5,3]";
				expression = "_this setVariable ['%s', _value];";
                typeName = "ARRAY";
				control = "Timeout";
            };
			class spawnHalfLimit: Default
  			{
				displayName = "$STR_MAI_spawnHalfLimit";
				tooltip = "$STR_MAI_spawnHalfLimitShort";
				defaultValue = "8";
				property = "spawnHalfLimit";
				expression = "_this setVariable ['%s',_value];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class defendOnly: Checkbox
            {
                displayName = "$STR_MAI_defendOnly";
                tooltip = "$STR_MAI_defendOnlyShort";
                property = "defendOnly";
                defaultValue = "false";
				expression = "_this setVariable ['%s', _value];";
                typeName = "BOOL";
            };
			class customSpawn: Checkbox
            {
                displayName = "$STR_MAI_customSpawn";
                tooltip = "$STR_MAI_customSpawnShort";
                property = "customSpawn";
                defaultValue = "false";
				expression = "_this setVariable ['%s', _value];";
                typeName = "BOOL";
            };
			class includeNotSupported: Checkbox
            {
                displayName = "$STR_MAI_includeNotSupported";
                tooltip = "$STR_MAI_includeNotSupportedShort";
                property = "includeNotSupported";
                defaultValue = "false";
				expression = "_this setVariable ['%s', _value];";
                typeName = "BOOL";
            };
			class includeAir: Checkbox
            {
                displayName = "$STR_MAI_includeAir";
                tooltip = "$STR_MAI_includeAirShort";
                property = "includeAir";
                defaultValue = "false";
				expression = "_this setVariable ['%s', _value];";
                typeName = "BOOL";
            };
            class activateCondition
            {
                displayName = "$STR_MAI_activateCondition";
                tooltip = "$STR_MAI_activateConditionShort";
                property = "activateCondition";
                control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',compile _value];";
                defaultValue = "'true'";
                value = 0;
                validate = "none";
                wikiType = "[[String]]";
            };
			class deleteTrigger: Checkbox
            {
                displayName = "$STR_MAI_deleteTrigger";
                tooltip = "$STR_MAI_deleteTriggerShort";
                property = "deleteTrigger";
                defaultValue = "false";
				expression = "_this setVariable ['%s', _value];";
                typeName = "BOOL";
            };
            class executionCodeUnit
            {
                displayName = "$STR_MAI_executionCodeUnit";
                tooltip = "$STR_MAI_executionCodeUnitShort";
                property = "executionCodeUnit";
                control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',compile _value];";
                defaultValue = "''";
                value = 0;
                validate = "none";
                wikiType = "[[String]]";
            };
            class executionCodePatrol
            {
                displayName = "$STR_MAI_executionCodePatrol";
                tooltip = "$STR_MAI_executionCodePatrolShort";
                property = "executionCodePatrol";
                control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',compile _value];";
                defaultValue = "''";
                value = 0;
                validate = "none";
                wikiType = "[[String]]";
            };
            class executionCodeStationary
            {
                displayName = "$STR_MAI_executionCodeStationary";
                tooltip = "$STR_MAI_executionCodeStationaryShort";
                property = "executionCodeStationary";
                control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',compile _value];";
                defaultValue = "''";
                value = 0;
                validate = "none";
                wikiType = "[[String]]";
            };

			class ModuleDescription: ModuleDescription{}; // Module description should be shown last
		};

		// Module description. Must inherit from base class, otherwise pre-defined entities won't be available
		class ModuleDescription: ModuleDescription
		{
			description = "Short module description"; // Short description, will be formatted as structured text
			sync[] = {"LocationArea_F"}; // Array of synced entities (can contain base classes)

			class LocationArea_F
			{
				description[] = { // Multi-line descriptions are supported
					"First line",
					"Second line"
				};
				position = 1; // Position is taken into effect
				direction = 0; // Direction is taken into effect
				optional = 0; // Synced entity is optional
				duplicate = 0; // Multiple entities of this type can be synced
				synced[] = {"AnyBrain"}; // Pre-define entities like "AnyBrain" can be used. See the list below
			};
		};
	};
	class MAI_ModuleCivilians: Module_F
	{
		// Standard object definitions
		scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = "Civilians"; // Name displayed in the menu
		category = "MAI_Modules";

		// Name of function triggered once conditions are met
		function = "MAI_fnc_civiliansInitCall";
		// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		functionPriority = 1;
		// 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isGlobal = 0;
		// 1 for module waiting until all synced triggers are activated
		isTriggerActivated = 0;
		// 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
		isDisposable = 1;
		// // 1 to run init function in Eden Editor as well
		is3DEN = 1;

		canSetArea = 1;
		canSetAreaHeight = 0;
		canSetAreaShape = 1;

		// Menu displayed when the module is placed or double-clicked on by Zeus
		//curatorInfoType = "RscDisplayAttributeModuleNuke";

		class AttributeValues
		{
			size2[] = {100, 100};
			size3[] = {100, 100, -1};
			isRectangle=0;
		};

		// Module attributes, uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific
		class Attributes: AttributesBase
		{
			// Arguments shared by specific module type (have to be mentioned in order to be present)
			class activationAdd: Default
  			{
				displayName = "$STR_MAI_activation";
				tooltip = "$STR_MAI_activationShort";
				defaultValue = "650";
				property = "activationAdd";
				expression = "_this setVariable ['%s',_value max 0];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class deactivation: Default
  			{
				displayName = "$STR_MAI_deactivation";
				tooltip = "$STR_MAI_deactivationShort";
				defaultValue = "100";
				property = "deactivation";
				expression = "_this setVariable ['%s',_value max 0];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class civiliansCount: Default
  			{
				displayName = "$STR_MAI_civiliansCount";
				tooltip = "$STR_MAI_civiliansCountShort";
				defaultValue = "15";
				property = "civiliansCount";
				expression = "_this setVariable ['%s',_value max 0];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class civiliansType: Combo
  			{
				// Unique property, use "<moduleClass>_<attributeClass>" format to make sure the name is unique in the world
				property = "civiliansType";
				displayName = "$STR_MAI_civiliansType";
				tooltip = "$STR_MAI_civiliansTypeShort";
				typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = """altis"""; // Default attribute value. WARNING: This is an expression, and its returned value will be used (50 in this case)
				class Values
				{
					class altis		{name = "Altis";	value = "altis";}; // Listbox item
					class workers	{name = "Workers"; value = "workers";};
					class empty		{name = "Empty (synchronized only)"; value = "";};
				};
			};
			class interval: Default
  			{
				displayName = "$STR_MAI_interval";
				tooltip = "$STR_MAI_intervalShort";
				defaultValue = "0.1";
				property = "interval";
				expression = "_this setVariable ['%s',_value max 0];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class unitsPerInterval: Default
  			{
				displayName = "$STR_MAI_unitsPerInterval";
				tooltip = "$STR_MAI_unitsPerIntervalShort";
				defaultValue = "1";
				property = "unitsPerInterval";
				expression = "_this setVariable ['%s',_value max 0];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class includeAir: Checkbox
            {
                displayName = "$STR_MAI_includeAir";
                tooltip = "$STR_MAI_includeAirShort";
                property = "includeAir";
                defaultValue = "false";
				expression = "_this setVariable ['%s', _value];";
                typeName = "BOOL";
            };
			class addToZeus: Checkbox
            {
                displayName = "$STR_MAI_addToZeus";
                tooltip = "$STR_MAI_addToZeusShort";
                property = "addToZeus";
                defaultValue = "false";
				expression = "_this setVariable ['%s', _value];";
                typeName = "BOOL";
            };
            class activateCondition
            {
                displayName = "$STR_MAI_activateCondition";
                tooltip = "$STR_MAI_activateConditionShort";
                property = "activateCondition";
                control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',compile _value];";
                defaultValue = "'true'";
                value = 0;
                validate = "none";
                wikiType = "[[String]]";
            };
			class deleteTrigger: Checkbox
            {
                displayName = "$STR_MAI_deleteTrigger";
                tooltip = "$STR_MAI_deleteTriggerShort";
                property = "deleteTrigger";
                defaultValue = "false";
				expression = "_this setVariable ['%s', _value];";
                typeName = "BOOL";
            };
            class executionCodeUnit
            {
                displayName = "$STR_MAI_executionCodeUnit";
                tooltip = "$STR_MAI_executionCodeUnitShort";
                property = "executionCodeUnit";
                control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',compile _value];";
                defaultValue = "''";
                value = 0;
                validate = "none";
                wikiType = "[[String]]";
            };

			class ModuleDescription: ModuleDescription{}; // Module description should be shown last
		};

		// Module description. Must inherit from base class, otherwise pre-defined entities won't be available
		class ModuleDescription: ModuleDescription
		{
			description = "Short module description"; // Short description, will be formatted as structured text
			sync[] = {"LocationArea_F"}; // Array of synced entities (can contain base classes)

			class LocationArea_F
			{
				description[] = { // Multi-line descriptions are supported
					"First line",
					"Second line"
				};
				position = 1; // Position is taken into effect
				direction = 0; // Direction is taken into effect
				optional = 0; // Synced entity is optional
				duplicate = 0; // Multiple entities of this type can be synced
				synced[] = {"AnyBrain"}; // Pre-define entities like "AnyBrain" can be used. See the list below
			};
		};
	};
	class MAI_ModuleReinforce: Module_F
	{
		// Standard object definitions
		scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = "Reinforce"; // Name displayed in the menu
		category = "MAI_Modules";

		// Name of function triggered once conditions are met
		function = "MAI_fnc_reinforceInitCall";
		// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		functionPriority = 1;
		// 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isGlobal = 0;
		// 1 for module waiting until all synced triggers are activated
		isTriggerActivated = 0;
		// 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
		isDisposable = 1;
		// // 1 to run init function in Eden Editor as well
		is3DEN = 1;

		// Menu displayed when the module is placed or double-clicked on by Zeus
		//curatorInfoType = "RscDisplayAttributeModuleNuke";

		// Module attributes, uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific
		class Attributes: AttributesBase
		{
			// Arguments shared by specific module type (have to be mentioned in order to be present)
			class distance: Default
  			{
				displayName = "$STR_MAI_reinforceDistance";
				tooltip = "$STR_MAI_reinforceDistanceShort";
				defaultValue = "300";
				property = "distance";
				expression = "_this setVariable ['%s',_value];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class quantity: Default
  			{
				displayName = "$STR_MAI_reinforceQuantity";
				tooltip = "$STR_MAI_reinforceQuantityShort";
				defaultValue = "1";
				property = "quantity";
				expression = "_this setVariable ['%s',_value max 0];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class minimalCrew: Default
  			{
				displayName = "$STR_MAI_reinforceMinimalCrew";
				tooltip = "$STR_MAI_reinforceMinimalCrewShort";
				defaultValue = "2";
				property = "minimalCrew";
				expression = "_this setVariable ['%s',_value];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class despawn: Checkbox
            {
                displayName = "$STR_MAI_reinforceDespawn";
                tooltip = "$STR_MAI_reinforceDespawnShort";
                property = "despawn";
                defaultValue = "false";
				expression = "_this setVariable ['%s', _value];";
                typeName = "BOOL";
            };
			class intervalVeh: Default
  			{
				displayName = "$STR_MAI_intervalVeh";
				tooltip = "$STR_MAI_intervalVehShort";
				defaultValue = "3";
				property = "intervalVeh";
				expression = "_this setVariable ['%s',_value];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class maxUnitsOnMap: Default
  			{
				displayName = "$STR_MAI_maxUnitsOnMap";
				tooltip = "$STR_MAI_maxUnitsOnMapShort";
				defaultValue = "250";
				property = "maxUnitsOnMap";
				expression = "_this setVariable ['%s',_value max 0];";
				typeName = "NUMBER";
				control = "EditShort";
			};
            class activateCondition
            {
                displayName = "$STR_MAI_activateCondition";
                tooltip = "$STR_MAI_activateConditionShort";
                property = "activateCondition";
                control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',compile _value];";
                defaultValue = "'true'";
                value = 0;
                validate = "none";
                wikiType = "[[String]]";
            };
			class deleteTrigger: Checkbox
            {
                displayName = "$STR_MAI_deleteTrigger";
                tooltip = "$STR_MAI_deleteTriggerShort";
                property = "deleteTrigger";
                defaultValue = "false";
				expression = "_this setVariable ['%s', _value];";
                typeName = "BOOL";
            };
            class executionCodeVehicle
            {
                displayName = "$STR_MAI_executionCodeVehicle";
                tooltip = "$STR_MAI_executionCodeVehicleShort";
                property = "executionCodeVehicle";
                control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',compile _value];";
                defaultValue = "''";
                value = 0;
                validate = "none";
                wikiType = "[[String]]";
            };
            class executionCodeUnit
            {
                displayName = "$STR_MAI_executionCodeUnit";
                tooltip = "$STR_MAI_executionCodeUnitShort";
                property = "executionCodeUnit";
                control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',compile _value];";
                defaultValue = "''";
                value = 0;
                validate = "none";
                wikiType = "[[String]]";
            };
            class executionCodePatrol
            {
                displayName = "$STR_MAI_executionCodePatrol";
                tooltip = "$STR_MAI_executionCodePatrolShort";
                property = "executionCodePatrol";
                control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',compile _value];";
                defaultValue = "''";
                value = 0;
                validate = "none";
                wikiType = "[[String]]";
            };
            class executionCodeVehicleCrew
            {
                displayName = "$STR_MAI_executionCodeVehicleCrew";
                tooltip = "$STR_MAI_executionCodeVehicleCrewShort";
                property = "executionCodeVehicleCrew";
                control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',compile _value];";
                defaultValue = "''";
                value = 0;
                validate = "none";
                wikiType = "[[String]]";
            };
			class ModuleDescription: ModuleDescription{}; // Module description should be shown last
		};

		// Module description. Must inherit from base class, otherwise pre-defined entities won't be available
		class ModuleDescription: ModuleDescription
		{
			description = "Short module description"; // Short description, will be formatted as structured text
			sync[] = {"LocationArea_F"}; // Array of synced entities (can contain base classes)

			class LocationArea_F
			{
				description[] = { // Multi-line descriptions are supported
					"First line",
					"Second line"
				};
				position = 1; // Position is taken into effect
				direction = 0; // Direction is taken into effect
				optional = 0; // Synced entity is optional
				duplicate = 0; // Multiple entities of this type can be synced
				synced[] = {"AnyBrain"}; // Pre-define entities like "AnyBrain" can be used. See the list below
			};
		};
	};
	class MAI_ModuleSimpleSpawn: Module_F
	{
		// Standard object definitions
		scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = "Simple Spawn"; // Name displayed in the menu
		category = "MAI_Modules";

		// Name of function triggered once conditions are met
		function = "MAI_fnc_simpleSpawnInitCall";
		// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		functionPriority = 1;
		// 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isGlobal = 0;
		// 1 for module waiting until all synced triggers are activated
		isTriggerActivated = 0;
		// 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
		isDisposable = 1;
		// // 1 to run init function in Eden Editor as well
		is3DEN = 1;

		// Menu displayed when the module is placed or double-clicked on by Zeus
		//curatorInfoType = "RscDisplayAttributeModuleNuke";

		// Module attributes, uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific
		class Attributes: AttributesBase
		{
			// Arguments shared by specific module type (have to be mentioned in order to be present)
			class activation: Default
  			{
				displayName = "$STR_MAI_activation";
				tooltip = "$STR_MAI_activationShort";
				defaultValue = "750";
				property = "activation";
				expression = "_this setVariable ['%s',_value];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class deactivation: Default
  			{
				displayName = "$STR_MAI_deactivation";
				tooltip = "$STR_MAI_deactivationShort";
				defaultValue = "-1";
				property = "deactivation";
				expression = "_this setVariable ['%s',_value];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class includeAir: Checkbox
            {
                displayName = "$STR_MAI_includeAir";
                tooltip = "$STR_MAI_includeAirShort";
                property = "includeAir";
                defaultValue = "false";
				expression = "_this setVariable ['%s', _value];";
                typeName = "BOOL";
            };
			class interval: Default
  			{
				displayName = "$STR_MAI_interval";
				tooltip = "$STR_MAI_intervalShort";
				defaultValue = "0.1";
				property = "interval";
				expression = "_this setVariable ['%s',_value max 0];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class unitsPerInterval: Default
  			{
				displayName = "$STR_MAI_unitsPerInterval";
				tooltip = "$STR_MAI_unitsPerIntervalShort";
				defaultValue = "1";
				property = "unitsPerInterval";
				expression = "_this setVariable ['%s',_value max 0];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class deleteVehicles: Checkbox
            {
                displayName = "$STR_MAI_deleteVehicles";
                tooltip = "$STR_MAI_deleteVehiclesShort";
                property = "deleteVehicles";
                defaultValue = "false";
				expression = "_this setVariable ['%s', _value];";
                typeName = "BOOL";
            };
			class checkBuildings: Checkbox
            {
                displayName = "$STR_MAI_checkBuildings";
                tooltip = "$STR_MAI_checkBuildingsShort";
                property = "checkBuildings";
                defaultValue = "true";
				expression = "_this setVariable ['%s', _value];";
                typeName = "BOOL";
            };
            class activateCondition
            {
                displayName = "$STR_MAI_activateCondition";
                tooltip = "$STR_MAI_activateConditionShort";
                property = "activateCondition";
                control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',compile _value];";
                defaultValue = "'true'";
                value = 0;
                validate = "none";
                wikiType = "[[String]]";
            };
			class deleteTrigger: Checkbox
            {
                displayName = "$STR_MAI_deleteTrigger";
                tooltip = "$STR_MAI_deleteTriggerShort";
                property = "deleteTrigger";
                defaultValue = "false";
				expression = "_this setVariable ['%s', _value];";
                typeName = "BOOL";
            };
			class forceActivate: Checkbox
            {
                displayName = "$STR_MAI_forceActivate";
                tooltip = "$STR_MAI_forceActivateShort";
                property = "forceActivate";
                defaultValue = "false";
				expression = "_this setVariable ['%s', _value];";
                typeName = "BOOL";
            };
            class executionCodeUnit
            {
                displayName = "$STR_MAI_executionCodeUnit";
                tooltip = "$STR_MAI_executionCodeUnitShort";
                property = "executionCodeUnit";
                control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',compile _value];";
                defaultValue = "''";
                value = 0;
                validate = "none";
                wikiType = "[[String]]";
            };
            class executionCodePatrol
            {
                displayName = "$STR_MAI_executionCodePatrol";
                tooltip = "$STR_MAI_executionCodePatrolShort";
                property = "executionCodePatrol";
                control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',compile _value];";
                defaultValue = "''";
                value = 0;
                validate = "none";
                wikiType = "[[String]]";
            };
            class executionCodeVehicle
            {
                displayName = "$STR_MAI_executionCodeVehicle";
                tooltip = "$STR_MAI_executionCodeVehicleShort";
                property = "executionCodeVehicle";
                control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',compile _value];";
                defaultValue = "''";
                value = 0;
                validate = "none";
                wikiType = "[[String]]";
            };
			class ModuleDescription: ModuleDescription{}; // Module description should be shown last
		};

		// Module description. Must inherit from base class, otherwise pre-defined entities won't be available
		class ModuleDescription: ModuleDescription
		{
			description = "Simple spawn for AI. AI will be only spawned when AI will be closer than set distance. Only one unit from group need to be synchronized. Supports vehicles – Vehicle will stay, but crew will be spawned. Synchronize vehicle or unit."; // Short description, will be formatted as structured text
			sync[] = {"LocationArea_F"}; // Array of synced entities (can contain base classes)

			class LocationArea_F
			{
				description[] = { // Multi-line descriptions are supported
					"First line",
					"Second line"
				};
				position = 1; // Position is taken into effect
				direction = 0; // Direction is taken into effect
				optional = 0; // Synced entity is optional
				duplicate = 0; // Multiple entities of this type can be synced
				synced[] = {"AnyBrain"}; // Pre-define entities like "AnyBrain" can be used. See the list below
			};
		};
	};
};
