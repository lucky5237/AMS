
#ifndef DEFAULT_BEST_DATA_MESSAGE_H
#define DEFAULT_BEST_DATA_MESSAGE_H
#include "default_bestIteror.h"
#include"best_message.h"
#include <list>
#include "atomic_count.h"
#include "default_message_pool.h"
using namespace best_protocol;
class DefaultBestDataMessage :public IBestDataMessage
{
private:
	atomic_count m_ref;
	BestBuffer* m_best_buffer;
	int32 m_status;
public:
	DefaultBestDataMessage(){
		m_best_buffer = NULL; 
		m_status = 0;
	}
	///����һ�������Ƶ�����
	virtual int32 BEST_FUNCTION_CALL_MODE CopyFrom(const IBestDataMessage *other);
	///��������
	virtual IBestDataMessage* BEST_FUNCTION_CALL_MODE Clone();

	virtual void BEST_FUNCTION_CALL_MODE SetGroup(const int32& flag, IBestGroup* group) {}

	virtual IBestGroup* BEST_FUNCTION_CALL_MODE GetGroup(const int32& flag) { return 0; }

	virtual bool BEST_FUNCTION_CALL_MODE IsExitGroup(const int32& flag) { return false; }

	///��ȡ$tag���ֶ�,NULL��ʾ������
	virtual IBestField*  BEST_FUNCTION_CALL_MODE GetField(const int32& tag) { return 0; }

	///����$tag���ֶ�
	virtual void BEST_FUNCTION_CALL_MODE SetField(const int32& tag, IBestField* field){}

	///�ж�$tag���ֶ��Ƿ����
	virtual bool BEST_FUNCTION_CALL_MODE IsExistField(const int32& tag) { return false; }

	///��ȡ�ֶε�����
	virtual BestIterator* BEST_FUNCTION_CALL_MODE GetIterator() { return &m_defaultIterator; }

	//��ȡ��ǰ�ֶε�Э��
	virtual const PROTOCAL_TYPE BEST_FUNCTION_CALL_MODE GetProtocal();

	virtual int32 BEST_FUNCTION_CALL_MODE SetProtocal(PROTOCAL_TYPE protpcal);

	int ReleaseBuffer();

private:
	DefaultBestIterator	m_defaultIterator;

	PROTOCAL_TYPE m_protocol_type;

public:
	/************************IBestBase�ӿ�*************************/
	///�������ü�������������
	virtual IBestBase*  BEST_FUNCTION_CALL_MODE AddRef(){
		++m_ref;
		return this;
	}

	///�������ü�������Ϊ0ʱ�ͷ�����
	virtual uint64  BEST_FUNCTION_CALL_MODE Release();
	///����BEST��������
	virtual BEST_OBJECT_TYPE  BEST_FUNCTION_CALL_MODE GetBestType(){ return OBJ_NONE; }

	///������������
	virtual int32 BEST_FUNCTION_CALL_MODE SetOwner(IBestBase* best_base){ return 0; }

	///��ȡ��������
	virtual IBestBase* BEST_FUNCTION_CALL_MODE GetOwner(){ return 0; }

	/****************************IBestStream�ӿ�******************************/
	///���л�����
	virtual const void*  BEST_FUNCTION_CALL_MODE Serialize(int32* len);
	///�����л�
	virtual int32 BEST_FUNCTION_CALL_MODE Deserialize();
	///������
	virtual int32	BEST_FUNCTION_CALL_MODE SetBuffer(const void* buffer, const int32& len);
	///��ȡ��
	virtual void*  BEST_FUNCTION_CALL_MODE GetBuffer(int32* len);
	///������״̬. 1:���� 0:������
	virtual int32  BEST_FUNCTION_CALL_MODE Status();
	///�������л���
	virtual int32   BEST_FUNCTION_CALL_MODE SetBestSerializer(IBestSerializer* serializer){ return 0; }
	///��ȡ���л���
	virtual IBestSerializer* BEST_FUNCTION_CALL_MODE GetBestSerializer(){ return 0; }
};
#endif