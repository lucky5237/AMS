#ifndef DEFAULT_BEST_MESSAGE_FACTORY_H
#define DEFAULT_BEST_MESSAGE_FACTORY_H
#include <map>
#include <string>
#include "best_message.h"

using namespace best_protocol;
class DefaultBestMessgeFactory :public IBestMessgeFactory
{
	static DefaultBestMessgeFactory *m_pInstance;
public:
	static DefaultBestMessgeFactory* GetInstance()
	{
		if (m_pInstance == 0)  //判断是否第一次调用  
			m_pInstance = new DefaultBestMessgeFactory();
		return m_pInstance;
	}
	static std::map<PROTOCAL_TYPE, IBestSerializer*> m_best_serianlizer_map;
	///创建BestMessage消息，根据协议关联序列化器
	virtual IBestMessge* BEST_FUNCTION_CALL_MODE CreateBestMessage(PROTOCAL_TYPE protocal_type);
	

	///创建BestRPC头部消息
	virtual IBestRPCHead* BEST_FUNCTION_CALL_MODE CreateRpcHead(PROTOCAL_TYPE protocal_type);
	

	///创建Best头部消息
	virtual IBestHeadMessage* BEST_FUNCTION_CALL_MODE CreateHeadMessage(PROTOCAL_TYPE protocal_type);
	

	///创建BestMessage消息，根据协议关联序列化器
	virtual IBestDataMessage* BEST_FUNCTION_CALL_MODE CreateDataMessage(PROTOCAL_TYPE protocal_type);
	

	///创建BestGroup消息，根据协议关联序列化器
	virtual IBestGroup* BEST_FUNCTION_CALL_MODE CreateBestGroup(PROTOCAL_TYPE protocal_type);
	

	///创建Best记录消息，根据协议关联序列化器
	virtual IBestRecord* BEST_FUNCTION_CALL_MODE CreateBestRecord(PROTOCAL_TYPE protocal_type);
	

	///创建Best字段，根据协议关联序列化器
	virtual IBestField* BEST_FUNCTION_CALL_MODE CreateBestField(PROTOCAL_TYPE protocal_type);
	
	///根据协议返回序列化器
	virtual IBestSerializer* BEST_FUNCTION_CALL_MODE GetSerializer(PROTOCAL_TYPE protocal_type);
	
};
#endif