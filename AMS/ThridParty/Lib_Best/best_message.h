
#ifndef IBESTMESSAGE_H
#define IBESTMESSAGE_H
	#if (defined _WIN32)||(defined _WIN64)
		#if !defined( BEST_FUNCTION_CALL_MODE )
			#define BEST_FUNCTION_CALL_MODE		__stdcall
		#endif
		#else
			#define BEST_FUNCTION_CALL_MODE
		#endif
	#if (defined _WIN32)||(defined _WIN64)
		typedef char				int8;
		typedef short				int16;
		typedef int					int32;
		typedef __int64				int64;
		typedef unsigned char		uint8;
		typedef unsigned short		uint16;
		typedef unsigned int		uint32;
		typedef unsigned __int64	uint64;
	#else
		#include <sys/types.h>
//        #if defined(__linux__)
			#include <stdint.h>
//        #endif
		typedef int8_t				int8;
		typedef int16_t				int16;
		typedef int32_t				int32;
		typedef int64_t				int64;
		typedef uint8_t				uint8;
		typedef uint16_t			uint16;
		typedef uint32_t			uint32;
		typedef uint64_t			uint64;
	#endif

#define RPC_EHADLENGTH	40
#define MAX_BEST_BUFF_LEN 4194304 //最大长度为40M
#define GET_PRC_TOTAL_LENGTH(buff) (*((int32*)((char*)(buff) + 8)))

namespace best_protocol
{
	///Prev desc.
	class IBestBase;
	class IBestMessage;
	class IBestRPCHead;
	class IBestHeadMessage;
	class IBestDataMessage;
	class IBestGroup;
	class IBestRecord;
	class IBestField;

    ///字段值类型
	enum FIELD_VALUE_TYPE {
		VT_NONE     = 0,   ///< unkown type
		VT_INT8     = 1,   ///< 8bytes integer  
		VT_INT16    = 2,   ///< 16bytes integer  
		VT_INT32    = 3,   ///< 32bytes integer  
		VT_INT64    = 4,   ///< 64bytes integer  
		VT_STRING   = 5,   ///< string 
		VT_RAWDATA  = 6    ///< binary
	};

	///BEST对象类型
	enum BEST_OBJECT_TYPE {
		OBJ_NONE               = 0,  ///< unkown best object
		OBJ_BEST_FIELD         = 1,  ///< 字段类型
		OBJ_BEST_RECORD        = 2,  ///< 记录类型
		OBJ_BEST_GROUP         = 3,  ///< 序列集
		OBJ_BEST_MESSAGE       = 4,  ///< Best消息
		OBJ_BEST_RPC_HEAD      = 5,  ///< Best协议一层RPC消息
		OBJ_BEST_HEAD_MESSAGE  = 6,  ///< Best协议二层头部消息
		OBJ_BEST_DATA_MESSAGE  = 7   ///< Best协议三层数据消息 
	};

	///数据包类型
	enum PACKET_TYPE {
		PACKTTYPE_NONE         = 0,  ///< unkown packet type
		PACKTTYPE_REQUEST      = 1,  ///< 请求
		PACKTTYPE_RESPONSE     = 2,  ///< 应答
		PACKTTYPE_PUSH         = 3,   ///< 主推
		PACKTTYPE_ROLLBACK     = 4,  ///回滚请求
		
	};

	enum PROTOCAL_TYPE 
	{
		BEST_PROTOCAL_NONE,
		BEST_MEASSAGE,
		BEST_RPC,
		BEST_HEAD_STAMP,
		BEST_DATA_RAW,
		BEST_DATA_JSON,
		BEST_DATA_XML
	};

	enum HEAD_MESSAGE_FIELD
	{
		HEAD_MSG_TYPE,
		HEAD_PACKTYPE,
		HEAD_HEADLENGTH,
		HEAD_CONTENTLENGTH,
		HEAD_CONTENENCODING,
		HEAD_SESSIONID,
		HEAD_BUSINESSID,
		HEAD_CATEGORYID,
		HEAD_MSGSEQNUM,
		HEAD_SENDIERD,
		HEAD_TARGETID,
		HEAD_SENDDINGTIME,
		HEAD_CHARSET,
		HEAD_BYTEORDER,
		HEAD_COMPRESSMETHOD,
		HEAD_ENCRYPTMETHOD,
		HEAD_CHECKSUM,
		HEAD_PRIORITY,
		HEAD_USRDATALENGTH,
		HEAD_USRDATA,
		HEAD_SYSTEM = 100
	};
	const uint8	RPC_HEAD_SUC = 0;
	const uint8 RPC_HEAD_FAIL = -1;
	const uint8 RPC_HEAD_TIME_OUT = -2;	// 超时

