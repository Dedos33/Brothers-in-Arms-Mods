#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "bia_main"
        };
        author = "BrothersInArms";
        VERSION_CONFIG;
    };
};


#include "CfgEventHandlers.hpp"

#include "teleportDialog.hpp"
