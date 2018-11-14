#include "default_message.h"
#include "default_best_message_factory.h"
#include "default_message_pool.h"
///*******************获取和设置对应的Record字段值*********************/
//IBestField* DefaultBestRecord::GetField(const int32& tag)
//{
//	return 0;
//}
//
/////设置$tag的字段
//void DefaultBestRecord::SetField(const int32& tag, IBestField* field)
//{
//
//}
//
/////判断$tag的字段是否存在
//bool DefaultBestRecord::IsExistField(const int32& tag)
//{
//	return true;
//}
//
/////从另一个对象复制到自身
//int32 DefaultBestRecord::CopyFrom(const IBestRecord *other)
//{
//	return 0;
//}
/////复制自身
//IBestRecord* DefaultBestRecord::Clone()
//{
//	return 0;
//}
//
//DefaultBestIterator*   DefaultBestRecord::GetIterator()
//{
//	return &m_defaultIterator;
//}

IBestMessgeFactory*  BEST_FUNCTION_CALL_MODE CreateBestMessgeFactrotyInstance()
{
	return DefaultBestMessgeFactory::GetInstance();
}

int32  BEST_FUNCTION_CALL_MODE InitBestMessge()
{
	DefaultMessagePool::InitDefaultMessagePool();
	return 0;
}