	enum ERROR_NO
	{
		GW_ERROR_UNKNOW = 1,						// 未知错误
		GW_ERROR_NO_SESSION_ID,						// 会话号不存在
		GW_ERROR_SESSION_INVALID,					// 会话号无效
		GW_ERROR_LOGIN_FAILED,						// 登陆失败
		GW_ERROR_NO_SUPPORT_FUNCTION_ID,			// 业务请求类型错误
		GW_ERROR_NEED_PERMISSION,					// 权限不足
		GW_ERROR_PARAM_ERROR,						// 参数错误
	};

	class BestIterator
	{
	public:
		///获取迭代器第一个节点
		virtual void BEST_FUNCTION_CALL_MODE First() = 0;
		///返回迭代器下一个结点
		virtual void BEST_FUNCTION_CALL_MODE Next() = 0;
		///判断是否还存在下一个结点f
		virtual bool BEST_FUNCTION_CALL_MODE IsDone() = 0;
		//删除迭代器当前节点
		virtual bool BEST_FUNCTION_CALL_MODE Erase() = 0;

		virtual IBestBase* CurrentItem() const = 0;
	};
	
	/**
	 @class IBestBase
	 @describe Best对象的统一父类
	*/
	class IBestBase
	{
	public:
		///增加引用计数，返回自身
		virtual IBestBase*  BEST_FUNCTION_CALL_MODE AddRef() = 0;

		///减少引用计数，当为0时释放自身
		virtual uint64  BEST_FUNCTION_CALL_MODE Release() = 0;

		///返回BEST对象类型
		virtual BEST_OBJECT_TYPE  BEST_FUNCTION_CALL_MODE GetBestType() = 0;

		///设置所属对象
		virtual int32 BEST_FUNCTION_CALL_MODE SetOwner(IBestBase* best_base) = 0;

		///获取所属对象
		virtual IBestBase* BEST_FUNCTION_CALL_MODE GetOwner() = 0;

		//获取当前字段的协议
		virtual const PROTOCAL_TYPE BEST_FUNCTION_CALL_MODE GetProtocal() = 0;
	};

	/**
	@class IBestSerializer
	@describe BEST序列化/反序列化器
	*/
	class IBestSerializer
	{
	public:
		/**
		 @method SerializeXXX
		 @note   序列化消息,重复组,记录,字段
		 @param 
		    len: [out] 返回序列化后的长度
		 @return
		    返回序列化后的buffer，其长度为传出参数$len的值，NULL表示序列化失败
			GetErrorNo()可返回错误号,GetErrorString()返回错误原因
		*/
		virtual const void*  BEST_FUNCTION_CALL_MODE SerializeMessage(int32& len, IBestMessage* message) = 0;
		virtual const void*  BEST_FUNCTION_CALL_MODE SerializeRpcMessage(int32& len, IBestRPCHead* bestRpchead) = 0;
		virtual const void*  BEST_FUNCTION_CALL_MODE SerializeHeadMessage(int32& len, IBestHeadMessage* headMessage) = 0;
		virtual const void*  BEST_FUNCTION_CALL_MODE SerializeDataHeadMessage(int32& len, IBestHeadMessage* head_message)=0;
		virtual const void*  BEST_FUNCTION_CALL_MODE SerializeDataMessage(int32& len, IBestDataMessage* headMessage) = 0;
		virtual const void*  BEST_FUNCTION_CALL_MODE SerializeGroup(int32& len,IBestGroup* bestGroup) = 0;
		virtual const void*  BEST_FUNCTION_CALL_MODE SerializeRecord(int32& len, IBestRecord* bestRecord) = 0;
		virtual const void*  BEST_FUNCTION_CALL_MODE SerializeField(int32& len, IBestField* bestField) = 0;
		//获取当前字段的协议
		virtual const PROTOCAL_TYPE BEST_FUNCTION_CALL_MODE GetProtocal() = 0;


