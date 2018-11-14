
#ifndef DEFAULT_HEAD_MESSAGE_H
#define DEFAULT_HEAD_MESSAGE_H
#include"best_message.h"
#include <list>
#include <map>
#include <string>
#include "atomic_count.h"
#include "default_bestIteror.h"
#include "default_message_pool.h"
#include "default_best_data_message.h"
#include "default_best_field.h"
#include <string.h>
using namespace best_protocol;

#pragma pack(1)
typedef struct BestHeadStruct_t
{
	BestHeadStruct_t()
	{
		memset(this, 0, sizeof(BestHeadStruct_t));
	}
	int32 head_length;
	int32 content_length;
}BestHeadStruct;

#pragma pack()
class DefaultBestHeadMessage :public IBestHeadMessage
{
private:
	atomic_count m_ref;
	PROTOCAL_TYPE m_protocol_type;
	DefaultBestDataMessage* m_data_msg;

public:
	DefaultBestHeadMessage()
	{ 
		m_status = 0;
		m_best_buffer = NULL;
		m_data_msg = NULL;
		memset(&m_best_head_struct, 0, sizeof(BestHeadStruct));
		m_defaultIterator.Initail(&m_best_field_map);
	}
	virtual ~DefaultBestHeadMessage(){}

	///获取头部长度,0表示当前无法获取头部长度
	virtual int32 BEST_FUNCTION_CALL_MODE GetHeadLength();

	///获取数据长度,0表示当前无法获取数据长度
	virtual int32 BEST_FUNCTION_CALL_MODE GetDataLength();

	virtual void BEST_FUNCTION_CALL_MODE  SetDataLength(int32 data_lenght);

	/******************************************设置数据层******************************************/
	///设置数据层消息
	virtual int32 BEST_FUNCTION_CALL_MODE SetDataMessage(IBestDataMessage* data_msg);
	///获取数据层消息
	virtual IBestDataMessage* BEST_FUNCTION_CALL_MODE GetDataMessage();
	///从另一个消息复制到自身
	virtual int32 BEST_FUNCTION_CALL_MODE CopyFrom(const IBestHeadMessage* other);
	///复制自身
	virtual IBestHeadMessage* BEST_FUNCTION_CALL_MODE Clone();
	/**********************************获取和设置*************************/
	///获取$tag的字段,NULL表示不存在
	virtual IBestField*  BEST_FUNCTION_CALL_MODE GetField(const int32& tag);

	///设置$tag的字段
	virtual void BEST_FUNCTION_CALL_MODE SetField(const int32& tag, IBestField* field);

	///判断$tag的字段是否存在
	virtual bool BEST_FUNCTION_CALL_MODE IsExistField(const int32& tag);

	///获取字段迭代器
	virtual BestIterator* BEST_FUNCTION_CALL_MODE GetIterator(){ return  &m_defaultIterator; }

	//获取当前字段的协议
	virtual const PROTOCAL_TYPE BEST_FUNCTION_CALL_MODE GetProtocal();

private:
	DefaultBestMapIterator	m_defaultIterator;
	BestBuffer* m_best_buffer;
	int32 m_status;
public:
	std::map<int, IBestField*> m_best_field_map;
	BestHeadStruct m_best_head_struct;

public:
	/************************IBestBase接口*************************/
	///增加引用计数，返回自身
	virtual IBestBase*  BEST_FUNCTION_CALL_MODE AddRef();

	///减少引用计数，当为0时释放自身
	virtual uint64  BEST_FUNCTION_CALL_MODE Release();
	

	///返回BEST对象类型
	virtual BEST_OBJECT_TYPE  BEST_FUNCTION_CALL_MODE GetBestType(){ return OBJ_NONE; }

	///设置所属对象
	virtual int32 BEST_FUNCTION_CALL_MODE SetOwner(IBestBase* best_base){ return 0; }

	///获取所属对象
	virtual IBestBase* BEST_FUNCTION_CALL_MODE GetOwner(){ return 0; }

	/****************************IBestStream接口******************************/
	///序列化对象
	virtual const void*  BEST_FUNCTION_CALL_MODE Serialize(int32* len);
	///反序列化
	virtual int32 BEST_FUNCTION_CALL_MODE Deserialize();
	///设置流
	virtual int32	BEST_FUNCTION_CALL_MODE SetBuffer(const void* buffer, const int32& len);
	///获取流
	virtual void*  BEST_FUNCTION_CALL_MODE GetBuffer(int32* len);

	///返回流状态. 1:可用 0:不可用
	virtual int32  BEST_FUNCTION_CALL_MODE Status(){ return m_status; }
	///设置序列化器
	virtual int32   BEST_FUNCTION_CALL_MODE SetBestSerializer(IBestSerializer* serializer){ return 0; }
	///获取序列化器
	virtual IBestSerializer* BEST_FUNCTION_CALL_MODE GetBestSerializer(){ return 0; }

	virtual int32 BEST_FUNCTION_CALL_MODE SetProtocal(PROTOCAL_TYPE protpcal);

	int ReleaseBuffer();
};
#endif