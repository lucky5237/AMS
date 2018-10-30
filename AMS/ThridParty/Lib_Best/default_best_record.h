
#ifndef DEFAULT_BEST_RECORD_H
#define DEFAULT_BEST_RECORD_H
#include"best_message.h"
#include "atomic_count.h"
#include "default_bestIteror.h"
#include <string>
using namespace best_protocol;
class DefaultBestRecord :public  IBestRecord
{
private:
	atomic_count m_ref;
public:
	DefaultBestRecord(){  }
	virtual ~DefaultBestRecord(){};
	///获取$tag的字段,NULL表示不存在
	virtual IBestField*  BEST_FUNCTION_CALL_MODE GetField(const int32& tag);
	///设置$tag的字段
	virtual void BEST_FUNCTION_CALL_MODE SetField(const int32& tag, IBestField* field);
	///判断$tag的字段是否存在
	virtual bool BEST_FUNCTION_CALL_MODE IsExistField(const int32& tag);
	///从另一个对象复制到自身
	virtual int32 BEST_FUNCTION_CALL_MODE CopyFrom(const IBestRecord *other);
	///复制自身
	virtual IBestRecord* BEST_FUNCTION_CALL_MODE Clone();
	///获取字段迭代器
	virtual DefaultBestIterator* BEST_FUNCTION_CALL_MODE GetIterator();
private:
	DefaultBestIterator	m_defaultIterator;
	PROTOCAL_TYPE m_protocol_type;

public:
	/************************IBestBase接口*************************/
	///增加引用计数，返回自身
	virtual IBestBase*  BEST_FUNCTION_CALL_MODE AddRef();

	///减少引用计数，当为0时释放自身
	virtual uint64  BEST_FUNCTION_CALL_MODE Release();

	///返回BEST对象类型
	virtual BEST_OBJECT_TYPE  BEST_FUNCTION_CALL_MODE GetBestType();

	///设置所属对象
	virtual int32 BEST_FUNCTION_CALL_MODE SetOwner(IBestBase* best_base);

	///获取所属对象
	virtual IBestBase* BEST_FUNCTION_CALL_MODE GetOwner();

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
	virtual int32  BEST_FUNCTION_CALL_MODE Status();
	///设置序列化器
	virtual int32   BEST_FUNCTION_CALL_MODE SetBestSerializer(IBestSerializer* serializer);
	///获取序列化器
	virtual IBestSerializer* BEST_FUNCTION_CALL_MODE GetBestSerializer();

	// 获取当前字段的协议
	virtual const PROTOCAL_TYPE BEST_FUNCTION_CALL_MODE GetProtocal();
    //设置协议
	virtual int32 BEST_FUNCTION_CALL_MODE SetProtocal(PROTOCAL_TYPE protpcal);
};
#endif