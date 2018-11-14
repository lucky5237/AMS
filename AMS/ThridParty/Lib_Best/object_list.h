/**
	20120920	maoyinjie	增加对池加锁,解锁的接口

**/
#ifndef __OBJECT_LIST_THREAD_SAFE_H
#define __OBJECT_LIST_THREAD_SAFE_H

#include <os/thread_mutex.h>

USING_NAMESPACE(FBASE2_NAMESPACE)


class Object_Node
{
public:
	Object_Node()
	{
		memset(this, 0, sizeof(Object_Node));
	}
	~Object_Node()
	{
	}
	void Value(void* lpValue)
	{
		m_lpValue=lpValue;
	}
	void* Value()
	{
		return m_lpValue;
	}
	Object_Node* Next()
	{
		return m_lpNext;
	}
	void Next(Object_Node* lpNext)
	{
		m_lpNext=lpNext;
	}	
		
private:
	Object_Node* m_lpNext;
	void* 		 m_lpValue;
};
class Node_Pool
{
public:
	Node_Pool(int iSize)
	{
		m_lpHead=NULL;
		int i;
		for(i=0; i<iSize; i++)
		{
			Object_Node* lpNode=FBASE_NEW Object_Node;
			Push(lpNode);
		}
	}
	~Node_Pool()
	{
		Object_Node* lpNode=m_lpHead;
		while(lpNode)
		{
			Object_Node* lpNext=lpNode->Next();
			delete lpNode;
			lpNode=lpNext;
		}
	}
	Object_Node* Pop()
	{
		Object_Node* lpNode=NULL;
		if(m_lpHead)
		{
			lpNode=m_lpHead;
			m_lpHead=lpNode->Next();
		}
		
		if(!lpNode)
		{
			lpNode=FBASE_NEW Object_Node;
		}

		return lpNode;
	}
	void Push(Object_Node* lpNode)
	{
		lpNode->Value(NULL);
		lpNode->Next(m_lpHead);
		m_lpHead=lpNode;
	}
private:
	Object_Node* m_lpHead;
};

template <typename T>
class Object_List
{
public:
	typedef T element_type;
	typedef size_t size_type;

public:
	Object_List(int sz) 
	{ 
		m_iNodesInPool=0;
		m_iAllocedNodes=0;
		m_iMaxAllocedNodes = 0;

		m_iGetTimes=0;
		m_iReleaseTimes=0;
		m_lpHead=NULL;
		m_lpNodePool=FBASE_NEW Node_Pool(sz);
		int i;
		for(i=0; i<sz; i++)
		{
			m_iAllocedNodes++;
			T* lpT=FBASE_NEW T;
			Free(lpT);
		}

        m_iMaxAllocedNodes = m_iAllocedNodes;

		m_iReleaseTimes-=sz;
	}

	Object_List() 
	{ 
		m_iNodesInPool=0;
		m_iAllocedNodes=0;
		m_iMaxAllocedNodes = 0;

		m_iGetTimes=0;
		m_iReleaseTimes=0;
		m_lpHead=NULL;
//		m_lpNodePool=NULL;
		m_lpNodePool=FBASE_NEW Node_Pool(32);
	}
	int Init(int sz = 32)
	{ 
		m_iNodesInPool=0;
		m_iAllocedNodes=0;
		m_iMaxAllocedNodes = 0;

		m_iGetTimes=0;
		m_iReleaseTimes=0;
		m_lpHead=NULL;
		m_lpNodePool=FBASE_NEW Node_Pool(sz);
		int i;
		for(i=0; i<sz; i++)
		{
			m_iAllocedNodes++;
			T* lpT=FBASE_NEW T;
			Free(lpT);
		}
        m_iMaxAllocedNodes = m_iAllocedNodes;
		m_iReleaseTimes-=sz;
		return 0;
	}


	~Object_List() 
	{ 
		delete m_lpNodePool;
		Object_Node* lpNode=m_lpHead;
		while(lpNode)
		{
			Object_Node* lpNext=lpNode->Next();
			T* lpT=(T*)lpNode->Value();
			delete lpT;
			delete lpNode;
			lpNode=lpNext;
		}
	}

	//##ModelId=4C28B0C301CA
	element_type * Get()
	{ 
#ifndef EXPORT_API
		QCStMutexLocker auto_mutex(&m_Lock);
#endif
		Object_Node* lpNode=m_lpHead;
		if(lpNode)
		{
            m_iGetTimes++;
			m_iNodesInPool--;
			T* lpT=(T*)lpNode->Value();
			m_lpHead=m_lpHead->Next();
			m_lpNodePool->Push(lpNode);
			return lpT;
		}


//printf("Get:  %d\n", m_iAllocedNodes);
		m_iAllocedNodes++;
        if (m_iAllocedNodes > m_iMaxAllocedNodes)
        {
            m_iMaxAllocedNodes = m_iAllocedNodes;
        }
		return FBASE_NEW T;
	}

	element_type * GetNoLock()
	{
		Object_Node* lpNode=m_lpHead;
		if(lpNode)
		{
            m_iGetTimes++;
			m_iNodesInPool--;
			T* lpT=(T*)lpNode->Value();
			m_lpHead=m_lpHead->Next();
			m_lpNodePool->Push(lpNode);
			return lpT;
		}
		
//printf("Get:  %d\n", m_iAllocedNodes);
		m_iAllocedNodes++;
        if (m_iAllocedNodes > m_iMaxAllocedNodes)
        {
            m_iMaxAllocedNodes = m_iAllocedNodes;
        }
		return FBASE_NEW T;
	}
	//##ModelId=4C28B0C301CC
	void Free(element_type * const chunk)
	{ 
#ifndef EXPORT_API
		QCStMutexLocker auto_mutex(&m_Lock);
#endif
		m_iReleaseTimes++;
		Object_Node* lpNode=m_lpNodePool->Pop();
		if(!lpNode)
		{
			delete chunk;
			return ;
		}
		m_iNodesInPool++;
		lpNode->Value(chunk);
		lpNode->Next(m_lpHead);
		m_lpHead=lpNode;
	}

	void FreeNoLock(element_type * const chunk)
	{ 
		m_iReleaseTimes++;
		Object_Node* lpNode=m_lpNodePool->Pop();
		if(!lpNode)
		{
			delete chunk;
			return ;
		}
		m_iNodesInPool++;
		lpNode->Value(chunk);
		lpNode->Next(m_lpHead);
		m_lpHead=lpNode;
	}

    int GetAlloced()
	{
		return m_iAllocedNodes;
	}

    int GetMaxAlloced()
    {
        return m_iMaxAllocedNodes;
    }

	int GetEmpty()
	{
		return m_iNodesInPool;
	}
	int GetTimes()
	{
		return m_iGetTimes;
	}
	int ReleaseTime()
	{
		return m_iReleaseTimes;
	}

	//	20120920	maoyinjie	增加对池加锁,解锁的接口
	void LockList()
	{
#ifndef EXPORT_API
		m_Lock.Lock();
#endif
	}
	void UnLockList()
	{
#ifndef EXPORT_API
		m_Lock.Unlock();
#endif
	}


public:
	Object_Node* m_lpHead;
	QCMutex m_Lock;

	Node_Pool* m_lpNodePool;

	int m_iNodesInPool;
	int m_iAllocedNodes;

	int m_iGetTimes;
	int m_iReleaseTimes;

    int m_iMaxAllocedNodes;
};

#endif
