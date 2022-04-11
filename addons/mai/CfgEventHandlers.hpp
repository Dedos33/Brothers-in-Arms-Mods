
class Extended_InitPost_EventHandlers {
    class CAManBase {
        class MadinAI_aiInitPost {
            init = "call MadinAI_fnc_AiOnInitPost";
        };
    };
};

class Extended_Reloaded_EventHandlers {
    class CAManBase {
        class MadinAI_aiReload {
            reloaded = "call MadinAI_fnc_AiOnReloaded";
        };
    };
};

class Extended_HitPart_EventHandlers {
    class CAManBase {
        class MadinAI_playerHit {
            hitPart = "call MadinAI_fnc_AiOnHitPart";
        };
    };
};

class Extended_Hit_EventHandlers {
    class CAManBase {
        class MadinAI_aiHit {
            hit = "call MadinAI_fnc_AiOnHit";
        };
    };
};

class Extended_Killed_EventHandlers {
    class CAManBase {
        class MadinAI_aiKilled {
            killed = "call MadinAI_fnc_AiOnKilled";
        };
    };
};
