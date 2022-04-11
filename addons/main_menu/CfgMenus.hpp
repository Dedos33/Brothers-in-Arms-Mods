
class EMM_mainMenu_CfgMenus {
    class VN {
        class menus {
            class MainMenu;
            class MultiplayerVN: MainMenu {
                items[] = {"BrothersInArms", "ServerBrowser", "SOGPrairieFire", "MikeForce", "Exit"};

                class ServerBrowser;
                class BrothersInArms: ServerBrowser {
                    action = QUOTE(_this call (uiNamespace getVariable QQFUNC(join)));
                    text = CSTRING(SpotlightHeader);
                };
            };
        };
    };
};
