
class Extended_InitPost_EventHandlers {
    class CAManBase {
        class MAI_aiInitPost {
            init = "call MAI_fnc_AiOnInitPost";
        };
    };
};

class Extended_Reloaded_EventHandlers {
    class CAManBase {
        class MAI_aiReload {
            reloaded = "call MAI_fnc_AiOnReloaded";
        };
    };
};

class Extended_HitPart_EventHandlers {
    class CAManBase {
        class MAI_playerHit {
            hitPart = "call MAI_fnc_AiOnHitPart";
        };
    };
};

class Extended_Hit_EventHandlers {
    class CAManBase {
        class MAI_aiHit {
            hit = "call MAI_fnc_AiOnHit";
        };
    };
};

class Extended_Killed_EventHandlers {
    class CAManBase {
        class MAI_aiKilled {
            killed = "call MAI_fnc_AiOnKilled";
        };
    };
};
