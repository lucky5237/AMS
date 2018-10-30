#include "default_best_message.h"
#include "default_message_pool.h"
#include "default_serializer.h"
#include "default_best_rpchead.h"
#include "default_head_message.h"
///获取RPC头
IBestRPCHead* DefaultBestMessge::GetRpcHead()
{
	return m_rpc_head;
}
///设置RPC头
int32 DefaultBestMessge::SetRpcHead(IBestRPCHead* rpc_head)
{
	m_rpc_head = rpc_head;
	if (m_rpc_head != NULL)
	{
		((DefaultBestRPCHead*)m_rpc_head)->SetSubHeadNum(m_list_head_message.size());
	}
	return 0;
}
/*****************************操作Head协议层*******************************/
///添加头消息
int32  DefaultBestMessge::AddHeadMessage(IBestHeadMessage* head_message)
{
	m_list_head_message.push_back(head_message);
	if (m_rpc_head != NULL)
	{
		((DefaultBestRPCHead*)m_rpc_head)->SetSubHeadNum(m_list_head_message.size());
	}
	return 0;
}
IBestHeadMessage*  DefaultBestMessge::AddHeadMessage()
{
	IBestHeadMessage* head_message = (IBestHeadMessage*)DefaultMessagePool::AcquireDefaultBestHeadMessage();
	m_list_head_message.push_back(head_message);
	if (m_rpc_head != NULL)
	{
		((DefaultBestRPCHead*)m_rpc_head)->SetSubHeadNum(m_list_head_message.size());
	}
	return head_message;
}

BestIterator* DefaultBestMessge::GetIterator()
{
	return &m_best_iterator;
}
///从另一个消息复制到自身
int32 DefaultBestMessge::CopyFrom(const IBestMessge *best_message)
{
	//空消息才能复制
	DefaultBestMessge* defaultMessage = (DefaultBestMessge*)best_message;
	DefaultBestRPCHead * rpc = (DefaultBestRPCHead *)defaultMessage->GetRpcHead();
	if (this->GetRpcHead() != NULL) return -1;
	BestIterator* self_iterator = GetIterator();//获取迭代器
	self_iterator->First();
	if (!self_iterator->IsDone()) return -1;
	DefaultBestRPCHead * self_rpc = DefaultMessagePool::AcquireDefaultBestRPCHead();
	self_rpc->CopyFrom(rpc);
	SetRpcHead(self_rpc);
	BestIterator* bestIterator = defaultMessage->GetIterator();//获取迭代器
	bestIterator->First();
	while (!bestIterator->IsDone())
	{
		DefaultBestHeadMessage* self_head_message = (DefaultBestHeadMessage*)this->AddHeadMessage();
		DefaultBestHeadMessage* head_message = (DefaultBestHeadMessage*)bestIterator->CurrentItem();
		self_head_message->CopyFrom(head_message);
		bestIterator->Next();
		
	}
	return 0;
}
///复制自身
IBestMessge* DefaultBestMessge::Clone()
{
	DefaultBestMessge*  default_message = DefaultMessagePool::AcquireDefaultBestMessge();
	default_message->CopyFrom(this);
	return default_message;
}

IBestBase* DefaultBestMessge::AddRef(){
	++m_ref;
	return this;
}

///减少引用计数，当为0时释放自身
uint64  DefaultBestMessge::Release()
{
	if (m_ref > 0)
	{
		if (--m_ref == 0)
		{
			std::list<IBestBase*>::iterator itor = m_list_head_message.begin();
			while (itor != m_list_head_message.end())
			{
				(*itor)->Release();
				itor = m_list_head_message.erase(itor);
			}
			if (m_best_buffer != NULL)
			{
				DefaultMessagePool::ReleaseBestBuffer(m_best_buffer);
			}
			if (m_rpc_head != NULL)
			{
				m_rpc_head->Release();
			}
			m_best_buffer = NULL;
			m_status = 0;
			DefaultMessagePool::ReleaseDefaultBestMessge(this);
		}
	}
	return 0;
}

void*  DefaultBestMessge::GetBuffer(int32* len)
{ 
	*len = m_best_buffer->len;
	return m_best_buffer->buff;
}

const void*  DefaultBestMessge::Serialize(int32* len)
{
	DefaultBestSerializer*  serializer = DefaultBestSerializer::GetInstance();
	BestBuffer* tmp_buffer = (BestBuffer*)serializer->SerializeMessage(*len, (IBestMessage*)this);
	if (tmp_buffer == NULL)
	{
		*len = 0;
		return NULL;
	}
	if (m_best_buffer != NULL)
	{
		DefaultMessagePool::ReleaseBestBuffer(m_best_buffer);
	}
	m_best_buffer = tmp_buffer;
	*len = m_best_buffer->len;
	m_status = 1;
	return m_best_buffer->buff;
}

int32	DefaultBestMessge::SetBuffer(const void* buffer, const int32& len)
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

int32 DefaultBestMessge::Deserialize()
{ 
	DefaultBestSerializer*  serializer = DefaultBestSerializer::GetInstance();
	IBestMessage* message = (IBestMessage*)this;
	int32 ret = serializer->DeserializeMessage(message, m_best_buffer->buff, m_best_buffer->len);
	ReleaseBuffer();
	if (ret != 0)
	{
	return -1;
	}
	else
	{
	m_status = 1;
	return 0;
        }
}

//获取当前字段的协议
const PROTOCAL_TYPE DefaultBestMessge::GetProtocal()
{
	return BEST_MEASSAGE;
}

int32  DefaultBestMessge::SetProtocal(PROTOCAL_TYPE protpcal)
{
	m_protocol_type = protpcal;
	return 0;
}


///释放对于内存
int32 DefaultBestMessge::ReleaseBuffer(bool isReleaseData)
{
	std::list<IBestBase*>::iterator itor = m_list_head_message.begin();
	while (itor != m_list_head_message.end())
	{
		DefaultBestHeadMessage* headMessage = (DefaultBestHeadMessage*)(*itor);
		headMessage->ReleaseBuffer();
		if (isReleaseData)
		{
			DefaultBestDataMessage* dataMessage = (DefaultBestDataMessage*)headMessage->GetDataMessage();
			if(0 != dataMessage)
			{
				dataMessage->ReleaseBuffer();
			}
		}
		++itor;
	}
	if (m_best_buffer != NULL)
	{
		DefaultMessagePool::ReleaseBestBuffer(m_best_buffer);
		m_best_buffer = NULL;
	}
	return 0;

}

