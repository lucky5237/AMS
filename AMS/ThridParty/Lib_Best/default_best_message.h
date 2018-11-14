
#ifndef DEFAULT_BEST_MESSAGE_H
#define DEFAULT_BEST_MESSAGE_H
#include "default_bestIteror.h"
#include"best_message.h"
#include <list>
#include "atomic_count.h"
#include "default_message_pool.h"
using namespace best_protocol;
class DefaultBestMessge :public IBestMessge
{
	//friend class DefaultBestSerializer;
private:
	atomic_count m_ref;
	
public:
	DefaultBestMessge(){
		m_best_buffer = NULL;
		m_status = 0;
		m_rpc_head = NULL;
		m_protocol_type = BEST_MEASSAGE;
		m_best_iterator.Initail(&m_list_head_message);
	}
	virtual ~DefaultBestMessge(){};
	///获取RPC头
	virtual IBestRPCHead* GetRpcHead();
	///设置RPC头
	virtual int32 SetRpcHead(IBestRPCHead* rpc_head);
	/*****************************操作Head协议层*******************************/
	///添加头消息
	virtual int32  BEST_FUNCTION_CALL_MODE AddHeadMessage(IBestHeadMessage* head_message);
	virtual IBestHeadMessage*  BEST_FUNCTION_CALL_MODE AddHeadMessage();

	///获取字段迭代器
	virtual BestIterator* BEST_FUNCTION_CALL_MODE GetIterator();
	///从另一个消息复制到自身
	virtual int32 BEST_FUNCTION_CALL_MODE CopyFrom(const IBestMessge *best_message);
	///复制自身
	virtual IBestMessge* BEST_FUNCTION_CALL_MODE Clone();

	//获取当前字段的协议
	virtual const PROTOCAL_TYPE BEST_FUNCTION_CALL_MODE GetProtocal();
	//设置协议
	virtual int32 BEST_FUNCTION_CALL_MODE SetProtocal(PROTOCAL_TYPE protpcal);

public:
	/************************IBestBase接口*************************/
	///增加引用计数，返回自身
	virtual IBestBase*  BEST_FUNCTION_CALL_MODE AddRef();
	uint64 BEST_FUNCTION_CALL_MODE Release();

	///返回BEST对象类型
	virtual BEST_OBJECT_TYPE  BEST_FUNCTION_CALL_MODE GetBestType(){ return OBJ_NONE; }

	///设置所属对象
	virtual int32 BEST_FUNCTION_CALL_MODE SetOwner(IBestBase* best_base){ return 0; }

	///获取所属对象
	virtual IBestBase* BEST_FUNCTION_CALL_MODE GetOwner(){ return 0; }

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
	virtual int32  BEST_FUNCTION_CALL_MODE Status(){ return m_status; }
	///设置序列化器
	virtual int32   BEST_FUNCTION_CALL_MODE SetBestSerializer(IBestSerializer* serializer){ return 0; }
	///获取序列化器
	virtual IBestSerializer* BEST_FUNCTION_CALL_MODE GetBestSerializer(){ return 0; }
	///释放对于内存
	virtual int32 ReleaseBuffer(bool isReleaseData = false);
private:
	IBestRPCHead* m_rpc_head;
	BestBuffer* m_best_buffer;
	PROTOCAL_TYPE m_protocol_type;
	std::list<IBestBase*> m_list_head_message;
	DefaultBestListIterator m_best_iterator;
	int32 m_status;
};

#endif