#define WIN32_LEAN_AND_MEAN
#include "default_message_pool.h"
#include "default_best_message.h"
#include "default_best_rpchead.h"
#include "default_head_message.h"
#include "default_best_data_message.h"
#include "default_best_group.h"
#include "default_best_record.h"
#include "default_best_field.h"
#include "memory_pool.h"
#include "object_pool_ts.h"
#if (defined _WIN32)||(defined _WIN64)
#pragma warning(disable: 34)
#endif
#define B512_SIZE 512
#define B512_COUNT 10000
#define K1_SIZE	1024
#define K1_COUNT 2000
#define K4_SIZE 4096  
#define K4_COUNT 500
#define K64_SIZE 65536
#define K64_COUNT 125
#define K256_SIZE 262144
#define K256_COUNT 31
static MemoryPool g_memory_512;
static MemoryPool g_memory_1k;
static MemoryPool g_memory_4k;
static MemoryPool g_memory_64k;
static MemoryPool g_memory_256k;
static TS_Object_Pool<DefaultBestMessge> m_default_best_message_pool;
static TS_Object_Pool<DefaultBestHeadMessage> m_default_best_head_message_pool;
static TS_Object_Pool<DefaultBestDataHeadMessage> m_default_best_data_head_message_pool;
static TS_Object_Pool<DefaultBestDataMessage> m_default_best_data_message_pool;
static TS_Object_Pool<DefaultBestRPCHead> m_default_best_rpchead_pool;
static TS_Object_Pool<DefaultBestGroup> m_default_best_group_pool;
static TS_Object_Pool<DefaultBestRecord> m_default_best_record_pool;
static TS_Object_Pool<DefaultBestField> m_default_best_field_pool;
static TS_Object_Pool<BestBuffer> m_best_buffer_pool;

//int DefaultMessagePool::countorBuffer = 0;
//int DefaultMessagePool::countorObject = 0;
BestBuffer* DefaultMessagePool::Acquire512BestBuffer(int len)
{
	BestBuffer* best_buffer = m_best_buffer_pool.acquire();
	best_buffer->bufferType = BUFFER_512;
	best_buffer->capacity = B512_SIZE;
	best_buffer->buff = (char*)g_memory_512.Alloc();
	best_buffer->pos = 0;
	best_buffer->len = len;
	return best_buffer;
}
void DefaultMessagePool::Release512BestBuffer(BestBuffer* best_buffer)
{
	g_memory_512.Free(best_buffer->buff);
	best_buffer->bufferType = BUFFER_NONE;
	m_best_buffer_pool.release(best_buffer);
}

BestBuffer* DefaultMessagePool::Acquire1KBestBuffer(int32 len)
{
	BestBuffer* best_buffer = m_best_buffer_pool.acquire();
	best_buffer->bufferType = BUFFER_1K;
	best_buffer->capacity = K1_SIZE;
	best_buffer->buff = (char*)g_memory_1k.Alloc();
	best_buffer->pos = 0;
	best_buffer->len = len;
	return best_buffer;
}

void DefaultMessagePool::Release1KBestBuffer(BestBuffer* best_buffer)
{
	g_memory_1k.Free(best_buffer->buff);
	best_buffer->bufferType = BUFFER_NONE;
	m_best_buffer_pool.release(best_buffer);
}

BestBuffer* DefaultMessagePool::Acquire4KBestBuffer(int32 len)
{
	BestBuffer* best_buffer = m_best_buffer_pool.acquire();
	best_buffer->bufferType = BUFFER_4K;
	best_buffer->capacity = K4_SIZE;
	best_buffer->buff = (char*)g_memory_4k.Alloc();
	best_buffer->pos = 0;
	best_buffer->len = len;
	return best_buffer;
}

void DefaultMessagePool::Release4KBestBuffer(BestBuffer* best_buffer)
{
	g_memory_4k.Free(best_buffer->buff);
	best_buffer->bufferType = BUFFER_NONE;
	m_best_buffer_pool.release(best_buffer);
}

BestBuffer* DefaultMessagePool::Acquire64KBestBuffer(int32 len)
{
	BestBuffer* best_buffer = m_best_buffer_pool.acquire();
	best_buffer->bufferType = BUFFER_64K;
	best_buffer->capacity = K64_SIZE;
	best_buffer->buff = (char*)g_memory_64k.Alloc();
	best_buffer->pos = 0;
	best_buffer->len = len;
	return best_buffer;
}