		/**
		 @method DeserializeXXX
		 @note   反序列化消息,重复组,记录,字段
		 @param
		   第一个参数: 将buffer数据反序列化的目标对象
		   buffer: [IN] 二进制数据
		   len: [IN] buffer的长度
		@return
		   0:序列化成功，否则失败。
		   GetErrorNo()可返回错误号,GetErrorString()返回错误原因
		*/
		virtual int BEST_FUNCTION_CALL_MODE DeserializeMessage(IBestMessage* message, const void* buffer, const int32& len) = 0;
		virtual int BEST_FUNCTION_CALL_MODE DeserializeRpcMessage(IBestRPCHead* best_rpchead, const void* buffer, const int32& len) = 0;
		virtual int BEST_FUNCTION_CALL_MODE DeserializeHeadMessage(IBestHeadMessage* headMessage, const void* buffer, const int32& len) = 0;
		virtual int BEST_FUNCTION_CALL_MODE DeserializeDataHeadMessage(IBestHeadMessage* head_message, const void* buffer, const int32& len)=0;
		virtual int BEST_FUNCTION_CALL_MODE DeserializeDataMessage(IBestDataMessage* dataMessage, const void* buffer, const int32& len) = 0;
		virtual int BEST_FUNCTION_CALL_MODE DeserializeGroup(IBestGroup* group, const void* buffer, const int32& len)       = 0;
		virtual int BEST_FUNCTION_CALL_MODE DeserializeRecord(IBestRecord* record, const void* buffer, const int32& len)    = 0;
		virtual int BEST_FUNCTION_CALL_MODE DeserializeField(IBestField* field, const void* buffer, const int32& len)       = 0;

		///返回序列化器的ID
		virtual const char* BEST_FUNCTION_CALL_MODE GetProtocol() = 0;

		///获取错误号
		virtual int BEST_FUNCTION_CALL_MODE GetErrorNo() = 0;

		///获取错误原因
		virtual const char* BEST_FUNCTION_CALL_MODE GetErrorString(int err) = 0;
	};

	/**
	@class IBestStream
	@describe BEST流
	*/
	class IBestStream
	{
	public:
		///序列化对象
		virtual const void*  BEST_FUNCTION_CALL_MODE Serialize(int32* len) = 0;
		///反序列化
		virtual int32 BEST_FUNCTION_CALL_MODE Deserialize() = 0;//设置协议数据
		
		///设置流
		virtual int32	BEST_FUNCTION_CALL_MODE SetBuffer(const void* buffer, const int32& len) = 0;//设置协议数据
		///获取流
		virtual void*  BEST_FUNCTION_CALL_MODE GetBuffer(int32* len) = 0;//获取协议数据
		///返回流状态. 1:可用 0:不可用
		virtual int32  BEST_FUNCTION_CALL_MODE Status() = 0;
		///设置/获取序列化器
		virtual int32   BEST_FUNCTION_CALL_MODE SetBestSerializer(IBestSerializer* serializer) = 0;

		virtual IBestSerializer* BEST_FUNCTION_CALL_MODE GetBestSerializer() = 0;
	};
	
	/**
	@class IBestField
	@describe BEST字段
	*/
	class IBestField :public IBestBase, public IBestStream
	{
	public:
		virtual BEST_OBJECT_TYPE  BEST_FUNCTION_CALL_MODE GetBestType() { return OBJ_BEST_FIELD; }
		/*******************获取和设置对应的Filed值*****************/
		virtual uint8	BEST_FUNCTION_CALL_MODE GetInt8() const = 0;
		virtual void BEST_FUNCTION_CALL_MODE SetInt8(uint8 val) = 0;
		virtual uint16	BEST_FUNCTION_CALL_MODE GetInt16() const = 0;
		virtual void BEST_FUNCTION_CALL_MODE SetInt16(uint16 val) = 0;
		virtual uint32	BEST_FUNCTION_CALL_MODE GetInt32() const = 0;
		virtual void BEST_FUNCTION_CALL_MODE SetInt32(uint32 val) = 0;
		virtual uint64	BEST_FUNCTION_CALL_MODE GetInt64() const = 0;
		virtual void BEST_FUNCTION_CALL_MODE SetInt64(uint64 val) = 0;
		virtual const char* BEST_FUNCTION_CALL_MODE GetString() const = 0;
		virtual void BEST_FUNCTION_CALL_MODE SetString(const char* val) = 0;
		//virtual const void* BEST_FUNCTION_CALL_MODE GetRawData(int* data_len ) const = 0;
		virtual int32 BEST_FUNCTION_CALL_MODE GetRawDataLen() const  = 0;
		virtual void* BEST_FUNCTION_CALL_MODE GetRawData(int* data_len) = 0;
		virtual void BEST_FUNCTION_CALL_MODE SetRawData(const void* raw_data, int data_len) = 0;
		///获取字段的数据类型
		virtual FIELD_VALUE_TYPE BEST_FUNCTION_CALL_MODE GetValueType() = 0;
		///从另一个对象复制到自身
		virtual int32 BEST_FUNCTION_CALL_MODE CopyFrom(const IBestField *other) = 0;
		///复制自身
		virtual IBestField* BEST_FUNCTION_CALL_MODE Clone() = 0;
		///获取字段对应的tag
		virtual uint32 BEST_FUNCTION_CALL_MODE GetTag() = 0;
	};

