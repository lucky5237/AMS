//
//  BestMessageUtil.m
//  AMS
//  best消息工具类
//  Created by jianlu on 2018/10/30.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "BestMessageUtil.h"
#import "BaseResponseModel.h"
#import "BaseRequestModel.h"
#import <objc/runtime.h>
#import "AMSUtil.h"
#import "field_key.h"
#import "AppDelegate.h"
#import "best_sdk_define.h"
#import "ConfigModel.h"

@implementation BestMessageUtil

static int requestId = 0;

+(NSData *)generateBestMsg:(uint32)fucntionType model:(id)model{
//    if (![[model class] isSubclassOfClass:[BaseRequestModel class]]) {
//        NSLog(@"非法入参，必须为BaseRequsetModel的子类");
//        return nil;
//    }
    InitBestMessge();
    best_protocol::IBestMessgeFactory *m_factory = CreateBestMessgeFactrotyInstance();
    best_protocol::IBestMessge* phase_best_message = m_factory->CreateBestMessage();
    best_protocol::IBestRPCHead * phase_best_rpc_head = m_factory->CreateRpcHead();//创建RPC头
    best_protocol::IBestHeadMessage* phase_best_head_message = m_factory->CreateHeadMessage();//创建路由体
    best_protocol::IBestDataMessage* phase_best_data_message= m_factory->CreateDataMessage(best_protocol::BEST_DATA_RAW);//创建数据体
    phase_best_rpc_head->SetFuncNo(fucntionType);
    phase_best_rpc_head->SetPackType(best_protocol::PACKTTYPE_REQUEST);
    
    unsigned int count = 0;
    //获取属性的列表
    objc_property_t *propertyList =  class_copyPropertyList([model class], &count);
    for(int i=0;i<count;i++)
    {
        //取出每一个属性
        objc_property_t property = propertyList[i];
        //获取每一个属性的变量名
        const char* propertyName = property_getName(property);
        
        NSString *proName = [[NSString alloc] initWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSString *realKeyName = [@"FIELD_KEY_" stringByAppendingString:proName];
        NSNumber* fieldKey = kAppDelegate.configModel.FIELD_KEY_DICTS[realKeyName] ?: @0;
        //int类型
        if ([[NSString stringWithCString:[AMSUtil getPropertyType:property]  encoding:NSUTF8StringEncoding] isEqualToString:@"NSNumber"]) {
            if (fieldKey.integerValue != FIELD_KEY_nRequestID) {
                NSNumber* proValue = (NSNumber* )[model valueForKey:proName] ?: @0;
                auto field = m_factory ->CreateBestField();
                field->SetInt32((int32)proValue.integerValue);
                NSLog(@"SET FIELD ---- (%@ = %@ , %@)",realKeyName,fieldKey,proValue);
                phase_best_data_message->SetField((int32)fieldKey.integerValue, field);
            }
         
        }else{
            //string类型
            NSString* proValue = (NSString* )[model valueForKey:proName] ?: @"";
            auto field = m_factory ->CreateBestField();
            field->SetString(proValue.UTF8String);
            NSLog(@"SET FIELD ---- (%@ = %@ , %@)",realKeyName,fieldKey,proValue);
            phase_best_data_message->SetField((int32)fieldKey.integerValue, field);
        }
    }
    int32 nRequestId = [BestMessageUtil generateRequestID];
    auto requestField = m_factory ->CreateBestField();
    requestField->SetInt32(nRequestId);
    phase_best_data_message->SetField(FIELD_KEY_nRequestID, requestField);
    NSLog(@"SET FIELD ---- (FIELD_KEY_nRequestID = %d)",nRequestId);
    //c语言的函数，所以要去手动的去释放内存
    free(propertyList);
    phase_best_head_message->SetDataMessage(phase_best_data_message);
    phase_best_message->AddHeadMessage(phase_best_head_message);
    phase_best_message->SetRpcHead(phase_best_rpc_head);
    int32 msg_length = 0;
    const void* data = phase_best_message->Serialize(&msg_length);
    NSData *sendData = [[NSData alloc] initWithBytes:data length:msg_length];
    return sendData;
}

+(NSData *)generateHeartBeatMessage{
    InitBestMessge();
    best_protocol::IBestMessgeFactory *m_factory = CreateBestMessgeFactrotyInstance();
    best_protocol::IBestMessge* phase_best_message = m_factory->CreateBestMessage();
    best_protocol::IBestRPCHead * phase_best_rpc_head = m_factory->CreateRpcHead();//创建RPC头
//    best_protocol::IBestHeadMessage* phase_best_head_message = m_factory->CreateHeadMessage();//创建路由体
//    best_protocol::IBestDataMessage* phase_best_data_message= m_factory->CreateDataMessage(best_protocol::BEST_DATA_RAW);//创建数据体
    phase_best_rpc_head->SetFuncNo(AS_SDK_USER_HEARTBEAT);
//    phase_best_rpc_head->SetPackType(best_protocol::PACKTTYPE_REQUEST);
    
//    int32 nRequestId = [BestMessageUtil generateRequestID];
//    auto requestField = m_factory ->CreateBestField();
//    requestField->SetInt32(nRequestId);
//    phase_best_data_message->SetField(FIELD_KEY_nRequestID, requestField);
//    phase_best_head_message->SetDataMessage(phase_best_data_message);
//    phase_best_message->AddHeadMessage(phase_best_head_message);
    phase_best_message->SetRpcHead(phase_best_rpc_head);
    int32 msg_length = 0;
    const void* data = phase_best_message->Serialize(&msg_length);
    NSData *sendData = [[NSData alloc] initWithBytes:data length:msg_length];
    return sendData;
}

+(id)modelWithDataMessage:(best_protocol::IBestDataMessage*)dataMessage modelClass:(Class) clazz{
    //处理父类
    id model = [[clazz alloc] init];
//    if ([NSStringFromClass(clazz.superclass)
//         isEqualToString:NSStringFromClass([BaseResponseModel class])]) {
//        unsigned int count = 0;
//        objc_property_t *propertyList =  class_copyPropertyList(clazz.superclass, &count);
//       
//        for(int i=0;i<count;i++)
//        {
//            //取出每一个属性
//            objc_property_t property = propertyList[i];
//            //获取每一个属性的变量名
//            const char* propertyName = property_getName(property);
//            
//            NSString *proName = [[NSString alloc] initWithCString:propertyName encoding:NSUTF8StringEncoding];
//            NSString *realKeyName = [@"FIELD_KEY_" stringByAppendingString:proName];
//            NSNumber* fieldKey = kAppDelegate.configModel.FIELD_KEY_DICTS[realKeyName] ?: @0;
//            //int类型
//            if ([[NSString stringWithCString:[AMSUtil getPropertyType:property]  encoding:NSUTF8StringEncoding] isEqualToString:@"i"]) {
//                auto field = dataMessage->GetField((int32)fieldKey.integerValue);
//                NSNumber* proValue = @(field->GetInt32());
////                DLog(@"GET FIELD ---- (%@ = %@ , %@)",realKeyName,fieldKey,proValue);
//                [model setValue:proValue forKey:proName];
//            }else{
//                //string类型
//                auto field = dataMessage->GetField((int32)fieldKey.integerValue);
//                NSString* proValue = [NSString stringWithUTF8String:field->GetString()];
////                DLog(@"GET FIELD ---- (%@ = %@ , %@)",realKeyName,fieldKey,proValue);
//                [model setValue:proValue forKey:proName];
//            }
//        }
//         free(propertyList);
//    }
    unsigned int count = 0;
    objc_property_t *propertyList =  class_copyPropertyList(clazz, &count);
//    id model = [[clazz alloc] init];
    for(int i=0;i<count;i++)
    {
        //取出每一个属性
        objc_property_t property = propertyList[i];
        //获取每一个属性的变量名
        const char* propertyName = property_getName(property);
        
        NSString *proName = [[NSString alloc] initWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSString *realKeyName = [@"FIELD_KEY_" stringByAppendingString:proName];
        NSNumber* fieldKey = kAppDelegate.configModel.FIELD_KEY_DICTS[realKeyName] ?: @0;
//         NSLog(@"%@ - %@",realKeyName,[NSString stringWithCString:[AMSUtil getPropertyType:property]  encoding:NSUTF8StringEncoding]);
        //int类型
        if ([[NSString stringWithCString:[AMSUtil getPropertyType:property]  encoding:NSUTF8StringEncoding] isEqualToString:@"NSNumber"]) {
           
            auto field = dataMessage->GetField((int32)fieldKey.integerValue);
            NSNumber* proValue = @(field->GetInt32());
//            DLog(@"GET FIELD ---- (%@ = %@ , %@)",realKeyName,fieldKey,proValue);
            [model setValue:proValue forKey:proName];
        }else{
            //string类型
            auto field = dataMessage->GetField((int32)fieldKey.integerValue);
//            NSString* proValue = [NSString stringWithUTF8String:field->GetString()];
            NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            NSString * proValue = [[NSString alloc] initWithCString:field->GetString() encoding:gbkEncoding];
//            DLog(@"GET FIELD ---- (%@ = %@ , %@)",realKeyName,fieldKey,proValue);
            [model setValue:proValue forKey:proName];
        }
    }

    //c语言的函数，所以要去手动的去释放内存
    free(propertyList);
    //    }
    return model;
}


+(best_protocol::IBestMessge*)packMessage:(NSData *)data{
    const void* message = data.bytes;
    int32 length = (int32)data.length;
    InitBestMessge();
    best_protocol::IBestMessgeFactory *m_factory = CreateBestMessgeFactrotyInstance();
    best_protocol::IBestMessge* phase_best_message = m_factory->CreateBestMessage();
    phase_best_message->SetBuffer(message, length);
    phase_best_message->Deserialize();
//    best_protocol::IBestRPCHead *phase_best_rpc_head = phase_best_message->GetRpcHead();
//    if(phase_best_rpc_head){
//        NSLog(@"---- 解析rpc头 --- ");
//        NSLog(@"功能号---- %d",phase_best_rpc_head->GetFuncNo());
//        [dict setObject:@(phase_best_rpc_head->GetFuncNo()) forKey:function_FuncNo_key];
////        NSLog(@"序列号---- %llu",phase_best_rpc_head->GetSeqNum());
////        NSLog(@"状态---- %d",phase_best_rpc_head->GetStatus());
//    }
//    best_protocol::IBestHeadMessage* routeHead = GetBestRouteHead(phase_best_message, 0);
//    if (routeHead) {
//        NSLog(@"--- 解析路由头 ---");
//        IBestDataMessage* defaultBestHeadMessage = routeHead->GetDataMessage();
//    }
    return phase_best_message;
}

+(best_protocol::IBestRPCHead*)packMessageRPCHead:(NSData *)data{
    const void* message = data.bytes;
    int32 length = (int32)data.length;
    InitBestMessge();
    best_protocol::IBestMessgeFactory *m_factory = CreateBestMessgeFactrotyInstance();
    best_protocol::IBestRPCHead* rpcHeader = m_factory->CreateRpcHead();
    rpcHeader->SetBuffer(message, length);
    rpcHeader->Deserialize();
    return rpcHeader;
}

+(int32)generateRequestID{
    return requestId ++;
}

+(best_protocol::IBestHeadMessage *)generateCommonField{
    InitBestMessge();
    best_protocol::IBestMessgeFactory *m_factory = CreateBestMessgeFactrotyInstance();
    best_protocol::IBestHeadMessage* phase_best_head_message = m_factory->CreateHeadMessage();//创建路由体
    IBestField *requestIdField = m_factory ->CreateBestField();
    requestIdField->SetInt32([BestMessageUtil generateRequestID]);
    phase_best_head_message ->SetField(FIELD_KEY_nRequestID, requestIdField);
    return phase_best_head_message;
}

// 获取best协议的route头
+(best_protocol::IBestHeadMessage* )GetBestRouteHead:(best_protocol::IBestMessge* )lpBestMsg index:(int32) iIndex
{
    IBestHeadMessage* lpBestRoute = NULL;
    if (NULL == lpBestMsg)
    {
        //HxLOG_WARNING("%s[%d]: param error.", __FUNCTION__, __LINE__);
        return lpBestRoute;
    }

    best_protocol::BestIterator* lpBestIter = lpBestMsg->GetIterator();
    lpBestIter->First();
    int32 iTmpIdx = 0;
    for (; !lpBestIter->IsDone(); lpBestIter->Next())
    {
        if (iTmpIdx == iIndex)
        {
            lpBestRoute = (IBestHeadMessage*)lpBestIter->CurrentItem();
            break;
        }
        iTmpIdx++;
    }
    return lpBestRoute;
}

// 获取best协议的data数据
+(best_protocol::IBestDataMessage*) GetBestMessageDataMessage:(best_protocol::IBestMessge* )lpBestMsg index:(int32) iIndex
{
    IBestDataMessage* lpBestMsgData = NULL;
    IBestHeadMessage* lpBestRoute = [BestMessageUtil GetBestRouteHead:lpBestMsg index:iIndex];
    if (NULL != lpBestRoute)
    {
        lpBestMsgData = lpBestRoute->GetDataMessage();
    }
    return lpBestMsgData;
}

@end
