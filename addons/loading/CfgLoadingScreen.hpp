#define LOADING_SCREEN_CLASS(className,authorName) \
    class className { \
        author = QUOTE(authorName); \
        path = QPATHTOF(ui\loading\##className##_co.paa); \
    }

class GVAR(CfgLoadingScreen) {
    class Backgrounds {
        LOADING_SCREEN_CLASS(sccren_1,Dedos);
        LOADING_SCREEN_CLASS(sccren_2,Dedos);
        LOADING_SCREEN_CLASS(sccren_3,Dedos);
    };
};
