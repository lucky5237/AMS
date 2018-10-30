#include "default_best_data_message.h"
#include "default_message_pool.h"
#include <string.h>
uint64  DefaultBestDataMessage::Release(){
	if (m_ref > 0)
	{
		if (--m_ref == 0)
		{
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

///从另一个对象复制到自身
int32 DefaultBestDataMessage::CopyFrom(const IBestDataMessage *other){ 
	DefaultBestDataMessage* tmp = (DefaultBestDataMessage*)other;
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
