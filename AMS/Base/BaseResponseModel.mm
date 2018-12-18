//
//  BaseResponseModel.m
//  AMS
//
//  Created by jianlu on 2018/12/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "BaseResponseModel.h"
#import "AppDelegate.h"

@implementation BaseResponseModel
//-(instancetype)dictWithDataMessage:(best_protocol::IBestDataMessage*)dataMessage{
////    if(self = [super init]){
//        unsigned int count = 0;
//        objc_property_t *propertyList =  class_copyPropertyList([self class], &count);
//        for(int i=0;i<count;i++)
//        {
//            //取出每一个属性
//            objc_property_t property = propertyList[i];
//            //获取每一个属性的变量名
//            const char* propertyName = property_getName(property);
//            
//            NSString *proName = [[NSString alloc] initWithCString:propertyName encoding:NSUTF8StringEncoding];
//            NSString *realKeyName = [@"FIELD_KEY_" stringByAppendingString:proName];
//            NSNumber* fieldKey = kAppDelegate.FIELD_KEY_DICTS[realKeyName] ?: @0;
//            //int类型
//            if ([[NSString stringWithCString:[AMSUtil getPropertyType:property]  encoding:NSUTF8StringEncoding] isEqualToString:@"i"]) {
//                auto field = dataMessage->GetField((int32)fieldKey.integerValue);
//                NSNumber* proValue = @(field->GetInt32());
//                [self setValue:proValue forKey:proName];
//            }else{
//                //string类型
//                auto field = dataMessage->GetField((int32)fieldKey.integerValue);
//                NSString* proValue = [NSString stringWithUTF8String:field->GetString()];
//                [self setValue:proValue forKey:proName];
//            }
//            //        int32 nRequestId = [BestMessageUtil generateRequestID];
//            
//        }
//        //c语言的函数，所以要去手动的去释放内存
//        free(propertyList);
////    }
//    return self;
//}
@end
