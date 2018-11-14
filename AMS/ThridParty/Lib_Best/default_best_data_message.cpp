#include "default_best_data_message.h"
#include "default_message_pool.h"
#include "default_best_message_factory.h"
#include "default_serializer.h"
#include "default_best_field.h"
#include <string.h>

uint64 DefaultBestDataHeadMessage::Release()
{
	if (m_ref > 0)
	{
		if (--m_ref == 0)
		{	
			if (m_data_msg != NULL)
			{
				m_data_msg->Release();
			}
			m_data_msg = NULL;
			if (m_best_buffer != NULL)
			{
				DefaultMessagePool::ReleaseBestBuffer(m_best_buffer);
			}
			m_best_buffer = NULL;
			std::map<int, IBestField*>::iterator itor = m_best_field_map.begin();
			for (; itor != m_best_field_map.end(); ++itor)
			{
				DefaultMessagePool::ReleaseDefaultBestField((DefaultBestField*)itor->second);
			}
			m_best_field_map.clear();
			memset(&m_best_head_struct, 0, sizeof(BestDataHeadStruct_t));

			DefaultMessagePool::ReleaseDefaultBestDataHeadMessage(this);
			m_status = 0;

		}
	}
	return 0;
}

///获取头部长度,0表示当前无法获取头部长度
int32 DefaultBestDataHeadMessage::GetHeadLength()
{
	return m_best_head_struct.head_length; 
}

///获取数据长度,0表示当前无法获取数据长度
int32 DefaultBestDataHeadMessage::GetDataLength()
{
	return m_best_head_struct.content_length;
}

void DefaultBestDataHeadMessage::SetDataLength(int32 data_lenght)
{
	m_best_head_struct.content_length = data_lenght;
}

///设置数据层消息
int32 BEST_FUNCTION_CALL_MODE DefaultBestDataHeadMessage::SetDataMessage(IBestDataMessage* data_msg)
{
	m_data_msg = (DefaultBestDataMessage* )data_msg;
	return 0;
}

///获取数据层消息
IBestDataMessage* DefaultBestDataHeadMessage::GetDataMessage()
{
	return (IBestDataMessage*)m_data_msg;
}

///从另一个消息复制到自身
int32 BEST_FUNCTION_CALL_MODE DefaultBestDataHeadMessage::CopyFrom(const IBestHeadMessage* other)
{
	DefaultBestDataHeadMessage* head_message = (DefaultBestDataHeadMessage*)(other);
	m_best_head_struct = head_message->m_best_head_struct;
	m_protocol_type = head_message->m_protocol_type;
	std::map<int, IBestField*>::iterator itor;
	itor = m_best_field_map.begin();
	for (; itor != m_best_field_map.end(); ++itor)
	{
		itor->second->Release();
	}
	m_best_field_map.clear();
	itor = head_message->m_best_field_map.begin();
	for (; itor != head_message->m_best_field_map.end(); ++itor)
	{
		this->GetField(itor->first)->CopyFrom(itor->second);
	}
	//IBestDataMessage* data_message = head_message->GetDataMessage();
	//if (data_message != NULL)
	//{
	//	IBestDataMessage* self_data_message = GetDataMessage();
	//	if (self_data_message != NULL)
	//	{
	//		self_data_message->Release();
	//	}
	//	this->SetDataMessage(DefaultMessagePool::AcquireDefaultBestDataMessage());
	//	GetDataMessage()->CopyFrom(data_message);
	//}
	return 0;
}
///复制自身
IBestHeadMessage* BEST_FUNCTION_CALL_MODE DefaultBestDataHeadMessage::Clone()
{
	DefaultBestDataHeadMessage* headMessge = DefaultMessagePool::AcquireDefaultBestDataHeadMessage();
	headMessge->CopyFrom(this);
	return headMessge;
}