	/**
	 @class IBestRecord
	 @describe BEST记录
	*/
	class IBestRecord : public IBestBase, public IBestStream
	{
	public:
		virtual BEST_OBJECT_TYPE  BEST_FUNCTION_CALL_MODE GetBestType() { return OBJ_BEST_RECORD; }
		///获取$tag的字段,NULL表示不存在
		virtual IBestField*  BEST_FUNCTION_CALL_MODE GetField(const int32& tag) = 0;

		///设置$tag的字段
		virtual void BEST_FUNCTION_CALL_MODE SetField(const int32& tag, IBestField* field) = 0;

		///判断$tag的字段是否存在
		virtual bool BEST_FUNCTION_CALL_MODE IsExistField(const int32& tag) = 0;
		
		///从另一个对象复制到自身
		virtual int32 BEST_FUNCTION_CALL_MODE CopyFrom(const IBestRecord *other) = 0;

		///复制自身
		virtual IBestRecord* BEST_FUNCTION_CALL_MODE Clone() = 0;

		///获取字段迭代器
		virtual BestIterator* BEST_FUNCTION_CALL_MODE GetIterator() = 0;

	};

	/**
	 @class IBestGroup
	 @describe BEST重复组
	*/
	class  IBestGroup : public IBestBase, public IBestStream
	{		
	public:
		virtual BEST_OBJECT_TYPE  BEST_FUNCTION_CALL_MODE GetBestType() { return OBJ_BEST_GROUP; }
		///新增一条记录,返回增加后的记录对象
		virtual IBestRecord * BEST_FUNCTION_CALL_MODE AddRecord() = 0;
		///新增一条已存在的记录
		virtual int BEST_FUNCTION_CALL_MODE AddRecord(IBestRecord * bestRecord) = 0;
		///获取记录迭代器
		virtual BestIterator* BEST_FUNCTION_CALL_MODE GetIterator() = 0;
		///从另一个对象复制到自身
		virtual int32 BEST_FUNCTION_CALL_MODE CopyFrom(const IBestGroup* other) = 0;
		///复制自身
		virtual IBestGroup* BEST_FUNCTION_CALL_MODE Clone() const = 0;
	};

	/**
	@class IBestDataMessage
	@describe BEST数据消息
	*/
	class IBestDataMessage : public IBestBase, public IBestStream
	{
	public:
		virtual BEST_OBJECT_TYPE  BEST_FUNCTION_CALL_MODE GetBestType() { return OBJ_BEST_DATA_MESSAGE; }
		///从另一个对象复制到自身
		virtual int32 BEST_FUNCTION_CALL_MODE CopyFrom(const IBestDataMessage *other) = 0;
		///复制自身
		virtual IBestDataMessage* BEST_FUNCTION_CALL_MODE Clone() = 0;

		virtual void BEST_FUNCTION_CALL_MODE SetGroup(const int32& flag, IBestGroup* group) = 0;

		virtual IBestGroup* BEST_FUNCTION_CALL_MODE GetGroup(const int32& flag) = 0;

		virtual bool BEST_FUNCTION_CALL_MODE IsExitGroup(const int32& flag) = 0; 

		///获取$tag的字段,NULL表示不存在
		virtual IBestField*  BEST_FUNCTION_CALL_MODE GetField(const int32& tag) = 0;

		///设置$tag的字段
		virtual void BEST_FUNCTION_CALL_MODE SetField(const int32& tag, IBestField* field) = 0;

		///判断$tag的字段是否存在
		virtual bool BEST_FUNCTION_CALL_MODE IsExistField(const int32& tag) = 0;

		///获取字段迭代器
		virtual BestIterator* BEST_FUNCTION_CALL_MODE GetIterator() = 0;

