// Uncomment to enable debugging
// #define MADIN_DEBUG

#ifdef MADIN_DEBUG
	#define DEBUG(TEXT)							systemChat TEXT
	#define DEBUG_1(TEXT, ARG1)					systemChat format [TEXT, ARG1]
	#define DEBUG_2(TEXT, ARG1, ARG2)			systemChat format [TEXT, ARG1, ARG2]
	#define DEBUG_3(TEXT, ARG1, ARG2, ARG3)		systemChat format [TEXT, ARG1, ARG2, ARG3]
#else
	#define DEBUG(TEXT)
	#define DEBUG_1(TEXT, ARG1)
	#define DEBUG_2(TEXT, ARG1, ARG2)
	#define DEBUG_3(TEXT, ARG1, ARG2, ARG3)
#endif