///序列化对象
const void*  DefaultBestDataHeadMessage::Serialize(int32* len)
{
	if (m_best_buffer != NULL)
	{
		DefaultMessagePool::ReleaseBestBuffer(m_best_buffer);
	}
	IBestSerializer*  serializer = DefaultBestMessgeFactory::GetInstance()->GetSerializer(m_protocol_type);
	m_best_buffer = (BestBuffer*)serializer->SerializeDataHeadMessage(*len, this);
	m_best_head_struct.head_length = m_best_buffer->len;
	BestDataHeadStruct_t* headStruct = (BestDataHeadStruct_t*)m_best_buffer->buff;
	headStruct->head_length = m_best_buffer->len;
	m_status = 1;
	return m_best_buffer->buff;
}
///反序列化
int32 DefaultBestDataHeadMessage::Deserialize()
{
	memcpy(&m_best_head_struct, m_best_buffer->buff, sizeof(BestDataHeadStruct_t));
	DefaultBestSerializer*  serializer = DefaultBestSerializer::GetInstance();
	return serializer->DeserializeDataHeadMessage(this, m_best_buffer->buff, m_best_buffer->len);
}
///设置流
int32 DefaultBestDataHeadMessage::SetBuffer(const void* buffer, const int32& len)
{
	if (m_best_buffer != NULL)
	{
		DefaultMessagePool::ReleaseBestBuffer(m_best_buffer);
	}
	m_best_buffer = DefaultMessagePool::AcquireBestBuffer(len);
	m_best_buffer->len = len;
	memcpy(m_best_buffer->buff, buffer, len);	
	return 0;
}
///获取流
void* DefaultBestDataHeadMessage::GetBuffer(int32* len)
{
	*len = m_best_buffer->len;
	return m_best_buffer->buff;
}

/**********************************获取和设置*************************/
///获取$tag的字段,NULL表示不存在
IBestField*  BEST_FUNCTION_CALL_MODE DefaultBestDataHeadMessage::GetField(const int32& tag)
{
	std::map<int, IBestField*>::iterator field_itor = m_best_field_map.find(tag);
	if (field_itor != m_best_field_map.end())
	{
		return field_itor->second;
	}
	else
	{
		IBestField* best_field = (DefaultBestField*)DefaultMessagePool::AcquireDefaultBestField();
		((DefaultBestField*)best_field)->SetTag(tag);
		m_best_field_map[tag] = best_field;
		return best_field;
	}
}

///设置$tag的字段
void BEST_FUNCTION_CALL_MODE DefaultBestDataHeadMessage::SetField(const int32& tag, IBestField* field)
{
	m_best_field_map[tag] = field;
	return;
}

///判断$tag的字段是否存在
bool BEST_FUNCTION_CALL_MODE DefaultBestDataHeadMessage::IsExistField(const int32& tag)
{
	std::map<int, IBestField*>::iterator itor = m_best_field_map.find(tag);
	if (itor != m_best_field_map.end())
	{
		return true;
	}
	return false;
}

//获取当前字段的协议
const PROTOCAL_TYPE DefaultBestDataHeadMessage::GetProtocal()
{
	return m_protocol_type;
}

int32  DefaultBestDataHeadMessage::SetProtocal(PROTOCAL_TYPE protpcal)
{
	m_protocol_type = protpcal;
	return 0;
}

//////////////////////////////////////////////////////////////////////////

IBestBase* DefaultBestDataMessage::AddRef()
{
	if(++m_ref)
	{
		Init();
	}
	return this;
}

void DefaultBestDataMessage::Init()
{
	m_best_data_head_message = 0;
	m_best_data_head_message = DefaultMessagePool::AcquireDefaultBestDataHeadMessage();
	m_best_data_head_message->SetProtocal();
	return ;
}

uint64  DefaultBestDataMessage::Release()
{
	if (m_ref > 0)
	{
		if (--m_ref == 0)
		{
			///
			if(0 != m_best_data_head_message)
			{
				m_best_data_head_message->Release();
				m_best_data_head_message = 0;
			}
			///
			if (m_best_buffer != NULL)
			{
				DefaultMessagePool::ReleaseBestBuffer(m_best_buffer);
			}
			m_best_buffer = NULL;
			m_status = 0;
			DefaultMessagePool::ReleaseDefaultBestDataMessage(this);
		}
	}
	return 0;
}

