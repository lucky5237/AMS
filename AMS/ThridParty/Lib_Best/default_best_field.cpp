#include "default_best_field.h"
#include "best_message.h"
#include "default_message_pool.h"
#include<cstring>
DefaultBestField::DefaultBestField()
{
	m_bestBuffer = NULL;
	Reset();
}

void DefaultBestField::Reset()
{
	m_uint8_value = 0;
	m_uint16_value = 0;
	m_uint32_value = 0;
	m_uint64_value = 0;
	m_string = "";
	m_value_type = VT_NONE;
	if (m_bestBuffer != NULL)
	{
		DefaultMessagePool::ReleaseBestBuffer(m_bestBuffer);
		m_bestBuffer = NULL;
	}
	
}

uint8 DefaultBestField::GetInt8() const
{
	return m_uint8_value;
}
void  DefaultBestField::SetInt8(uint8 val)
{
	m_value_type = VT_INT8;
	m_uint8_value = val;
}
uint16	DefaultBestField::GetInt16() const
{
	return m_uint16_value;
}
void  DefaultBestField::SetInt16(uint16 val)
{
	m_value_type = VT_INT16;
	m_uint16_value = val;
}
uint32	DefaultBestField::GetInt32() const
{
	return m_uint32_value;
}
void DefaultBestField::SetInt32(uint32 val)
{
	m_value_type = VT_INT32;
	m_uint32_value = val;
}
uint64	DefaultBestField::GetInt64() const
{
	return m_uint64_value;
}
void DefaultBestField::SetInt64(uint64 val)
{
	m_value_type = VT_INT64;
	m_uint64_value = val;
}
const char*  DefaultBestField::GetString() const
{
	return m_string.c_str();
}
void  DefaultBestField::SetString(const char* val)
{
	m_value_type = VT_STRING;
	m_string = val;
}
void*  DefaultBestField::GetRawData(int* data_len)
{
	if (m_bestBuffer != NULL)
	{
		*data_len = m_bestBuffer->len;
		return m_bestBuffer->buff;
	}
	return NULL;
}
int32 DefaultBestField::GetRawDataLen() const
{
	return m_bestBuffer->len;
}
void  DefaultBestField::SetRawData(const void* raw_data, int data_len)
{
	m_value_type = VT_RAWDATA;
	if (m_bestBuffer != NULL)
	{
		DefaultMessagePool::ReleaseBestBuffer(m_bestBuffer);
	}
	m_bestBuffer = DefaultMessagePool::AcquireBestBuffer(data_len);
	m_bestBuffer->len = data_len;
	memcpy(m_bestBuffer->buff, raw_data, data_len);
}

///获取字段的数据类型
FIELD_VALUE_TYPE DefaultBestField::GetValueType()
{ 
	return  m_value_type;
}

///从另一个对象复制到自身
int32 DefaultBestField::CopyFrom(const IBestField *other)
{
	DefaultBestField* defaultField = (DefaultBestField*)other;
	this->SetTag(defaultField->GetTag());
	switch (defaultField->GetValueType())
	{
	case VT_INT8:
		this->SetInt8(defaultField->GetInt8());
		break;
	case VT_INT16:
		this->SetInt16(defaultField->GetInt16());
		break;
	case VT_INT32:
		this->SetInt32(defaultField->GetInt32());
		break;
	case VT_INT64:
		this->SetInt64(defaultField->GetInt64());
		break;
	case VT_STRING:
		this->SetString(defaultField->GetString());
		break;
	case VT_RAWDATA:
		{
			int32 len = 0;
			void* buffer = defaultField->GetRawData(&len);
			this->SetBuffer(buffer, len);
		}
		break;
	default:
		break;
	}
	return 0;
}

///复制自身
IBestField* DefaultBestField::Clone()
{
	DefaultBestField* field = DefaultMessagePool::AcquireDefaultBestField();
	field->CopyFrom(this);
	return field;
}

///减少引用计数，当为0时释放自身
uint64  DefaultBestField::Release(){
	if (m_ref > 0)
	{
		if (--m_ref == 0)
		{
			Reset();
			DefaultMessagePool::ReleaseDefaultBestField(this);
		}
	}
	return 0;
}

const PROTOCAL_TYPE DefaultBestField::GetProtocal()
{
	return m_protocol_type;
}

int32 DefaultBestField::SetProtocal(PROTOCAL_TYPE protpcal)
{
	m_protocol_type = protpcal;
	return 0;
}
uint32  DefaultBestField::GetTag()
{
	return m_tag;
}

int32  DefaultBestField::SetTag(uint32 tag)
{
	m_tag = tag;
	return 0;
}