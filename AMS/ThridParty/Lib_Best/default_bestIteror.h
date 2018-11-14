
#ifndef DEFAULT_BEST_ITEROT_H
#define DEFAULT_BEST_ITEROT_H
#include"best_message.h"
#include <list>
#include <map>
#include "atomic_count.h"
using namespace best_protocol;
class DefaultBestIterator :public BestIterator
{
	friend class DefaultBestMessge;
	friend class DefaultBestHeadMessage;
private:
	void Initail(std::list<IBestBase*>* bestFieldList);
public:
	DefaultBestIterator();
	///获取迭代器第一个节点
	virtual void BEST_FUNCTION_CALL_MODE First();
	///返回迭代器下一个结点
	virtual void BEST_FUNCTION_CALL_MODE Next();

	///判断是否还存在下一个结点
	virtual bool BEST_FUNCTION_CALL_MODE IsDone();
	///删除迭代器当前节点
	virtual bool BEST_FUNCTION_CALL_MODE Erase();

	///获取迭代器内容节点
	virtual IBestBase* CurrentItem() const;
};


class DefaultBestListIterator :public BestIterator
{
	friend class DefaultBestMessge;
private:
	void Initail(std::list<IBestBase*>* bestFieldList);
public:
	DefaultBestListIterator();
	///获取迭代器第一个节点
	virtual void BEST_FUNCTION_CALL_MODE First();
	///返回迭代器下一个结点
	virtual void BEST_FUNCTION_CALL_MODE Next();

	///判断是否还存在下一个结点
	virtual bool BEST_FUNCTION_CALL_MODE IsDone();
	///删除迭代器当前节点
	virtual bool BEST_FUNCTION_CALL_MODE Erase();

	///获取迭代器内容节点
	virtual IBestBase* CurrentItem() const;
private:
	std::list<IBestBase*>* m_bestFieldList;
	std::list<IBestBase*>::iterator m_pCurrent;
};


class DefaultBestMapIterator :public BestIterator
{
	friend class DefaultBestHeadMessage;
	friend class DefaultBestDataHeadMessage;
private:
	void Initail(std::map<int32, IBestField*>* bestFieldMap);
public:
	DefaultBestMapIterator();
	///获取迭代器第一个节点
	virtual void BEST_FUNCTION_CALL_MODE First();
	///返回迭代器下一个结点
	virtual void BEST_FUNCTION_CALL_MODE Next();

	///判断是否还存在下一个结点
	virtual bool BEST_FUNCTION_CALL_MODE IsDone();
	///删除迭代器当前节点
	virtual bool BEST_FUNCTION_CALL_MODE Erase();

	///获取迭代器内容节点
	virtual IBestBase* CurrentItem() const;
private:
	std::map<int, IBestField*>* m_bestFieldList;
	std::map<int, IBestField*>::iterator m_pCurrent;
};
#endif