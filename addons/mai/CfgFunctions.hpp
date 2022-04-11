#include "script_components.hpp"

// if debug enabled allow function recompilation
// makes life easier with filepatching
#ifdef MADIN_DEBUG
	#define FUNCTION_RECOMPILE		1
#else
	#define FUNCTION_RECOMPILE		0
#endif

class CfgFunctions
{
	class MadinAI {

		class AI {

			file = "MadinAI\framework\main\functions\AI";

			class AiPTSDamnesia {
				recompile = FUNCTION_RECOMPILE;
			};

			class AiAimPenalty {
				recompile = FUNCTION_RECOMPILE;
			};

			class AiGroupCombat {
				recompile = FUNCTION_RECOMPILE;
			};

			class AiGroupFindGun {
				recompile = FUNCTION_RECOMPILE;
			};

			class AiGroupLoop {
				recompile = FUNCTION_RECOMPILE;
			};

			class AiOnHitPart {
				recompile = FUNCTION_RECOMPILE;
			};

			class AiOnHit {
				recompile = FUNCTION_RECOMPILE;
			};

			class AiOnInitPost {
				recompile = FUNCTION_RECOMPILE;
			};

			class AiOnReloaded {
				recompile = FUNCTION_RECOMPILE;
			};

			class AiOnKilled {
				recompile = FUNCTION_RECOMPILE;
			};

			class AiGroupMoveToBuilding {
				recompile = FUNCTION_RECOMPILE;
			};

			class AiLoop {
				recompile = FUNCTION_RECOMPILE;
			};

			class AiLoopInit {
				preInit = 1;
				recompile = FUNCTION_RECOMPILE;
			};

			class AiLoopStart {
				recompile = FUNCTION_RECOMPILE;
			};

			class AiUnits {
				recompile = FUNCTION_RECOMPILE;
			};

			class AiGroupFlee {
				recompile = FUNCTION_RECOMPILE;
			};

			class AiRestoreMagazines {
				recompile = FUNCTION_RECOMPILE;
			};

			class AiShootRpg {
				recompile = FUNCTION_RECOMPILE;
			};

			class AiSightAdjust {
				recompile = FUNCTION_RECOMPILE;
			};

			class AiSightAdjustInit {
				postInit = 1;
				recompile = FUNCTION_RECOMPILE;
			};

			class AiForceFormation {
				postInit = 1;
				recompile = FUNCTION_RECOMPILE;
			};

		};

		class general {

			file = "MadinAI\framework\main\functions\general";

			class HCfind {
				recompile = FUNCTION_RECOMPILE;
			};

			class spawnAI {
				recompile = FUNCTION_RECOMPILE;
			};

		};

		class buildspawn {

			file = "MadinAI\framework\main\functions\buildSpawn";

			class buildSpawnFirstState {
				recompile = FUNCTION_RECOMPILE;
			};
			class buildSpawnInit {
				recompile = FUNCTION_RECOMPILE;
			};
			class buildSpawnInitCall {
				recompile = FUNCTION_RECOMPILE;
			};
			class buildSpawnLoop {
				recompile = FUNCTION_RECOMPILE;
			};
			class buildSpawnWaitUntil {
				recompile = FUNCTION_RECOMPILE;
			};

			class buildSpawnGroupPatrol {
				recompile = FUNCTION_RECOMPILE;
			};
		};

		class respPoint {

			file = "MadinAI\framework\main\functions\respPoint";

			class respPointEH {
				recompile = FUNCTION_RECOMPILE;
			};
			class respPointFirstState {
				recompile = FUNCTION_RECOMPILE;
			};
			class respPointInit {
				recompile = FUNCTION_RECOMPILE;
			};
			class respPointInitCall {
				recompile = FUNCTION_RECOMPILE;
			};
			class respPointWaitUntil {
				recompile = FUNCTION_RECOMPILE;
			};
			class respPointNearLoop {
				recompile = FUNCTION_RECOMPILE;
			};

		};

		class civilians {

			file = "MadinAI\framework\main\functions\civilians";

			class civiliansAiMove {
				recompile = FUNCTION_RECOMPILE;
			};

			class civiliansFirstState {
				recompile = FUNCTION_RECOMPILE;
			};

			class civiliansInit {
				recompile = FUNCTION_RECOMPILE;
			};

			class civiliansInitCall {
				recompile = FUNCTION_RECOMPILE;
			};

			class civiliansLoop {
				recompile = FUNCTION_RECOMPILE;
			};

			class civiliansSpawn {
				recompile = FUNCTION_RECOMPILE;
			};

			class civiliansWaitUntil {
				recompile = FUNCTION_RECOMPILE;
			};

			class civiliansWaitUntilHc {
				recompile = FUNCTION_RECOMPILE;
			};

		};
	};
};