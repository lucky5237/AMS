//
//  BestMessageUtil.m
//  AMS
//  best消息工具类
//  Created by jianlu on 2018/10/30.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "BestMessageUtil.h"

@implementation BestMessageUtil

+(NSData *)GenerateBestMsg:(NSString*)message{
    InitBestMessge();
    best_protocol::IBestMessgeFactory *m_factory = CreateBestMessgeFactrotyInstance();
    best_protocol::IBestMessge* phase_best_message = m_factory->CreateBestMessage();
    best_protocol::IBestRPCHead * phase_best_rpc_head = m_factory->CreateRpcHead();//创建RPC头
    best_protocol::IBestHeadMessage* phase_best_head_message = m_factory->CreateHeadMessage();//创建路由体
    best_protocol::IBestDataMessage* phase_best_dataLayer = m_factory->CreateDataMessage(best_protocol::BEST_DATA_RAW);//创建数据体
    phase_best_rpc_head->SetFuncNo(1024);
    phase_best_rpc_head->SetPackType(best_protocol::PACKTTYPE_REQUEST);
    phase_best_rpc_head->SetSeqNum(123);
    phase_best_rpc_head->SetStatus(0);
    phase_best_dataLayer->SetBuffer([message UTF8String],(int32)strlen([message UTF8String]));
    phase_best_head_message->SetDataMessage(phase_best_dataLayer);
    phase_best_head_message->GetField(0)->SetString("linx");
    phase_best_head_message->GetField(1)->SetInt32(1);
    phase_best_message->AddHeadMessage(phase_best_head_message);
    phase_best_message->SetRpcHead(phase_best_rpc_head);
    int32 msg_length = (int32)strlen([message UTF8String]);
    const void* data = phase_best_message->Serialize(&msg_length);
    NSData *sendData = [[NSData alloc] initWithBytes:data length:msg_length];
    return sendData;

}

+(best_protocol::IBestMessge *)packMessage:(NSData *)data{
    const void* message = data.bytes;
    int32 length = (int32)data.length;
    InitBestMessge();
    best_protocol::IBestMessgeFactory *m_factory = CreateBestMessgeFactrotyInstance();
    best_protocol::IBestMessge* phase_best_message = m_factory->CreateBestMessage();
    phase_best_message->SetBuffer(message, length);
    phase_best_message->Deserialize();
    return phase_best_message;
}

// 获取best协议的route头
best_protocol::IBestHeadMessage* GetBestRouteHead(best_protocol::IBestMessge* lpBestMsg, int32 iIndex)
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
best_protocol::IBestDataMessage* GetBestMessageDataMessage(best_protocol::IBestMessge* lpBestMsg, int32 iIndex)
{
    IBestDataMessage* lpBestMsgData = NULL;
    IBestHeadMessage* lpBestRoute = GetBestRouteHead(lpBestMsg, iIndex);
    if (NULL != lpBestRoute)
    {
        lpBestMsgData = lpBestRoute->GetDataMessage();
    }
    return lpBestMsgData;
}

@end