		virtual int32	BEST_FUNCTION_CALL_MODE SetHeadBuffer(const void* buffer, const int32& len) = 0;
		///获取头部流
		virtual void*  BEST_FUNCTION_CALL_MODE GetHeadBuffer(int32* len) = 0;
		///序列化头部对象
		virtual const void*  BEST_FUNCTION_CALL_MODE SerializeHead(int32* len) = 0;
		///反序列化头部
		virtual int32 BEST_FUNCTION_CALL_MODE DeserializeHead() = 0;
		///获取头部
		virtual IBestHeadMessage* BEST_FUNCTION_CALL_MODE GetDataHeadMessage() = 0;
		
	};

	/**
	@class IBestHeadMessage
	@describe BEST头部消息
	*/
	class IBestHeadMessage : public IBestBase, public IBestStream
	{
	public:
		virtual BEST_OBJECT_TYPE  BEST_FUNCTION_CALL_MODE GetBestType() { return OBJ_BEST_HEAD_MESSAGE; }

		///获取头部长度,0表示当前无法获取头部长度
		virtual int32 BEST_FUNCTION_CALL_MODE GetHeadLength() = 0;

		///获取数据长度,0表示当前无法获取数据长度
		virtual int32 BEST_FUNCTION_CALL_MODE GetDataLength() = 0;

		/******************************************设置数据层******************************************/
		///设置数据层消息
		virtual int32 BEST_FUNCTION_CALL_MODE SetDataMessage(IBestDataMessage* dataMsg) = 0;
		///获取数据层消息
		virtual IBestDataMessage* BEST_FUNCTION_CALL_MODE GetDataMessage() = 0;
		///从另一个消息复制到自身
		virtual int32 BEST_FUNCTION_CALL_MODE CopyFrom(const IBestHeadMessage* other) = 0;
		///复制自身
		virtual IBestHeadMessage* BEST_FUNCTION_CALL_MODE Clone() = 0;
		/**********************************获取和设置*************************/
		///获取$tag的字段,NULL表示不存在
		virtual IBestField*  BEST_FUNCTION_CALL_MODE GetField(const int32& tag) = 0;

		///设置$tag的字段
		virtual void BEST_FUNCTION_CALL_MODE SetField(const int32& tag, IBestField* field) = 0;

		///判断$tag的字段是否存在
		virtual bool BEST_FUNCTION_CALL_MODE IsExistField(const int32& tag) = 0;

		///获取字段迭代器
		virtual BestIterator* BEST_FUNCTION_CALL_MODE GetIterator() = 0;

	};

	/**
	@class IBestRPCHead
	@describe BESTRPC头部
	*/
	class IBestRPCHead :public IBestBase, public IBestStream
	{
	public:
		virtual BEST_OBJECT_TYPE  BEST_FUNCTION_CALL_MODE GetBestType() { return OBJ_BEST_RPC_HEAD; }
		/*****************************besthead协议固定头部数据*******************************/
		///获取协议标识符
		virtual int32 BEST_FUNCTION_CALL_MODE GetBestProtTag() = 0;
		///获取协议标识符
		virtual void  BEST_FUNCTION_CALL_MODE SetBestProtTag(const int32& protTag) = 0;
		///获取协议版本
		virtual int32 BEST_FUNCTION_CALL_MODE GetBestProtVersion() = 0;
		///设置协议版本
		virtual void  BEST_FUNCTION_CALL_MODE SetBestProtVersion(const int32& protVersion) = 0;
		///获取协议总长度
		virtual uint32 BEST_FUNCTION_CALL_MODE GetTotalLenght() = 0;
		///获取状态码
		virtual uint8  BEST_FUNCTION_CALL_MODE GetStatus() = 0;
		///设置状态码
		virtual void BEST_FUNCTION_CALL_MODE SetStatus(const uint8& status) = 0;
		//获取包类型
		virtual PACKET_TYPE BEST_FUNCTION_CALL_MODE GetPackType() = 0;
		//设置包类型
		virtual void BEST_FUNCTION_CALL_MODE SetPackType(const PACKET_TYPE& packType) = 0;
		///获取子包个数 
		virtual uint8 BEST_FUNCTION_CALL_MODE GetSubHeadNum() = 0;
		///获取序列号
		virtual uint64 BEST_FUNCTION_CALL_MODE GetSeqNum() = 0;
		///设置序列号
		virtual void  BEST_FUNCTION_CALL_MODE SetSeqNum(const uint64& seqNum) = 0;
		///获取会话号
		virtual uint64 BEST_FUNCTION_CALL_MODE GetSessionNum() = 0;
		///设置会话号
		virtual void  BEST_FUNCTION_CALL_MODE SetSessionNum(const uint64& sessionNum) = 0;
		///获取功能号
		virtual uint32 BEST_FUNCTION_CALL_MODE GetFuncNo() = 0;
		///设置功能号
		virtual void  BEST_FUNCTION_CALL_MODE SetFuncNo(const uint32& funcNo) = 0;
		///获取校验位
		virtual uint32 BEST_FUNCTION_CALL_MODE GetCRCCheck() = 0;
		///设置校验位
		virtual void  BEST_FUNCTION_CALL_MODE SetCRCCheck(const uint32& crc) = 0;

