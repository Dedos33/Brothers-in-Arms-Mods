#define LOADING_SCREEN_CLASS(className,authorName) \
    class className { \
        author = QUOTE(authorName); \
        path = QPATHTOF(ui\loading\##className##_co.paa); \
    }

class GVAR(CfgLoadingScreen) {
    class Backgrounds {
        LOADING_SCREEN_CLASS(screen_1,Dedos);
        LOADING_SCREEN_CLASS(screen_2,Dedos);
        LOADING_SCREEN_CLASS(screen_3,Dedos);
        LOADING_SCREEN_CLASS(screen_4,Azvel);
        LOADING_SCREEN_CLASS(screen_5,Azvel);
    };
};
