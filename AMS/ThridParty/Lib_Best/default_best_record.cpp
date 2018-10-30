#include "default_best_group.h"
#include "best_message.h"
#include "default_message_pool.h"
#include "default_best_record.h"
/************************IBestBase接口*************************/
using namespace best_protocol;
///获取$tag的字段,NULL表示不存在
IBestField*  BEST_FUNCTION_CALL_MODE DefaultBestRecord::GetField(const int32& tag)
{
	return 0;
}
///设置$tag的字段
void BEST_FUNCTION_CALL_MODE DefaultBestRecord::SetField(const int32& tag, IBestField* field)
{
	
}
///判断$tag的字段是否存在
bool BEST_FUNCTION_CALL_MODE DefaultBestRecord::IsExistField(const int32& tag)
{
	return 0;
}
///从另一个对象复制到自身
int32 BEST_FUNCTION_CALL_MODE DefaultBestRecord::CopyFrom(const IBestRecord *other)
{
	return 0;
}
///复制自身
IBestRecord* BEST_FUNCTION_CALL_MODE DefaultBestRecord::Clone()
{
	return 0;
}
///获取字段迭代器
DefaultBestIterator* BEST_FUNCTION_CALL_MODE DefaultBestRecord::GetIterator()
{
	return 0;
}

/************************IBestBase接口*************************/
///增加引用计数，返回自身
IBestBase*  BEST_FUNCTION_CALL_MODE DefaultBestRecord::AddRef(){
	++m_ref;
	return this;
}

///减少引用计数，当为0时释放自身
uint64  BEST_FUNCTION_CALL_MODE DefaultBestRecord::Release(){
	if (--m_ref == 0)delete this;
	return 0;
}

///返回BEST对象类型
BEST_OBJECT_TYPE  BEST_FUNCTION_CALL_MODE DefaultBestRecord::GetBestType()
{ 
	return OBJ_NONE; 
}

///设置所属对象
int32 BEST_FUNCTION_CALL_MODE DefaultBestRecord::SetOwner(IBestBase* best_base)
{ 
	return 0; 
}

///获取所属对象
IBestBase* BEST_FUNCTION_CALL_MODE DefaultBestRecord::GetOwner()
{ 
	return 0; 
}

/****************************IBestStream接口******************************/
///序列化对象
const void*  BEST_FUNCTION_CALL_MODE DefaultBestRecord::Serialize(int32* len)
{ 
	return 0; 
}
///反序列化
int32 BEST_FUNCTION_CALL_MODE DefaultBestRecord::Deserialize()
{ 
	return 0; 
}

///设置流
int32	BEST_FUNCTION_CALL_MODE DefaultBestRecord::SetBuffer(const void* buffer, const int32& len)
{ 
	return 0; 
}
///获取流
void*  BEST_FUNCTION_CALL_MODE DefaultBestRecord::GetBuffer(int32* len)
{ 
	return 0; 
}
///返回流状态. 1:可用 0:不可用
int32  BEST_FUNCTION_CALL_MODE DefaultBestRecord::Status()
{ 
	return 0; 
}
///设置序列化器
int32   BEST_FUNCTION_CALL_MODE DefaultBestRecord::SetBestSerializer(IBestSerializer* serializer)
{ 
	return 0; 
}
///获取序列化器
IBestSerializer* BEST_FUNCTION_CALL_MODE DefaultBestRecord::GetBestSerializer()
{ 
	return 0; 
}

/// 获取当前字段的协议
const PROTOCAL_TYPE DefaultBestRecord::GetProtocal()
{
	return m_protocol_type;
}

int32 DefaultBestRecord::SetProtocal(PROTOCAL_TYPE protpcal)
{
	m_protocol_type = protpcal;
	return 0;
}
