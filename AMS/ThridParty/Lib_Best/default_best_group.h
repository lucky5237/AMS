

#ifndef DEFAULT_BEST_GROUP_H
#define DEFAULT_BEST_GROUP_H
#include"best_message.h"
#include "atomic_count.h"
#include "default_bestIteror.h"
#include <string>
using namespace best_protocol;
class DefaultBestGroup :public IBestGroup
{
private:
	atomic_count m_ref;
	PROTOCAL_TYPE m_protocal_type;
public:
	DefaultBestGroup(){  }
	virtual ~DefaultBestGroup(){};
	///新增一条记录,返回增加后的记录对象
	virtual IBestRecord * BEST_FUNCTION_CALL_MODE AddRecord();
	///新增一条已存在的记录
	virtual int BEST_FUNCTION_CALL_MODE AddRecord(IBestRecord * best_record);

	///获取记录迭代器
	virtual DefaultBestIterator* BEST_FUNCTION_CALL_MODE GetIterator();

	///从另一个对象复制到自身
	virtual int32 BEST_FUNCTION_CALL_MODE CopyFrom(const IBestGroup* other);

	///复制自身
	virtual IBestGroup* BEST_FUNCTION_CALL_MODE Clone() const;

	// 获取当前字段的协议
	virtual const PROTOCAL_TYPE BEST_FUNCTION_CALL_MODE GetProtocal();
	//设置协议类型
	virtual int32 BEST_FUNCTION_CALL_MODE SetProtocal(PROTOCAL_TYPE protpcal);
private:
	DefaultBestIterator	m_defaultIterator;

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

};
#endif