void DefaultMessagePool::Release64KBestBuffer(BestBuffer* best_buffer)
{
	g_memory_64k.Free(best_buffer->buff);
	best_buffer->bufferType = BUFFER_NONE;
	m_best_buffer_pool.release(best_buffer);
}

BestBuffer* DefaultMessagePool::Acquire256KBestBuffer(int32 len)
{
	BestBuffer* best_buffer = m_best_buffer_pool.acquire();
	best_buffer->bufferType = BUFFER_256K;
	best_buffer->capacity = K256_SIZE;
	best_buffer->buff = (char*)g_memory_256k.Alloc();
	best_buffer->pos = 0;
	best_buffer->len = len;
	return best_buffer;
}

void DefaultMessagePool::Release256KBestBuffer(BestBuffer* best_buffer)
{
	g_memory_256k.Free(best_buffer->buff);
	best_buffer->bufferType = BUFFER_NONE;
	m_best_buffer_pool.release(best_buffer);
}

BestBuffer* DefaultMessagePool::AcquireLargeBestBuffer(int len)
{
	BestBuffer* best_buffer = m_best_buffer_pool.acquire();
	best_buffer->bufferType = BUFFER_LARGE;
	best_buffer->buff = (char*)malloc(len);
	best_buffer->capacity = len;
	best_buffer->pos = 0;
	best_buffer->len = len;
	return best_buffer;
}

void DefaultMessagePool::ReleaseLargeBestBuffer(BestBuffer* best_buffer)
{
	free(best_buffer->buff);
	best_buffer->bufferType = BUFFER_NONE;
	m_best_buffer_pool.release(best_buffer);
}

BestBuffer*  DefaultMessagePool::AcquireBestBuffer(int buffer_len)
{
	//countorBuffer++;
	BestBuffer* best_buffer = NULL;
	if (buffer_len <= B512_SIZE)
	{
		best_buffer = Acquire512BestBuffer(buffer_len);
	}
	else if (buffer_len <= K1_SIZE)
	{
		best_buffer = Acquire1KBestBuffer(buffer_len);
	}
	else if (buffer_len <= K4_SIZE)
	{
		best_buffer = Acquire4KBestBuffer(buffer_len);
	}
	else if (buffer_len <= K64_SIZE)
	{
		best_buffer = Acquire64KBestBuffer(buffer_len);
	}
	else if (buffer_len <= K256_SIZE)
	{
		best_buffer = Acquire256KBestBuffer(buffer_len);
	}
	else
	{
		best_buffer = AcquireLargeBestBuffer(buffer_len);
	}
	return best_buffer;
}

void DefaultMessagePool::ReleaseBestBuffer(BestBuffer* best_buffer)
{
	//countorBuffer--;
	best_buffer->pos = 0;
	best_buffer->len = 0;
	best_buffer->capacity = 0;
	switch (best_buffer->bufferType)
	{
	case BUFFER_512:
		Release512BestBuffer(best_buffer);
		break;
	case BUFFER_1K:
		Release1KBestBuffer(best_buffer);
		break;
	case BUFFER_4K:
		Release4KBestBuffer(best_buffer);
		break;
	case BUFFER_64K:
		Release64KBestBuffer(best_buffer);
		break;
	case BUFFER_256K:
		Release256KBestBuffer(best_buffer);
		break;
	case BUFFER_LARGE:
		ReleaseLargeBestBuffer(best_buffer);
		break;
	default:
		break;
	}
}

int32 DefaultMessagePool::InitDefaultMessagePool()
{
	g_memory_512.Init(B512_SIZE, B512_COUNT);
	g_memory_1k.Init(K1_SIZE, K1_COUNT);
	g_memory_4k.Init(K4_SIZE, K4_COUNT);
	g_memory_64k.Init(K64_SIZE, K64_COUNT);
	g_memory_256k.Init(K256_SIZE, K256_COUNT);
	return 0;
}

DefaultBestMessge*  DefaultMessagePool::AcquireDefaultBestMessge()
{
	//countorObject++;
	//printf("countorObject:%d\n", countorObject);
	DefaultBestMessge* default_best_message = m_default_best_message_pool.acquire();
	default_best_message->AddRef();
	return default_best_message;
}

