#include "script_components.hpp"

// if debug enabled allow function recompilation
// makes life easier with filepatching
#define MAI_DEBUG 1

#ifdef MAI_DEBUG
	#define FUNCTION_RECOMPILE		1
#else
	#define FUNCTION_RECOMPILE		0
#endif

class CfgFunctions
{
	class MAI {

		class AI {

			file = "MAI\framework\main\functions\AI";

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

			file = "MAI\framework\main\functions\general";

			class HCfind {
				recompile = FUNCTION_RECOMPILE;
			};

			class spawnAI {
				recompile = FUNCTION_RECOMPILE;
			};

			class patrolRandomWaypoints {
				recompile = FUNCTION_RECOMPILE;
			};

			class expectedNewUnitsCountReturn {
				recompile = FUNCTION_RECOMPILE;
			};

			class moveInVehicleRole {
				recompile = FUNCTION_RECOMPILE;
			};
			class checkActivateConditions {
				recompile = FUNCTION_RECOMPILE;
			};
			class getVehicleInfo {
				recompile = FUNCTION_RECOMPILE;
			};
			class createVehicleFromInfo {
				recompile = FUNCTION_RECOMPILE;
			};
		};

		class players {

			file = "MAI\framework\main\functions\players";

			class playerCamoCoef {
				recompile = FUNCTION_RECOMPILE;
			};

			class playerInit {
				postInit = 1;
				recompile = FUNCTION_RECOMPILE;
			};
		};

		class buildspawn {

			file = "MAI\framework\main\functions\buildSpawn";

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

			class buildSpawnUnitDespawn {
				recompile = FUNCTION_RECOMPILE;
			};

			class buildSpawnGroupDespawn {
				recompile = FUNCTION_RECOMPILE;
			};

			class buildSpawnGroupDespawnLoop {
				recompile = FUNCTION_RECOMPILE;
			};

			class buildSpawnGroupDespawnCancel {
				recompile = FUNCTION_RECOMPILE;
			};

			class buildSpawnAiSpawn {
				recompile = FUNCTION_RECOMPILE;
			};

			class buildSpawnPatrolCustomPos {
				recompile = FUNCTION_RECOMPILE;
			};

			class buildSpawnOnKilledPatrol {
				recompile = FUNCTION_RECOMPILE;
			};

			class buildSpawnLoopSpawnPatrol {
				recompile = FUNCTION_RECOMPILE;
			};
		};

		class civilians {

			file = "MAI\framework\main\functions\civilians";

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
		};

		class reinforce {

			file = "MAI\framework\main\functions\reinforce";

			class reinforceFirstState {
				recompile = FUNCTION_RECOMPILE;
			};

			class reinforceDespawn {
				recompile = FUNCTION_RECOMPILE;
			};

			class reinforceDespawnLoop {
				recompile = FUNCTION_RECOMPILE;
			};

			class reinforceInit {
				recompile = FUNCTION_RECOMPILE;
			};

			class reinforceInitCall {
				recompile = FUNCTION_RECOMPILE;
			};

			class reinforceSpawnVeh {
				recompile = FUNCTION_RECOMPILE;
			};

			class reinforceUnload {
				recompile = FUNCTION_RECOMPILE;
			};

			class reinforceUnloadFinish {
				recompile = FUNCTION_RECOMPILE;
			};

			class reinforceUnloadUnits {
				recompile = FUNCTION_RECOMPILE;
			};

			class reinforceVehAI {
				recompile = FUNCTION_RECOMPILE;
			};

			class reinforceVehWaitToSpawn {
				recompile = FUNCTION_RECOMPILE;
			};

			class reinforceWaitUntil {
				recompile = FUNCTION_RECOMPILE;
			};

			class reinforceUnloadStatements {
				recompile = FUNCTION_RECOMPILE;
			};

			class reinforceVehAirAI {
				recompile = FUNCTION_RECOMPILE;
			};
		};

		class simpleSpawn {

			file = "MAI\framework\main\functions\simpleSpawn";

			class simpleSpawnFirstState {
				recompile = FUNCTION_RECOMPILE;
			};

			class simpleSpawnInit {
				recompile = FUNCTION_RECOMPILE;
			};

			class simpleSpawnInitCall {
				recompile = FUNCTION_RECOMPILE;
			};

			class simpleSpawnWaitUntil {
				recompile = FUNCTION_RECOMPILE;
			};

			class simpleSpawnInterval {
				recompile = FUNCTION_RECOMPILE;
			};

			class simpleSpawnGetGroups {
				recompile = FUNCTION_RECOMPILE;
			};

			class simpleSpawnDespawn {
				recompile = FUNCTION_RECOMPILE;
			};
		};
	};
};