#include "step_serializer.h"
#include "best_message.h"
#include <sstream>
#include <map>
#include <stdio.h>
#include "default_message_pool.h"
#include "default_best_message.h"
#include "default_best_field.h"
#include<string.h>
#include <stdlib.h>
using namespace best_protocol;

void StepSerializer::SetFieldValue(IBestField* bestField, int value_type, const char* buff)
{
	switch (value_type)
	{
		case VT_INT8:
		{
			uint8 value = atoi(buff);
			bestField->SetInt8(value);
		}
		break;
		case VT_INT16:
		{
			uint16 value = atoi(buff);
			bestField->SetInt16(value);
		}
		break;
		case VT_INT32:
		{
			uint32 value = atoi(buff);
			bestField->SetInt32(value);
		}
		break;
		case VT_INT64:
		{
			std::stringstream ssValue;
			int64 i64;
			ssValue << buff;
			ssValue >> i64;
			bestField->SetInt64(i64);
		}
		break;
		case VT_STRING:
		{
			bestField->SetString(buff);
		}
		break;
		case VT_RAWDATA:
		{
			 int32 len = *((int32*)buff);
			 bestField->SetRawData((buff + sizeof(int32)), len);
		}
			break;
		default:
			break;
	}
}

int StepSerializer::SplitValue(std::map<int, IBestField*>& hmf_Map, char* buff,int buff_len)
{
	int nPos = 0;
	//int start = 0;
	while (true)
	{
		if ((*(buff + nPos)) == '=')
		{
			char type[3];
			memcpy(type, buff, 2);
			type[2] = 0;
			int key = atoi(buff + 2);
			(*(buff + nPos)) = 0;
			IBestField* bestField;
			std::map<int, IBestField*>::iterator itor = hmf_Map.find(key);
			if (itor != hmf_Map.end())
			{
				bestField = itor->second;
			}
			else
			{
				bestField = (IBestField*)DefaultMessagePool::AcquireDefaultBestField();
				hmf_Map[key] = bestField;
				((DefaultBestField*)bestField)->SetTag(key);
			}
			DefaultBestField* default_field = (DefaultBestField*)bestField;
			default_field->SetProtocal(BEST_HEAD_STAMP);
			int value_type = atoi(type);
			if (value_type != VT_RAWDATA)
			{
				buff[buff_len] = 0;
				SetFieldValue(bestField, value_type, buff + nPos + 1);
				return 0;
			}
			else
			{
				int32 len = *((int32*)(buff + nPos + 1));
				int tmplen = len + sizeof(int32)+nPos + 1;
				SetFieldValue(bestField, value_type, buff + nPos + 1);
				return tmplen - buff_len;
			}
			break;
		}
		nPos++;
		}
	}

BestBuffer* StepSerializer::GetRawDataBestFieldValue(IBestField* field)
{
	int tmpLen = 0;
	void* tmpBuff = field->GetRawData(&tmpLen);
	BestBuffer* best_buffer = DefaultMessagePool::AcquireBestBuffer(tmpLen + sizeof(int32));
	int32 pos = 0;
	memcpy(pos + best_buffer->buff, &tmpLen, sizeof(int32));
	pos += sizeof(int32);
	memcpy(pos + best_buffer->buff, tmpBuff, tmpLen);
	return best_buffer;
}

void StepSerializer::GetBestFieldValue(IBestField* field, std::string& fieldString)
{
	switch (field->GetValueType())
	{
		case VT_INT8:
		{
			int32 value = field->GetInt8();
			std::stringstream stream;
			stream << value;
			stream >> fieldString;
		}
			break;
		case VT_INT16:
		{
			int32 value = field->GetInt16();
			std::stringstream stream;
			stream << value;
			stream >> fieldString;
		}
			break;
		case VT_INT32:
		{
			int32 value = field->GetInt32();
			std::stringstream stream;
			stream << value;
			stream >> fieldString;
		}
			break;
		case VT_INT64:
		{
			int64 value = field->GetInt64();
			std::stringstream stream;
			stream << value;
			stream >> fieldString;
		}
			break;
		case VT_STRING:
		{
			 fieldString = field->GetString();
		}
			break;
		default:
			break;
	}
}

void StepSerializer::DeSerialzeStep(const char* buff,const int buff_len, std::map<int, IBestField*>& hmf_Map)
{
	if (buff_len == 0)return;
	int nPos = 0;
	int start = 0;
	BestBuffer*  best_buffer = DefaultMessagePool::AcquireBestBuffer(buff_len);
	memcpy(best_buffer->buff, buff, buff_len);
	while (true)
	{
		if ((*(buff + nPos)) == STEP_FIELD_DELIM)
		{
			int tempos = SplitValue(hmf_Map, (best_buffer->buff + start), nPos - start);
			nPos += tempos;
			start = nPos + 1;
		}
		nPos++;
		if (nPos == buff_len)
		{
			SplitValue(hmf_Map, (best_buffer->buff + start), nPos - start);
			break;
		}
		else if (nPos > buff_len)
		{
			break;
		}
	}
	DefaultMessagePool::ReleaseBestBuffer(best_buffer);
}