DefaultBestRPCHead* DefaultMessagePool::AcquireDefaultBestRPCHead()
{
	//countorObject++;
	//printf("countorObject:%d\n", countorObject);
	DefaultBestRPCHead* default_best_rpchead = m_default_best_rpchead_pool.acquire();
	default_best_rpchead->AddRef();
	return default_best_rpchead;
}


void  DefaultMessagePool::ReleaseDefaultBestMessge(DefaultBestMessge* default_best_message)
{
	/*countorObject--;
	printf("countorObject:%d\n", countorObject);*/
	m_default_best_message_pool.release(default_best_message);
}

void DefaultMessagePool::ReleaseDefaultBestRPCHead(DefaultBestRPCHead* default_best_rpchead)
{
	/*countorObject--;
	printf("countorObject:%d\n", countorObject);*/
	m_default_best_rpchead_pool.release(default_best_rpchead);
}


DefaultBestHeadMessage* DefaultMessagePool::AcquireDefaultBestHeadMessage()
{
	//countorObject++;
	//printf("countorObject:%d\n", countorObject);
	DefaultBestHeadMessage* default_head_message = m_default_best_head_message_pool.acquire();
	default_head_message->AddRef();
	return default_head_message;
}

void  DefaultMessagePool::ReleaseDefaultBestHeadMessage(DefaultBestHeadMessage* default_head_message)
{
	/*countorObject--;
	printf("countorObject:%d\n", countorObject);*/
	m_default_best_head_message_pool.release(default_head_message);
}

DefaultBestDataHeadMessage* DefaultMessagePool::AcquireDefaultBestDataHeadMessage()
{
	//countorObject++;
	//printf("countorObject:%d\n", countorObject);
	DefaultBestDataHeadMessage* default_head_message = m_default_best_data_head_message_pool.acquire();
	default_head_message->AddRef();
	return default_head_message;
}

void  DefaultMessagePool::ReleaseDefaultBestDataHeadMessage(DefaultBestDataHeadMessage* default_head_message)
{
	/*countorObject--;
	printf("countorObject:%d\n", countorObject);*/
	m_default_best_data_head_message_pool.release(default_head_message);
}

DefaultBestField* DefaultMessagePool::AcquireDefaultBestField()
{
	//countorObject++;
	//printf("countorObject:%d\n", countorObject);
	DefaultBestField* default_best_field = m_default_best_field_pool.acquire();
	default_best_field->AddRef();
	return default_best_field;
}

void  DefaultMessagePool::ReleaseDefaultBestField(DefaultBestField* default_head_field)
{
	/*countorObject--;
	printf("countorObject:%d\n", countorObject);*/
	m_default_best_field_pool.release(default_head_field);
}



DefaultBestDataMessage* DefaultMessagePool::AcquireDefaultBestDataMessage()
{
	//countorObject++;
	//printf("countorObject:%d\n", countorObject);
	DefaultBestDataMessage* default_best_data_message = m_default_best_data_message_pool.acquire();
	default_best_data_message->AddRef();
	return default_best_data_message;
}

void  DefaultMessagePool::ReleaseDefaultBestDataMessage(DefaultBestDataMessage* default_data_message)
{
	//countorObject--;
	//printf("countorObject:%d\n", countorObject);
	m_default_best_data_message_pool.release(default_data_message);
}

DefaultBestGroup* DefaultMessagePool::AcquireDefaultBestGroup()
{
	/*countorObject++;
	printf("countorObject:%d\n", countorObject);*/
	DefaultBestGroup* default_best_group = m_default_best_group_pool.acquire();
	default_best_group->AddRef();
	return default_best_group;
}

void  DefaultMessagePool::ReleaseDefaultBestGroup(DefaultBestGroup* default_best_group)
{
	/*countorObject--;
	printf("countorObject:%d\n", countorObject);*/
	m_default_best_group_pool.release(default_best_group);
}

DefaultBestRecord* DefaultMessagePool::AcquireDefaultBestRecord()
{
	/*countorObject++;
	printf("countorObject:%d\n", countorObject);*/
	DefaultBestRecord* default_best_record = m_default_best_record_pool.acquire();
	default_best_record->AddRef();
	return default_best_record;
}

void  DefaultMessagePool::ReleaseDefaultBestRecord(DefaultBestRecord* default_best_record)
{
	/*countorObject--;
	printf("countorObject:%d\n", countorObject);*/
	m_default_best_record_pool.release(default_best_record);
}

