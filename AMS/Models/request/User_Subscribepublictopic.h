//订阅公有流的数据
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Subscribepublictopic : NSObject
@property(nonatomic,strong) NSNumber *nResumeType;//数据流恢复传输的类型    0->RESTART模式(默认);1->RESUME模式;2->QUICK模式;

NS_ASSUME_NONNULL_END
@end