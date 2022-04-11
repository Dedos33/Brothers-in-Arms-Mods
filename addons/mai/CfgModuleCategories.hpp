
class CfgFactionClasses
{
	class NO_CATEGORY;
	class MadinAI_Modules: NO_CATEGORY
	{
		displayName = "BrothersInArms - Madin AI";
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
	class madinAI_ModuleBuildSpawn: Module_F
	{
		// Standard object definitions
		scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = "Build Spawn"; // Name displayed in the menu
		category = "MadinAI_Modules";

		// Name of function triggered once conditions are met
		function = "MadinAI_fnc_buildSpawnInitCall";
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
		curatorInfoType = "RscDisplayAttributeModuleNuke";

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
				displayName = "$STR_MadinAI_activation";
				tooltip = "$STR_MadinAI_activationShort";
				defaultValue = "50";
				property = "activationAdd";
				expression = "_this setVariable ['%s',_value];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class tickets: Default
  			{
				displayName = "$STR_MadinAI_tickets";
				tooltip = "$STR_MadinAI_ticketsShort";
				defaultValue = "70";
				property = "tickets";
				expression = "_this setVariable ['%s',_value max 0];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class minDist: Default
  			{
				displayName = "$STR_MadinAI_minDist";
				tooltip = "$STR_MadinAI_minDistShort";
				defaultValue = "35";
				property = "minDistance";
				expression = "_this setVariable ['%s',_value max 0];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class patrolCount: Default
  			{
				displayName = "$STR_MadinAI_patrolCount";
				tooltip = "$STR_MadinAI_patrolCountShort";
				defaultValue = "6";
				property = "patrolCount";
				expression = "_this setVariable ['%s',_value max 0];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class limit: Default
  			{
				displayName = "$STR_MadinAI_limitBuilding";
				tooltip = "$STR_MadinAI_limitBuildingShort";
				defaultValue = "2";
				property = "limit";
				expression = "_this setVariable ['%s',_value max 1];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class includeAir: Checkbox
            {
                displayName = "$STR_MadinAI_includeAir";
                tooltip = "$STR_MadinAI_includeAirShort";
                property = "includeAir";
                defaultValue = "false";
				expression = "_this setVariable ['%s', _value];";
                typeName = "BOOL";
            };
            class executionCodeUnit
            {
                displayName = "$STR_MadinAI_executionCodeUnit";
                tooltip = "$STR_MadinAI_executionCodeUnitShort";
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
	class madinAI_ModuleRespPoint: Module_F
	{
		// Standard object definitions
		scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = "Respawn Point"; // Name displayed in the menu
		category = "MadinAI_Modules";

		// Name of function triggered once conditions are met
		function = "MadinAI_fnc_respPointInitCall";
		// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		functionPriority = 1;
		// 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isGlobal = 0;
		// 1 for module waiting until all synced triggers are activated
		isTriggerActivated = 1;
		// 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
		isDisposable = 1;
		// // 1 to run init function in Eden Editor as well
		is3DEN = 1;

		// Menu displayed when the module is placed or double-clicked on by Zeus
		curatorInfoType = "RscDisplayAttributeModuleNuke";

		// Module attributes, uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific
		class Attributes: AttributesBase
		{
			// Arguments shared by specific module type (have to be mentioned in order to be present)
			class tickets: Default
  			{
				displayName = "$STR_MadinAI_ticketsPoint";
				tooltip = "$STR_MadinAI_ticketsPointShort";
				defaultValue = "8";
				property = "tickets";
				expression = "_this setVariable ['%s',_value];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class minDist: Default
  			{
				displayName = "$STR_MadinAI_minDistPoint";
				tooltip = "$STR_MadinAI_minDistPointShort";
				defaultValue = "30";
				property = "minDistance";
				expression = "_this setVariable ['%s',_value max 0];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class activation: Default
  			{
				displayName = "$STR_MadinAI_activationPoint";
				tooltip = "$STR_MadinAI_activationPointShort";
				defaultValue = "-1";
				property = "activation";
				expression = "_this setVariable ['%s',_value];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class buildingsDistance: Default
  			{
				displayName = "$STR_MadinAI_buildingsDistance";
				tooltip = "$STR_MadinAI_buildingsDistanceShort";
				defaultValue = "8";
				property = "buildingsDistance";
				expression = "_this setVariable ['%s',_value max 0];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class includeAir: Checkbox
            {
                displayName = "$STR_MadinAI_includeAir";
                tooltip = "$STR_MadinAI_includeAirShort";
                property = "includeAir";
                defaultValue = "false";
				expression = "_this setVariable ['%s', _value];";
                typeName = "BOOL";
            };
            class executionCodeUnit
            {
                displayName = "$STR_MadinAI_executionCodeUnit";
                tooltip = "$STR_MadinAI_executionCodeUnitShort";
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
	class madinAI_ModuleCivilians: Module_F
	{
		// Standard object definitions
		scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = "Civilians"; // Name displayed in the menu
		category = "MadinAI_Modules";

		// Name of function triggered once conditions are met
		function = "MadinAI_fnc_civiliansInitCall";
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
		curatorInfoType = "RscDisplayAttributeModuleNuke";

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
				displayName = "$STR_MadinAI_activation";
				tooltip = "$STR_MadinAI_activationShort";
				defaultValue = "650";
				property = "activationAdd";
				expression = "_this setVariable ['%s',_value max 0];";
				typeName = "NUMBER";
				control = "EditShort";
			};

			class deactivationAdd: Default
  			{
				displayName = "$STR_MadinAI_deactivation";
				tooltip = "$STR_MadinAI_deactivationShort";
				defaultValue = "100";
				property = "deactivationAdd";
				expression = "_this setVariable ['%s',_value max 0];";
				typeName = "NUMBER";
				control = "EditShort";
			};

			class civiliansCount: Default
  			{
				displayName = "$STR_MadinAI_civiliansCount";
				tooltip = "$STR_MadinAI_civiliansCountShort";
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
				displayName = "$STR_MadinAI_civiliansType";
				tooltip = "$STR_MadinAI_civiliansTypeShort";
				typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = """altis"""; // Default attribute value. WARNING: This is an expression, and its returned value will be used (50 in this case)
				class Values
				{
					class altis		{name = "Altis";	value = "altis";}; // Listbox item
					class workers	{name = "Workers"; value = "workers";};
					class empty		{name = "Empty (synchronized only)"; value = "";};
				};
			};
			class includeAir: Checkbox
            {
                displayName = "$STR_MadinAI_includeAir";
                tooltip = "$STR_MadinAI_includeAirShort";
                property = "includeAir";
                defaultValue = "false";
				expression = "_this setVariable ['%s', _value];";
                typeName = "BOOL";
            };
			class addToZeus: Checkbox
            {
                displayName = "$STR_MadinAI_addToZeus";
                tooltip = "$STR_MadinAI_addToZeusShort";
                property = "addToZeus";
                defaultValue = "false";
				expression = "_this setVariable ['%s', _value];";
                typeName = "BOOL";
            };
            class executionCodeUnit
            {
                displayName = "$STR_MadinAI_executionCodeUnit";
                tooltip = "$STR_MadinAI_executionCodeUnitShort";
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
};
