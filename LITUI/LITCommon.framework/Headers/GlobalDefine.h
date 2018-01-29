
//#import "LoggerClient.h"
//@class TSNLogger;
//#import "TSNLogger.h"


#define CURRENT_FUNCTION_NAME [NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]


//#define TSNLOG(__format, __args...) [[TSNLogger singleton] appendLogEntry: [NSString stringWithFormat:@"%s:%d %@",__PRETTY_FUNCTION__, __LINE__,[NSString stringWithFormat:__format, ##__args]] ];

#define TLOG(__format,__args...) NSLog(@"%s:%d %@",__PRETTY_FUNCTION__, __LINE__,[NSString stringWithFormat:__format, ##__args]);

#define CCP(__X__,__Y__) CGPointMake(__X__,__Y__)
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define PTM_RATIO 32.0
#define RANDOM_INT arc4random()%999999999
#define TEXT_SEPARATOR @"|#|"
#define DEPRECATED __attribute__((deprecated))
#define DEPRECATED_WITH_MSG(msg) __attribute((deprecated((msg))))
#define YEAR_INTERVAL -31556926

//NS_INLINE float RADIAN_FROM_DEGREE(degrees) {
//    return (degrees / 180) * M_PI;
//}

