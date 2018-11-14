#ifndef DEFAULT_MESSAGE_POOL_H
#define DEFAULT_MESSAGE_POOL_H
class DefaultBestMessge;
class DefaultBestDataMessage;
class DefaultBestRPCHead;
class DefaultBestHeadMessage;
class DefaultBestGroup;
class DefaultBestRecord;
class DefaultBestField;
class DefaultBestDataHeadMessage;
enum BESTBUFFER_TYPE {
	BUFFER_NONE,
	BUFFER_512,
	BUFFER_1K,
	BUFFER_4K,
	BUFFER_64K,
	BUFFER_256K,
	BUFFER_LARGE
};

typedef struct BestBuffer_t
{
	BESTBUFFER_TYPE bufferType;
	char* buff;
	int capacity;
	int pos;
	int len;
}BestBuffer;

class DefaultMessagePool
{
public:
	static int InitDefaultMessagePool();
	static DefaultBestMessge*  AcquireDefaultBestMessge();
	static void  ReleaseDefaultBestMessge(DefaultBestMessge* default_best_message);
	static DefaultBestHeadMessage* AcquireDefaultBestHeadMessage();
	static void  ReleaseDefaultBestHeadMessage(DefaultBestHeadMessage* default_head_message);
	//
	static DefaultBestDataHeadMessage* AcquireDefaultBestDataHeadMessage();
	static void  ReleaseDefaultBestDataHeadMessage(DefaultBestDataHeadMessage* default_head_message);
	//
	static DefaultBestRPCHead* AcquireDefaultBestRPCHead();
	static void ReleaseDefaultBestRPCHead(DefaultBestRPCHead* default_best_rpchead);
	static DefaultBestDataMessage* AcquireDefaultBestDataMessage();
	static void  ReleaseDefaultBestDataMessage(DefaultBestDataMessage* default_data_message);
	static DefaultBestGroup* AcquireDefaultBestGroup();
	static void  ReleaseDefaultBestGroup(DefaultBestGroup* default_best_group);
	static DefaultBestRecord* AcquireDefaultBestRecord();
	static void  ReleaseDefaultBestRecord(DefaultBestRecord* default_best_record);
	static DefaultBestField* AcquireDefaultBestField();
	static void ReleaseDefaultBestField(DefaultBestField* default_head_field);
	static BestBuffer* AcquireBestBuffer(int buffer_len);
	static void ReleaseBestBuffer(BestBuffer* best_buffer);
	static BestBuffer* Acquire512BestBuffer(int len);
	static void Release512BestBuffer(BestBuffer* best_buffer);
	static BestBuffer* Acquire1KBestBuffer(int len);
	static void Release1KBestBuffer(BestBuffer* best_buffer);
	static BestBuffer* Acquire4KBestBuffer(int len);
	static void Release4KBestBuffer(BestBuffer* best_buffer);
	static BestBuffer* Acquire64KBestBuffer(int len);
	static void Release64KBestBuffer(BestBuffer* best_buffer);
	static BestBuffer* Acquire256KBestBuffer(int len);
	static void Release256KBestBuffer(BestBuffer* best_buffer);
	static BestBuffer* AcquireLargeBestBuffer(int len);
	static void ReleaseLargeBestBuffer(BestBuffer* best_buffer);
	/*static int countorBuffer;*/
	/*static int countorObject;*/
};
#endif