///设置头部流
int32 DefaultBestDataMessage::SetHeadBuffer(const void* buffer, const int32& len)
{
	if(0 == m_best_data_head_message)
	{
		return -1;
	}
	return m_best_data_head_message->SetBuffer(buffer,len);
}
///获取尾部流
void* DefaultBestDataMessage::GetHeadBuffer(int32* len)
{
	return m_best_data_head_message->GetBuffer(len);
}

///设置流
int32	DefaultBestDataMessage::SetBuffer(const void* buffer, const int32& len)
{ 
 	if (m_best_buffer != NULL)
	{
		DefaultMessagePool::ReleaseBestBuffer(m_best_buffer);
	}
	m_best_buffer = DefaultMessagePool::AcquireBestBuffer(len);
	m_best_buffer->len = len;
	memcpy(m_best_buffer->buff, buffer, m_best_buffer->len);
	return 0; 
}

void*  DefaultBestDataMessage::GetBuffer(int32* len)
{ 
	if (m_best_buffer != NULL)
	{
	    *len = m_best_buffer->len;
	    return m_best_buffer->buff;
	}
	else
	{
		*len = 0;
		return NULL;
	}
	
}

///序列化头部对象
const void*  BEST_FUNCTION_CALL_MODE DefaultBestDataMessage::SerializeHead(int32* len)
{
	return m_best_data_head_message->Serialize(len);
}
///反序列化头部
int32 BEST_FUNCTION_CALL_MODE DefaultBestDataMessage::DeserializeHead()
{
	return m_best_data_head_message->Deserialize();
}

///序列化对象
const void*  DefaultBestDataMessage::Serialize(int32* len)
{ 
	m_status = 1;
	if (m_best_buffer != NULL)
	{
		*len = m_best_buffer->len;
		return (void*)m_best_buffer->buff;
	}
	else
	{
		*len = 0;
		return 0;
	}
	
}
///反序列化
int32 DefaultBestDataMessage::Deserialize()
{
	m_status = 1;
	return 0; 
}

const PROTOCAL_TYPE DefaultBestDataMessage::GetProtocal()
{
	return m_protocol_type;
}

int32  DefaultBestDataMessage::SetProtocal(PROTOCAL_TYPE protpcal)
{
	m_protocol_type = protpcal;
	return 0;
}

int32  DefaultBestDataMessage::Status()
{ 
	return m_status;
}

///获取$tag的字段,NULL表示不存在
IBestField*  BEST_FUNCTION_CALL_MODE DefaultBestDataMessage::GetField(const int32& tag) 
{ 
	if(0 == m_best_data_head_message)
	{
		return 0;
	}
	return m_best_data_head_message->GetField(tag); 
}

///设置$tag的字段
void BEST_FUNCTION_CALL_MODE DefaultBestDataMessage::SetField(const int32& tag, IBestField* field)
{
	if(0 == m_best_data_head_message)
	{
		return;
	}
	return m_best_data_head_message->SetField(tag,field); 
}

///判断$tag的字段是否存在
bool BEST_FUNCTION_CALL_MODE DefaultBestDataMessage::IsExistField(const int32& tag)
{ 
	if(0 == m_best_data_head_message)
	{
		return false;
	}
	return m_best_data_head_message->IsExistField(tag); 
}

///从另一个对象复制到自身
int32 DefaultBestDataMessage::CopyFrom(const IBestDataMessage *other)
{
	DefaultBestDataMessage* tmp = (DefaultBestDataMessage*)other;
	//
	DefaultBestDataHeadMessage* data_head_message = (DefaultBestDataHeadMessage*)tmp->GetDataHeadMessage();
	m_best_data_head_message->CopyFrom(data_head_message);
	//
	int32 buffer_len;
	void* buffer = tmp->GetBuffer(&buffer_len);
	SetBuffer(buffer, buffer_len);
	return 0; 
}


int DefaultBestDataMessage::ReleaseBuffer()
{
	if (m_best_buffer != NULL)
	{
		DefaultMessagePool::ReleaseBestBuffer(m_best_buffer);
		m_best_buffer = NULL;
	}
	return 0;
}
///复制自身
IBestDataMessage* BEST_FUNCTION_CALL_MODE DefaultBestDataMessage::Clone() { return 0; }
