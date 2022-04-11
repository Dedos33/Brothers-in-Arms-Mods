#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "bia_main",
            "bia_debug_console"
        };
        author = "BrothersInArms";
        VERSION_CONFIG;
    };
};


#include "CfgEden.hpp"
#include "CfgEventHandlers.hpp"
