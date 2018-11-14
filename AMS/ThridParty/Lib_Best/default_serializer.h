
#ifndef DEFAULT_SERIALIZER_H
#define DEFAULT_SERIALIZER_H
#include"best_message.h"
using namespace best_protocol;
class DefaultBestSerializer :public IBestSerializer
{
private:
	DefaultBestSerializer()   //构造函数是私有的  
	{
	}
	PROTOCAL_TYPE m_protocol_type;
	static DefaultBestSerializer *m_pInstance; 
public:
	//获取当前字段的协议
	virtual const PROTOCAL_TYPE BEST_FUNCTION_CALL_MODE GetProtocal();
	virtual int32 BEST_FUNCTION_CALL_MODE SetProtocal(PROTOCAL_TYPE protpcal);
	static DefaultBestSerializer * GetInstance()
	{
		if (m_pInstance == 0)
		{
			m_pInstance = new DefaultBestSerializer();
		}
		return m_pInstance;
	}
	const void*  BEST_FUNCTION_CALL_MODE SerializeMessage(int32& len, IBestMessage* message);
	const void*  BEST_FUNCTION_CALL_MODE SerializeRpcMessage(int32& len, IBestRPCHead* best_rpchead);
	const void*  BEST_FUNCTION_CALL_MODE SerializeHeadMessage(int32& len, IBestHeadMessage* head_message);
	const void*  BEST_FUNCTION_CALL_MODE SerializeDataHeadMessage(int32& len, IBestHeadMessage* head_message);
	const void*  BEST_FUNCTION_CALL_MODE SerializeDataMessage(int32& len, IBestDataMessage* data_message);
	const void*  BEST_FUNCTION_CALL_MODE SerializeGroup(int32& len, IBestGroup* best_group);
	const void*  BEST_FUNCTION_CALL_MODE SerializeRecord(int32& len, IBestRecord* best_record);
	const void*  BEST_FUNCTION_CALL_MODE SerializeField(int32& len, IBestField* best_field);

	int BEST_FUNCTION_CALL_MODE DeserializeMessage(IBestMessage* message, const void* buffer, const int32& len);
	int BEST_FUNCTION_CALL_MODE DeserializeRpcMessage(IBestRPCHead* best_rpchead, const void* buffer, const int32& len);
	int BEST_FUNCTION_CALL_MODE DeserializeDataHeadMessage(IBestHeadMessage* head_message, const void* buffer, const int32& len);
	int BEST_FUNCTION_CALL_MODE DeserializeHeadMessage(IBestHeadMessage* head_message, const void* buffer, const int32& len);
	int BEST_FUNCTION_CALL_MODE DeserializeDataMessage(IBestDataMessage* head_message, const void* buffer, const int32& len);
	int BEST_FUNCTION_CALL_MODE DeserializeGroup(IBestGroup* group, const void* buffer, const int32& len);
	int BEST_FUNCTION_CALL_MODE DeserializeRecord(IBestRecord* record, const void* buffer, const int32& len);
	int BEST_FUNCTION_CALL_MODE DeserializeField(IBestField* field, const void* buffer, const int32& len);

	///返回序列化器的ID
	const char* BEST_FUNCTION_CALL_MODE GetProtocol() { return 0; }

	///获取错误号
	int BEST_FUNCTION_CALL_MODE GetErrorNo() { return 0; }

	///获取错误原因
	const char* BEST_FUNCTION_CALL_MODE GetErrorString(int err) { return 0; }

};


#endif