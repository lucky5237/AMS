#include "default_serializer.h"
#include "default_head_message.h"
#include "default_best_rpchead.h"
#include "default_best_message.h"
#include "best_message.h"
#include "step_serializer.h"
#include "default_message_pool.h"
static const uint32 crc32tab[] = {
	0x5005713cL, 0x270241aaL, 0xbe0b1010L, 0xc90c2086L,
	0x5768b525L, 0x206f85b3L, 0xb966d409L, 0xce61e49fL,
	0x5edef90eL, 0x29d9c998L, 0xb0d09822L, 0xc7d7a8b4L,
	0x59b33d17L, 0x2eb40d81L, 0xb7bd5c3bL, 0xc0ba6cadL,
	0xedb88320L, 0x9abfb3b6L, 0x03b6e20cL, 0x74b1d29aL,
	0xead54739L, 0x9dd277afL, 0x04db2615L, 0x73dc1683L,
	0xe3630b12L, 0x94643b84L, 0x0d6d6a3eL, 0x7a6a5aa8L,
	0xe40ecf0bL, 0x9309ff9dL, 0x0a00ae27L, 0x7d079eb1L,
	0xf00f9344L, 0x8708a3d2L, 0x1e01f268L, 0x6906c2feL,
	0xf762575dL, 0x806567cbL, 0x196c3671L, 0x6e6b06e7L,
	0xfed41b76L, 0x89d32be0L, 0x10da7a5aL, 0x67dd4accL,
	0xf9b9df6fL, 0x8ebeeff9L, 0x17b7be43L, 0x60b08ed5L,
	0xd6d6a3e8L, 0xa1d1937eL, 0x38d8c2c4L, 0x4fdff252L,
	0xd1bb67f1L, 0xa6bc5767L, 0x3fb506ddL, 0x48b2364bL,
	0xd80d2bdaL, 0xaf0a1b4cL, 0x36034af6L, 0x41047a60L,
	0xdf60efc3L, 0xa867df55L, 0x316e8eefL, 0x4669be79L,
	0xcb61b38cL, 0xbc66831aL, 0x256fd2a0L, 0x5268e236L,
	0xcc0c7795L, 0xbb0b4703L, 0x220216b9L, 0x5505262fL,
	0xc5ba3bbeL, 0xb2bd0b28L, 0x2bb45a92L, 0x5cb36a04L,
	0xc2d7ffa7L, 0xb5d0cf31L, 0x2cd99e8bL, 0x5bdeae1dL,
	0x9b64c2b0L, 0xec63f226L, 0x756aa39cL, 0x026d930aL,
	0x9c0906a9L, 0xeb0e363fL, 0x72076785L, 0x05005713L,
	0x95bf4a82L, 0xe2b87a14L, 0x7bb12baeL, 0x0cb61b38L,
	0x92d28e9bL, 0xe5d5be0dL, 0x7cdcefb7L, 0x0bdbdf21L,
	0x86d3d2d4L, 0xf1d4e242L, 0x68ddb3f8L, 0x1fda836eL,
	0x81be16cdL, 0xf6b9265bL, 0x6fb077e1L, 0x18b74777L,
	0x88085ae6L, 0xff0f6a70L, 0x66063bcaL, 0x11010b5cL,
	0x8f659effL, 0xf862ae69L, 0x616bffd3L, 0x166ccf45L,
	0xa00ae278L, 0xd70dd2eeL, 0x4e048354L, 0x3903b3c2L,
	0xa7672661L, 0xd06016f7L, 0x4969474dL, 0x3e6e77dbL,
	0xaed16a4aL, 0xd9d65adcL, 0x40df0b66L, 0x37d83bf0L,
	0xa9bcae53L, 0xdebb9ec5L, 0x47b2cf7fL, 0x30b5ffe9L,
	0xbdbdf21cL, 0xcabac28aL, 0x53b39330L, 0x24b4a3a6L,
	0xbad03605L, 0xcdd70693L, 0x54de5729L, 0x23d967bfL,
	0xb3667a2eL, 0xc4614ab8L, 0x5d681b02L, 0x2a6f2b94L,
	0xb40bbe37L, 0xc30c8ea1L, 0x5a05df1bL, 0x2d02ef8dL,
	0x00000000L, 0x77073096L, 0xee0e612cL, 0x990951baL,
	0x076dc419L, 0x706af48fL, 0xe963a535L, 0x9e6495a3L,
	0x0edb8832L, 0x79dcb8a4L, 0xe0d5e91eL, 0x97d2d988L,
	0x09b64c2bL, 0x7eb17cbdL, 0xe7b82d07L, 0x90bf1d91L,
	0x1db71064L, 0x6ab020f2L, 0xf3b97148L, 0x84be41deL,
	0x1adad47dL, 0x6ddde4ebL, 0xf4d4b551L, 0x83d385c7L,
	0x136c9856L, 0x646ba8c0L, 0xfd62f97aL, 0x8a65c9ecL,
	0x14015c4fL, 0x63066cd9L, 0xfa0f3d63L, 0x8d080df5L,
	0x3b6e20c8L, 0x4c69105eL, 0xd56041e4L, 0xa2677172L,
	0x3c03e4d1L, 0x4b04d447L, 0xd20d85fdL, 0xa50ab56bL,
	0x35b5a8faL, 0x42b2986cL, 0xdbbbc9d6L, 0xacbcf940L,
	0x32d86ce3L, 0x45df5c75L, 0xdcd60dcfL, 0xabd13d59L,
	0x26d930acL, 0x51de003aL, 0xc8d75180L, 0xbfd06116L,
	0x21b4f4b5L, 0x56b3c423L, 0xcfba9599L, 0xb8bda50fL,
	0x2802b89eL, 0x5f058808L, 0xc60cd9b2L, 0xb10be924L,
	0x2f6f7c87L, 0x58684c11L, 0xc1611dabL, 0xb6662d3dL,
	0x76dc4190L, 0x01db7106L, 0x98d220bcL, 0xefd5102aL,
	0x71b18589L, 0x06b6b51fL, 0x9fbfe4a5L, 0xe8b8d433L,
	0x7807c9a2L, 0x0f00f934L, 0x9609a88eL, 0xe10e9818L,
	0x7f6a0dbbL, 0x086d3d2dL, 0x91646c97L, 0xe6635c01L,
	0x6b6b51f4L, 0x1c6c6162L, 0x856530d8L, 0xf262004eL,
	0x6c0695edL, 0x1b01a57bL, 0x8208f4c1L, 0xf50fc457L,
	0x65b0d9c6L, 0x12b7e950L, 0x8bbeb8eaL, 0xfcb9887cL,
	0x62dd1ddfL, 0x15da2d49L, 0x8cd37cf3L, 0xfbd44c65L,
	0x4db26158L, 0x3ab551ceL, 0xa3bc0074L, 0xd4bb30e2L,
	0x4adfa541L, 0x3dd895d7L, 0xa4d1c46dL, 0xd3d6f4fbL,
	0x4369e96aL, 0x346ed9fcL, 0xad678846L, 0xda60b8d0L,
	0x44042d73L, 0x33031de5L, 0xaa0a4c5fL, 0xdd0d7cc9L
};