		///从另一个对象复制到自身
		virtual int32 BEST_FUNCTION_CALL_MODE CopyFrom(const IBestRPCHead *other) = 0;
		///复制自身
		virtual IBestRPCHead* BEST_FUNCTION_CALL_MODE Clone() = 0;
	};

	/**
	@class IBestMessge
	@describe BEST消息头部
	*/
	class IBestMessge : public IBestBase, public IBestStream
	{
	public:
		virtual BEST_OBJECT_TYPE  BEST_FUNCTION_CALL_MODE GetBestType() { return OBJ_BEST_MESSAGE; }
		///获取RPC头
		virtual IBestRPCHead* GetRpcHead() = 0;
		///设置RPC头
		virtual int32 SetRpcHead(IBestRPCHead* rpc_head) = 0;
		/*****************************操作Head协议层*******************************/
		///添加头消息
		virtual int32  BEST_FUNCTION_CALL_MODE AddHeadMessage(IBestHeadMessage* headMessage) = 0;
		virtual IBestHeadMessage*  BEST_FUNCTION_CALL_MODE AddHeadMessage() = 0;
		///从另一个消息复制到自身
		virtual int32 BEST_FUNCTION_CALL_MODE CopyFrom(const IBestMessge *bestMessage) = 0;	
		///复制自身
		virtual IBestMessge* BEST_FUNCTION_CALL_MODE Clone() = 0;
		
		///获取字段迭代器
		virtual BestIterator* BEST_FUNCTION_CALL_MODE GetIterator() = 0;

		///释放消息序列化和反序里化buffer字段
		virtual int32 ReleaseBuffer(bool isReleaseData = false) = 0;


	};

	/**
	 @class IBestMessgeFactory
	 @describe BEST消息工厂
	*/
	class IBestMessgeFactory
	{
	public:
		///创建BestMessage消息，根据协议关联序列化器
		virtual IBestMessge* BEST_FUNCTION_CALL_MODE CreateBestMessage(PROTOCAL_TYPE protocal = BEST_MEASSAGE) = 0;
		///创建BestRPC头部消息
		virtual IBestRPCHead* BEST_FUNCTION_CALL_MODE CreateRpcHead(PROTOCAL_TYPE protocal = BEST_RPC) = 0;
		///创建Best头部消息
		virtual IBestHeadMessage* BEST_FUNCTION_CALL_MODE CreateHeadMessage(PROTOCAL_TYPE protocal = BEST_HEAD_STAMP) = 0;
		///创建BestMessage消息，根据协议关联序列化器
		virtual IBestDataMessage* BEST_FUNCTION_CALL_MODE CreateDataMessage(PROTOCAL_TYPE protocal = BEST_DATA_RAW) = 0;
		///创建BestGroup消息，根据协议关联序列化器
		virtual IBestGroup* BEST_FUNCTION_CALL_MODE CreateBestGroup(PROTOCAL_TYPE protocal = BEST_PROTOCAL_NONE) = 0;
		///创建Best记录消息，根据协议关联序列化器
		virtual IBestRecord* BEST_FUNCTION_CALL_MODE CreateBestRecord(PROTOCAL_TYPE protocal = BEST_PROTOCAL_NONE) = 0;
		///创建Best字段，根据协议关联序列化器
		virtual IBestField* BEST_FUNCTION_CALL_MODE CreateBestField(PROTOCAL_TYPE protocal = BEST_HEAD_STAMP) = 0;
		///根据协议返回序列化器
		virtual IBestSerializer* BEST_FUNCTION_CALL_MODE GetSerializer(PROTOCAL_TYPE protocal = BEST_HEAD_STAMP) = 0;
	};


};

	#ifdef __cplusplus
	extern "C" {
	#endif
		best_protocol::IBestMessgeFactory * BEST_FUNCTION_CALL_MODE CreateBestMessgeFactrotyInstance();
		int32  BEST_FUNCTION_CALL_MODE InitBestMessge();
	#ifdef __cplusplus
	};
	#endif

#endif
