#ifndef DEFAULT_BEST_RPCHEAD_H
#define DEFAULT_BEST_RPCHEAD_H
#include"best_message.h"
#include <list>
#include "atomic_count.h"
#include "default_serializer.h"
#include <string.h>
#define PROT_TAG 1414743362
#define PROT_VERSION 925
#pragma pack(1)
typedef struct BestRpcStruct_t
{
	BestRpcStruct_t()
	{
		memset(this, 0, sizeof(BestRpcStruct_t));
		prot_tag = PROT_TAG;
		prot_version = PROT_VERSION;
	}
	int32 prot_tag;///协议标识符
	int32 prot_version;///协议版本号
	uint32 total_lenght;///协议总长度
	uint8 status_code;///状态码
	uint8 type;///包类型
	uint8 subnum;///子包数
	uint8 reserve;///保留位
	uint64 seq_num;///序号
	uint64 session_num;///会话号
	uint32 fun_no;//功能号
	uint32 crc_reserver;///crc保留位
}BestRpcStruct;

#pragma pack()
class DefaultBestRPCHead :public IBestRPCHead
{
private:
	atomic_count m_ref;
	PROTOCAL_TYPE m_protocol_type;
	int32 status;
public:
	DefaultBestRPCHead()
	{
		status = 0;
	}
	virtual ~DefaultBestRPCHead(){}
	BestRpcStruct m_best_rpc_struct;
	///获取协议标识符
	virtual int32 BEST_FUNCTION_CALL_MODE GetBestProtTag();
	///获取协议标识符
	virtual void  BEST_FUNCTION_CALL_MODE SetBestProtTag(const int32& prot_tag);
	///获取协议版本
	virtual int32 BEST_FUNCTION_CALL_MODE GetBestProtVersion();
	///设置协议版本
	virtual void  BEST_FUNCTION_CALL_MODE SetBestProtVersion(const int32& prot_version);
	///获取协议总长度
	virtual uint32 BEST_FUNCTION_CALL_MODE GetTotalLenght();

	virtual void BEST_FUNCTION_CALL_MODE SetTotalLenght(int32 len);
	///获取状态码
	virtual uint8  BEST_FUNCTION_CALL_MODE GetStatus();
	///设置状态码
	virtual void BEST_FUNCTION_CALL_MODE SetStatus(const uint8& status);
	//获取包类型
	virtual PACKET_TYPE BEST_FUNCTION_CALL_MODE GetPackType();
	//设置包类型
	virtual void BEST_FUNCTION_CALL_MODE SetPackType(const PACKET_TYPE& pack_type);
	///获取子包个数 
	virtual uint8 BEST_FUNCTION_CALL_MODE GetSubHeadNum();
	///设置子包数 
	virtual void BEST_FUNCTION_CALL_MODE SetSubHeadNum(uint8 sub_num);
	///获取序列号
	virtual uint64 BEST_FUNCTION_CALL_MODE GetSeqNum();
	///设置序列号
	virtual void  BEST_FUNCTION_CALL_MODE SetSeqNum(const uint64& seq_num);
	///获取会话
	virtual uint64 BEST_FUNCTION_CALL_MODE GetSessionNum();
	///设置会话
	virtual void  BEST_FUNCTION_CALL_MODE SetSessionNum(const uint64& session_num);
	///获取功能号
	virtual uint32 BEST_FUNCTION_CALL_MODE GetFuncNo();
	///设置功能号
	virtual void  BEST_FUNCTION_CALL_MODE SetFuncNo(const uint32& fuc_no);
	///获取校验位
	virtual uint32 BEST_FUNCTION_CALL_MODE GetCRCCheck();
	///设置校验位
	virtual void  BEST_FUNCTION_CALL_MODE SetCRCCheck(const uint32& crc);
	//获取当前字段的协议
	virtual const PROTOCAL_TYPE BEST_FUNCTION_CALL_MODE GetProtocal();
	//设置协议类型
	virtual int32 BEST_FUNCTION_CALL_MODE SetProtocal(PROTOCAL_TYPE protpcal);
public:
	/************************IBestBase接口*************************/
	///增加引用计数，返回自身
	virtual IBestBase*  BEST_FUNCTION_CALL_MODE AddRef();

	///减少引用计数，当为0时释放自身
	virtual uint64  BEST_FUNCTION_CALL_MODE Release();

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
	virtual int32  BEST_FUNCTION_CALL_MODE Status(){ return status; }
	///设置序列化器
	virtual int32   BEST_FUNCTION_CALL_MODE SetBestSerializer(IBestSerializer* serializer){ return 0; }
	///获取序列化器
	virtual IBestSerializer* BEST_FUNCTION_CALL_MODE GetBestSerializer(){ return 0; }
	///从另一个对象复制到自身
	virtual int32 BEST_FUNCTION_CALL_MODE CopyFrom(const IBestRPCHead *other);
	///复制自身
	virtual DefaultBestRPCHead* BEST_FUNCTION_CALL_MODE Clone();
private:
	void Reset();

};
#endif