uint32 crc32(const unsigned char *buf, uint32 size)
{
	uint32 i, crc;
	crc = 0xFFFFFFFF;
	for (i = 0; i < size; i++)
		crc = crc32tab[(crc ^ buf[i]) & 0xff] ^ (crc >> 8);
	return crc ^ 0xFFFFFFFF;
}

DefaultBestSerializer* DefaultBestSerializer::m_pInstance = new DefaultBestSerializer();
const void*  DefaultBestSerializer::SerializeMessage(int32& len, IBestMessage* message)
{
	DefaultBestMessge* bestMessage = (DefaultBestMessge*)message;
	BestIterator* bestIterator = bestMessage->GetIterator();
	int32 buffer_len = 0;
	int subNum = 0;
	bestIterator->First();
	while (!bestIterator->IsDone())
	{
		DefaultBestHeadMessage* headMessage = (DefaultBestHeadMessage*)bestIterator->CurrentItem();
		//这里要判断是否已经序列化
		if (headMessage != NULL && headMessage->Status() == 0)
		{
			//这里要判断是否已经序列化
			IBestDataMessage* bestDataMessage = headMessage->GetDataMessage();
			if (bestDataMessage != NULL && bestDataMessage->Status() == 0
				&& bestDataMessage->GetDataHeadMessage())
			{
				int total_len = 0;
				int tmp_len = 0;
				bestDataMessage->Serialize(&tmp_len);
				DefaultBestDataHeadMessage* data_head_messge = (DefaultBestDataHeadMessage*)bestDataMessage->GetDataHeadMessage();
				data_head_messge->SetDataLength(tmp_len);
				total_len+= tmp_len;
				tmp_len = 0;
				bestDataMessage->SerializeHead(&tmp_len);
				total_len += data_head_messge->GetHeadLength();
				headMessage->SetDataLength(total_len);
			}
		}
		int tmp_len = 0;
		headMessage->Serialize(&tmp_len);
		buffer_len += headMessage->GetHeadLength();
		buffer_len += headMessage->GetDataLength();
		bestIterator->Next();
		++subNum;
	}
	int32 rpc_length = 0;
	DefaultBestRPCHead* besthead = (DefaultBestRPCHead*)bestMessage->GetRpcHead();
	if (besthead != NULL)
	{
		besthead->SetSubHeadNum(subNum);
		void* rpc_buffer_head = besthead->GetBuffer(&rpc_length);
		buffer_len += rpc_length;
		besthead->SetTotalLenght(buffer_len);
		int32 crc_len = sizeof(besthead->m_best_rpc_struct) - sizeof(int32);
		uint32 crc_value = crc32((const unsigned char*)(&(besthead->m_best_rpc_struct)), crc_len);
		besthead->SetCRCCheck(crc_value);
		BestBuffer* buffer = DefaultMessagePool::AcquireBestBuffer(buffer_len);
		memcpy(buffer->buff + buffer->pos, rpc_buffer_head, rpc_length);
		buffer->pos += rpc_length;
		bestIterator->First();
		while (!bestIterator->IsDone())
		{
			int tmp_len = 0;
			const void* tmp_buffer = NULL;
			IBestHeadMessage* headMessage = (IBestHeadMessage*)bestIterator->CurrentItem();
			if (headMessage != NULL)
			{
				tmp_buffer = headMessage->GetBuffer(&tmp_len);
				memcpy(buffer->buff + buffer->pos, tmp_buffer, tmp_len);
				buffer->pos += tmp_len;
				///
				IBestDataMessage* bestDataMessage = headMessage->GetDataMessage();
				if (bestDataMessage != NULL)
				{
					DefaultBestDataHeadMessage* data_head_messge = (DefaultBestDataHeadMessage*)bestDataMessage->GetDataHeadMessage();
					if(0 != data_head_messge)
					{
						tmp_buffer = data_head_messge->GetBuffer(&tmp_len);
						if (tmp_len > 0)
						{
							memcpy(buffer->buff + buffer->pos, tmp_buffer, tmp_len);
							buffer->pos += tmp_len;
						}
					}
					tmp_buffer = bestDataMessage->GetBuffer(&tmp_len);
					if (tmp_len > 0)
					{
						memcpy(buffer->buff + buffer->pos, tmp_buffer, tmp_len);
						buffer->pos += tmp_len;
					}
				}
				///
				((DefaultBestHeadMessage*)headMessage)->ReleaseBuffer();//释放缓存内容
			}
			bestIterator->Next();
		}
		buffer->len = buffer->pos;
		buffer->pos = 0;
		return buffer;
	}
	else
	{
		len = 0;
		return NULL;
	}

}

