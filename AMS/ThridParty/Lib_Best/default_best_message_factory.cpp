#include "default_best_message_factory.h"
#include "default_serializer.h"
#include "default_best_rpchead.h"
#include "default_best_message.h"
#include "default_head_message.h"
#include "default_bestIteror.h"
#include "default_message_pool.h"
#include "default_best_field.h"
#include "default_best_data_message.h"
#include "default_best_group.h"
#include "default_best_record.h"
DefaultBestMessgeFactory* DefaultBestMessgeFactory::m_pInstance;
std::map<PROTOCAL_TYPE, IBestSerializer*> DefaultBestMessgeFactory::m_best_serianlizer_map;
///创建BestMessage消息，根据协议关联序列化器
IBestMessge* BEST_FUNCTION_CALL_MODE DefaultBestMessgeFactory::CreateBestMessage(PROTOCAL_TYPE protocal_type)
{
	DefaultBestMessge* message = DefaultMessagePool::AcquireDefaultBestMessge();
	message->SetProtocal(protocal_type);
	return message;
}

///创建BestRPC头部消息
IBestRPCHead* BEST_FUNCTION_CALL_MODE DefaultBestMessgeFactory::CreateRpcHead(PROTOCAL_TYPE protocal_type)
{
	DefaultBestRPCHead* head_rpc = DefaultMessagePool::AcquireDefaultBestRPCHead();
	head_rpc->SetProtocal(protocal_type);
	return head_rpc;
}

///创建Best头部消息
IBestHeadMessage* BEST_FUNCTION_CALL_MODE DefaultBestMessgeFactory::CreateHeadMessage(PROTOCAL_TYPE protocal_type)
{
	DefaultBestHeadMessage* head_message = DefaultMessagePool::AcquireDefaultBestHeadMessage();
	head_message->SetProtocal(protocal_type);
	return head_message;
}

///创建BestMessage消息，根据协议关联序列化器
IBestDataMessage* BEST_FUNCTION_CALL_MODE DefaultBestMessgeFactory::CreateDataMessage(PROTOCAL_TYPE protocal_type)
{
	DefaultBestDataMessage* best_data_message = DefaultMessagePool::AcquireDefaultBestDataMessage();
	best_data_message->SetProtocal(protocal_type);
	return best_data_message;
}

///创建BestGroup消息，根据协议关联序列化器
IBestGroup* BEST_FUNCTION_CALL_MODE DefaultBestMessgeFactory::CreateBestGroup(PROTOCAL_TYPE protocal_type)
{
	DefaultBestGroup* default_best_group = DefaultMessagePool::AcquireDefaultBestGroup();
	default_best_group->SetProtocal(protocal_type);
	return default_best_group;
}

///创建Best记录消息，根据协议关联序列化器
IBestRecord* BEST_FUNCTION_CALL_MODE DefaultBestMessgeFactory::CreateBestRecord(PROTOCAL_TYPE protocal_type)
{
	DefaultBestRecord* default_best_record = DefaultMessagePool::AcquireDefaultBestRecord();
	default_best_record->SetProtocal(protocal_type);
	return default_best_record;
}

///创建Best字段，根据协议关联序列化器
IBestField* BEST_FUNCTION_CALL_MODE DefaultBestMessgeFactory::CreateBestField(PROTOCAL_TYPE protocal_type)
{
	DefaultBestField* best_field = DefaultMessagePool::AcquireDefaultBestField();
	best_field->SetProtocal(protocal_type);
	return best_field;
}

///根据协议返回序列化器
IBestSerializer* BEST_FUNCTION_CALL_MODE DefaultBestMessgeFactory::GetSerializer(PROTOCAL_TYPE protocal_type)
{
	IBestSerializer* serializer = NULL;
	/*std::map<PROTOCAL_TYPE, IBestSerializer*>::iterator itor = m_best_serianlizer_map.find(protocal_type);
	if (itor == m_best_serianlizer_map.end())
	{
		DefaultBestSerializer* default_serializer = DefaultBestSerializer::GetInstance();
		default_serializer->SetProtocal(protocal_type);
		m_best_serianlizer_map[protocal_type] = default_serializer;
	}
	serializer = m_best_serianlizer_map[protocal_type];*/
	serializer = DefaultBestSerializer::GetInstance();
	return serializer;
}