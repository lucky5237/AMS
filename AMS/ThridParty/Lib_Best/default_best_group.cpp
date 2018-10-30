#include "default_best_group.h"
#include "best_message.h"
#include "default_message_pool.h"
#include "default_best_group.h"
/************************IBestBase接口*************************/
///增加引用计数，返回自身
IBestBase*  BEST_FUNCTION_CALL_MODE DefaultBestGroup::AddRef(){
	++m_ref;
	return this;
}

///减少引用计数，当为0时释放自身
uint64  BEST_FUNCTION_CALL_MODE DefaultBestGroup::Release(){
	if (--m_ref == 0)delete this;
	return 0;
}

///返回BEST对象类型
BEST_OBJECT_TYPE  BEST_FUNCTION_CALL_MODE DefaultBestGroup::GetBestType()
{ 
	return OBJ_NONE; 
}

///设置所属对象
int32 BEST_FUNCTION_CALL_MODE DefaultBestGroup::SetOwner(IBestBase* best_base)
{
	return 0;
}

///获取所属对象
IBestBase* BEST_FUNCTION_CALL_MODE DefaultBestGroup::GetOwner()
{
	return 0;
}

/****************************IBestStream接口******************************/
///序列化对象
const void*  BEST_FUNCTION_CALL_MODE DefaultBestGroup::Serialize(int32* len)
{
	return 0;
}
///反序列化
int32 BEST_FUNCTION_CALL_MODE DefaultBestGroup::Deserialize()
{
	return 0;
}

///设置流
int32	BEST_FUNCTION_CALL_MODE DefaultBestGroup::SetBuffer(const void* buffer, const int32& len)
{
	return 0;
}
///获取流
void*  BEST_FUNCTION_CALL_MODE DefaultBestGroup::GetBuffer(int32* len)
{
	return 0;
}
///返回流状态. 1:可用 0:不可用
int32  BEST_FUNCTION_CALL_MODE DefaultBestGroup::Status()
{
	return 0;
}
///设置序列化器
int32   BEST_FUNCTION_CALL_MODE DefaultBestGroup::SetBestSerializer(IBestSerializer* serializer)
{
	return 0;
}
///获取序列化器

IBestSerializer* BEST_FUNCTION_CALL_MODE DefaultBestGroup::GetBestSerializer()
{
	return 0;
}
///新增一条记录,返回增加后的记录对象
IBestRecord * BEST_FUNCTION_CALL_MODE DefaultBestGroup::AddRecord()
{
	return 0;
}
///新增一条已存在的记录
int BEST_FUNCTION_CALL_MODE DefaultBestGroup::AddRecord(IBestRecord * best_record)
{
	return 0;
}

///获取记录迭代器
DefaultBestIterator* BEST_FUNCTION_CALL_MODE DefaultBestGroup::GetIterator()
{
	return 0;
}

///从另一个对象复制到自身
int32 BEST_FUNCTION_CALL_MODE DefaultBestGroup::CopyFrom(const IBestGroup* other)
{
	return 0;
}

///复制自身
IBestGroup* BEST_FUNCTION_CALL_MODE DefaultBestGroup::Clone() const
{
	return 0;
}

// 获取当前字段的协议
const PROTOCAL_TYPE BEST_FUNCTION_CALL_MODE DefaultBestGroup::GetProtocal()
{ 
	return m_protocal_type;
}

//设置协议类型
int32 BEST_FUNCTION_CALL_MODE DefaultBestGroup::SetProtocal(PROTOCAL_TYPE protpcal)
{
	m_protocal_type = protpcal;
	return 0;
}