const void* DefaultBestSerializer::SerializeRpcMessage(int32& len, IBestRPCHead* best_rpchead)
{
	//DefaultBestRPCHead* rpcHead = (DefaultBestRPCHead*)best_rpchead;
	//固定长度不需要序列化

	return 0;
};
const void*  DefaultBestSerializer::SerializeHeadMessage(int32& len, IBestHeadMessage* head_message)
{
	DefaultBestHeadMessage* default_head_message = (DefaultBestHeadMessage*)head_message;
	BestBuffer* best_buffer = DefaultMessagePool::AcquireBestBuffer(1024);
	memcpy(best_buffer->buff, &(default_head_message->m_best_head_struct), sizeof(BestHeadStruct));
	best_buffer->pos += sizeof(BestHeadStruct);
	len = StepSerializer::SerialzeFixStep(best_buffer, default_head_message->m_best_field_map);
	if(len != -1)
	{
		BestBuffer* tmp_buffer = DefaultMessagePool::AcquireBestBuffer(best_buffer->len);
		tmp_buffer->pos = best_buffer->pos;
		memcpy(tmp_buffer->buff, best_buffer->buff, best_buffer->len);
		DefaultMessagePool::ReleaseBestBuffer(best_buffer);
		return tmp_buffer;
	}
	else
	{
		DefaultMessagePool::ReleaseBestBuffer(best_buffer);
		best_buffer = DefaultMessagePool::AcquireLargeBestBuffer(2048);
		memcpy(best_buffer->buff, &(default_head_message->m_best_head_struct), sizeof(BestHeadStruct));
		best_buffer->pos += sizeof(BestHeadStruct);
		len = StepSerializer::SerialzeStep(best_buffer, default_head_message->m_best_field_map);
		return best_buffer;
	}
};

