#ifndef STEP_SERIALIZER_H
#define STEP_SERIALIZER_H
#include <map>
#include <vector>
#include <string>
#include "best_message.h"
#include "default_message_pool.h"
#define STEP_FIELD_DELIM 0x01
using namespace best_protocol;
class StepSerializer
{
public:
	static int32 SerialzeStep(BestBuffer* best_buffer, std::map<int, IBestField*>& hmf_Map);
	static int32 SerialzeFixStep(BestBuffer* best_buffer, std::map<int, IBestField*>& hmf_Map);
	static	void DeSerialzeStep(const char* buff, const int buff_len,std::map<int, IBestField*>& hmf_Map);
	
private:
	static void GetBestFieldValue(IBestField* field, std::string& fieldString);
	static BestBuffer* GetRawDataBestFieldValue(IBestField* field);
	static int SplitValue(std::map<int, IBestField*>& hmf_Map, char* buff, int buff_len);
	static void SetFieldValue(IBestField* bestField, int value_type, const char* buff);
	
};
#endif