#define ENLARGE_BUFFER 1024
int32 StepSerializer::SerialzeStep(BestBuffer* best_buffer, std::map<int, IBestField*>& hmf_Map)
{
	char* buff = best_buffer->buff + best_buffer->pos;
	std::map<int, IBestField*>::iterator itr;
	int pos = 0;
	for (itr = hmf_Map.begin(); itr != hmf_Map.end(); itr++)
	{
		bool isDelim = false;
		int tmpLen = best_buffer->pos + 1;
		if (itr != hmf_Map.begin())
		{
			if (tmpLen > best_buffer->len)
			{
				best_buffer->len = tmpLen + ENLARGE_BUFFER  ;
				best_buffer->buff = (char*)realloc(best_buffer->buff, best_buffer->len);
				buff = best_buffer->buff + best_buffer->pos;
			}
			buff[pos] = STEP_FIELD_DELIM;
			isDelim = true;
			pos += 1;
		}
		char keyStr[40] = { 0 };
		sprintf(keyStr, "%02d%d", itr->second->GetValueType(),itr->first);
		int keyStrLen = strlen(keyStr);
		tmpLen = best_buffer->pos + pos + keyStrLen + 1;
		if (tmpLen > best_buffer->len)
		{
			best_buffer->len = tmpLen + ENLARGE_BUFFER;
			best_buffer->buff = (char*)realloc(best_buffer->buff, best_buffer->len);
			buff = best_buffer->buff + best_buffer->pos;
		}
		if (isDelim)
		{
			buff[pos - 1] = STEP_FIELD_DELIM;
		}
		memcpy(buff + pos, keyStr, keyStrLen);
		pos += keyStrLen;
		buff[pos] = '=';
		pos += 1;
		if (itr->second->GetValueType() != VT_RAWDATA)
		{
			std::string field_value;
			GetBestFieldValue(itr->second, field_value);
		    tmpLen = best_buffer->pos + pos + field_value.size() + 1;
			if (tmpLen > best_buffer->len)
			{
				best_buffer->len = tmpLen + ENLARGE_BUFFER;
				best_buffer->buff = (char*)realloc(best_buffer->buff, best_buffer->len);
				buff = best_buffer->buff + best_buffer->pos;	
			}
			memcpy(buff + pos, field_value.c_str(), field_value.size());
			pos += field_value.size();
		}
		else
		{
			BestBuffer*  buffTmp= GetRawDataBestFieldValue(itr->second);
			tmpLen = best_buffer->pos + pos + buffTmp->len + 1;
			if (tmpLen > best_buffer->len)
			{
				best_buffer->len = tmpLen + ENLARGE_BUFFER;
				best_buffer->buff = (char*)realloc(best_buffer->buff, best_buffer->len);
				buff = best_buffer->buff + best_buffer->pos;
			}
			memcpy(buff + pos, buffTmp->buff, buffTmp->len);
			pos += buffTmp->len;
		}	
	}

	best_buffer->capacity = best_buffer->len;
	best_buffer->len = pos + best_buffer->pos;
	return pos;
}


int32 StepSerializer::SerialzeFixStep(BestBuffer* best_buffer, std::map<int, IBestField*>& hmf_Map)
{
	char* buff = best_buffer->buff + best_buffer->pos;
	std::map<int, IBestField*>::iterator itr;
	int pos = 0;
	for (itr = hmf_Map.begin(); itr != hmf_Map.end(); itr++)
	{
		bool isDelim = false;
		int tmpLen = best_buffer->pos + 1;
		if (itr != hmf_Map.begin())
		{
			if (tmpLen > best_buffer->len)
			{
				return -1;
			}
			buff[pos] = STEP_FIELD_DELIM;
			isDelim = true;
			pos += 1;
		}
		char keyStr[40] = { 0 };
		sprintf(keyStr, "%02d%d", itr->second->GetValueType(), itr->first);
		int keyStrLen = strlen(keyStr);
		tmpLen = best_buffer->pos + pos + keyStrLen + 1;
		if (tmpLen > best_buffer->len)
		{
			return -1;
		}
		if (isDelim)
		{
			buff[pos - 1] = STEP_FIELD_DELIM;
		}
		memcpy(buff + pos, keyStr, keyStrLen);
		pos += keyStrLen;
		buff[pos] = '=';
		pos += 1;
		if (itr->second->GetValueType() != VT_RAWDATA)
		{
		std::string field_value;
		GetBestFieldValue(itr->second, field_value);
			tmpLen = best_buffer->pos + pos + field_value.size();
			if (tmpLen > best_buffer->len)
			{
				return -1;
			}
		memcpy(buff + pos, field_value.c_str(), field_value.size());
		pos += field_value.size();
	}
		else
		{
			BestBuffer*  buffTmp = GetRawDataBestFieldValue(itr->second);
			tmpLen = best_buffer->pos + pos + buffTmp->len;
			if (tmpLen > best_buffer->len)
			{
				return -1;
			}
			memcpy(buff + pos, buffTmp->buff, buffTmp->len);
			pos += buffTmp->len;
		}
	}
	best_buffer->len = pos + best_buffer->pos;
	return pos;
}