const void*  DefaultBestSerializer::SerializeDataHeadMessage(int32& len, IBestHeadMessage* head_message)
{
	DefaultBestDataHeadMessage* default_head_message = (DefaultBestDataHeadMessage*)head_message;
	BestBuffer* best_buffer = DefaultMessagePool::AcquireBestBuffer(1024);
	memcpy(best_buffer->buff, &(default_head_message->m_best_head_struct), sizeof(BestDataHeadStruct_t));
	best_buffer->pos += sizeof(BestDataHeadStruct_t);
	len = StepSerializer::SerialzeFixStep(best_buffer, default_head_message->m_best_field_map);
	if(len != -1)
	{
		BestBuffer* tmp_buffer = DefaultMessagePool::AcquireBestBuffer(best_buffer->len);
		tmp_buffer->pos = best_buffer->pos;
		memcpy(tmp_buffer->buff, best_buffer->buff, best_buffer->len);
		DefaultMessagePool::ReleaseBestBuffer(best_buffer);
		return tmp_buffer;
	}
	else
	{
		DefaultMessagePool::ReleaseBestBuffer(best_buffer);
		best_buffer = DefaultMessagePool::AcquireLargeBestBuffer(2048);
		memcpy(best_buffer->buff, &(default_head_message->m_best_head_struct), sizeof(BestDataHeadStruct_t));
		best_buffer->pos += sizeof(BestDataHeadStruct_t);
		len = StepSerializer::SerialzeStep(best_buffer, default_head_message->m_best_field_map);
		return best_buffer;
	}
}

const void*  DefaultBestSerializer::SerializeDataMessage(int32& len, IBestDataMessage* data_message)
{
	return 0;
};
const void* DefaultBestSerializer::SerializeGroup(int32& len, IBestGroup* best_group)
{
	return 0;
};
const void*  DefaultBestSerializer::SerializeRecord(int32& len, IBestRecord* best_record)
{
	return 0;
};
const void*  DefaultBestSerializer::SerializeField(int32& len, IBestField* best_field)
{
	return 0;
};

