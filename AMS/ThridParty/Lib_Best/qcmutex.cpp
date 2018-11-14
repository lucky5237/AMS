#include "stdafx.h"
#include "qcmutex.h"
#include <time.h>
#include <errno.h>

#ifdef QC_OS_NAME_DARWIN 
#   define pthread_mutex_timedlock(m, l) pthread_mutex_lock(m)
#endif

#if (defined _WIN32)||(defined _WIN64)
QCMutex::QCMutex()
: mLockCnt(0)
{
	InitializeCriticalSection(&mMutex);
}

QCMutex::~QCMutex()
{
	DeleteCriticalSection(&mMutex);
}

bool QCMutex::Lock()
{ 
    EnterCriticalSection(&mMutex);
    return true; 
}

bool QCMutex::TryLock()
{
    const int theErr = TryEnterCriticalSection(&mMutex);
    if(FALSE == theErr)
    {
        return false;
    }
    else
    {
        return true;
    }
}

bool QCMutex::Unlock()
{
    LeaveCriticalSection(&mMutex);
    return true;
}

#else

QCMutex::QCMutex()
: mLockCnt(0),
mMutex()
{
    int theErr;
    pthread_mutexattr_t theAttr;
    if ((theErr = pthread_mutexattr_init(&theAttr)) != 0)
    {
        ;
    }

    if ((theErr = pthread_mutexattr_settype(
        &theAttr, PTHREAD_MUTEX_RECURSIVE)) != 0) 
    {
        ;
    }

    if ((theErr = pthread_mutex_init(&mMutex, &theAttr)) != 0) 
    {
        ;
    }

    if ((theErr = pthread_mutexattr_destroy(&theAttr)) != 0) 
    {
        ;
    }
}

QCMutex::~QCMutex()
{
    pthread_mutex_destroy(&mMutex);
}

bool QCMutex::Lock()
{ 
    pthread_mutex_lock(&mMutex);
    return true; 
}

bool QCMutex::TryLock()
{
    const int theErr = pthread_mutex_trylock(&mMutex);
    return (theErr != EBUSY);
}

bool QCMutex::Unlock()
{
    pthread_mutex_unlock(&mMutex);
    return true;
}


#endif