int DefaultBestSerializer::DeserializeMessage(IBestMessage* message, const void* buffer, const int32& len)
{
	int32 crc_len = sizeof(BestRpcStruct)-sizeof(int32);
	uint32 crc_value = crc32((const unsigned char*)(buffer), crc_len);
	BestRpcStruct* tmp_rpc = (BestRpcStruct*)buffer;
	BestHeadStruct* tmp_head = (BestHeadStruct*)((char*)buffer + sizeof(BestRpcStruct));
	if(tmp_rpc->total_lenght > MAX_BEST_BUFF_LEN)return -1;
	if (tmp_head->head_length > MAX_BEST_BUFF_LEN)return -1;
	if (tmp_head->content_length > MAX_BEST_BUFF_LEN)return -1;
	if (crc_value != tmp_rpc->crc_reserver)return -1;
	if (tmp_rpc->total_lenght != (uint32)len) return -1;
	DefaultBestMessge* default_message = (DefaultBestMessge*)message;
	DefaultBestRPCHead* rpcHead = DefaultMessagePool::AcquireDefaultBestRPCHead();
	char* tmpbuff = (char*)buffer;
	rpcHead->SetBuffer(tmpbuff, sizeof(BestRpcStruct));
	rpcHead->Deserialize();

	if (rpcHead->GetBestProtTag() != PROT_TAG || rpcHead->GetTotalLenght() != (uint32)len)
	{
		DefaultMessagePool::ReleaseDefaultBestRPCHead(rpcHead);
		return 0;
	}
	rpcHead->SetProtocal(BEST_RPC);
	int pos = sizeof(BestRpcStruct);
	for (int i = 0; i < rpcHead->GetSubHeadNum(); ++i)
	{
		DefaultBestHeadMessage* head_message = DefaultMessagePool::AcquireDefaultBestHeadMessage();
		BestHeadStruct* bestHeadStruct = (BestHeadStruct*)(tmpbuff + pos);
		head_message->SetBuffer(tmpbuff + pos, bestHeadStruct->head_length);
		head_message->Deserialize();
		//head_message->ReleaseBuffer();//释放多余内存
		pos += bestHeadStruct->head_length;
		if (bestHeadStruct->content_length > 0)
		{
			////
			DefaultBestDataMessage* data_message = DefaultMessagePool::AcquireDefaultBestDataMessage();
			/*const char* encoding = head_message->GetField(HEAD_CONTENENCODING)->GetString();
			if (strcmp(encoding, "RAW") == 0)
			{
				data_message->SetProtocal(BEST_DATA_RAW);
			}*/
			DefaultBestDataHeadMessage* data_head_message = (DefaultBestDataHeadMessage*)data_message->GetDataHeadMessage();
			BestDataHeadStruct_t* bestDataHeadStruct = (BestDataHeadStruct_t*)(tmpbuff + pos);
			data_head_message->SetBuffer(tmpbuff + pos, bestDataHeadStruct->head_length);
			data_head_message->Deserialize();
			pos += bestDataHeadStruct->head_length;
			///
			data_message->SetBuffer(tmpbuff + pos, bestDataHeadStruct->content_length);
			data_message->Deserialize();
			head_message->SetDataMessage(data_message);
			pos += bestDataHeadStruct->content_length;
		}
		default_message->AddHeadMessage(head_message);
	}
	default_message->SetRpcHead(rpcHead);
	return 0;
}
int DefaultBestSerializer::DeserializeRpcMessage(IBestRPCHead* best_rpchead, const void* buffer, const int32& len)
{
	return 0;
}

int DefaultBestSerializer::DeserializeDataHeadMessage(IBestHeadMessage* head_message, const void* buffer, const int32& len)
{
	DefaultBestDataHeadMessage* default_head_message = (DefaultBestDataHeadMessage*)head_message;
	int buff_len = len - sizeof(BestDataHeadStruct_t);
	char* buff = (char*)buffer + sizeof(BestDataHeadStruct_t);
	//BestHeadStruct* best_head_struct = (BestHeadStruct*)buffer;
	this->SetProtocal(BEST_HEAD_STAMP);
	StepSerializer::DeSerialzeStep(buff, buff_len, default_head_message->m_best_field_map);
	return 0;
}

int DefaultBestSerializer::DeserializeHeadMessage(IBestHeadMessage* head_message, const void* buffer, const int32& len)
{
	DefaultBestHeadMessage* default_head_message = (DefaultBestHeadMessage*)head_message;
	int buff_len = len - sizeof(BestHeadStruct);
	char* buff = (char*)buffer + sizeof(BestHeadStruct);
	//BestHeadStruct* best_head_struct = (BestHeadStruct*)buffer;
	this->SetProtocal(BEST_HEAD_STAMP);
	StepSerializer::DeSerialzeStep(buff, buff_len, default_head_message->m_best_field_map);
	return 0;
}
int DefaultBestSerializer::DeserializeDataMessage(IBestDataMessage* head_message, const void* buffer, const int32& len)
{
	return 0;
}

int DefaultBestSerializer::DeserializeGroup(IBestGroup* group, const void* buffer, const int32& len) { return 0; }
int DefaultBestSerializer::DeserializeRecord(IBestRecord* record, const void* buffer, const int32& len) { return 0; }
int DefaultBestSerializer::DeserializeField(IBestField* field, const void* buffer, const int32& len) { return 0; }

const PROTOCAL_TYPE DefaultBestSerializer::GetProtocal()
{
	return m_protocol_type;
}

int32 DefaultBestSerializer::SetProtocal(PROTOCAL_TYPE protpcal)
{
	m_protocol_type = protpcal;
	return 0;
}
