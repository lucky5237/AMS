//---------------------------------------------------------- -*- Mode: C++ -*-
//说明：HPR库本身有问题会导致EmuClient编译不通过，目前无法解决，所以才用开源的文件
// $Id: qcmutex.h 385 2010-05-27 15:58:30Z sriramsrao $
//
// Created 2008/10/30
//
// Licensed under the Apache License, Version 2.0
// (the "License"); you may not use this file except in compliance with
// the License. You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
// implied. See the License for the specific language governing
// permissions and limitations under the License.
//
//----------------------------------------------------------------------------

#ifndef QCMUTEX_H
#define QCMUTEX_H

#if (defined _WIN32)||(defined _WIN64)
typedef CRITICAL_SECTION  MUTEX_T;
#else
#include <pthread.h>
typedef pthread_mutex_t MUTEX_T;
#endif


class QCMutex
{
public:
	//typedef INT64 Time;

	QCMutex();
	
    ~QCMutex();

	bool Lock();

	bool TryLock();

	bool Unlock();

private:
	int     mLockCnt;
	MUTEX_T	mMutex;

private:
	// No copies.
	QCMutex(
		const QCMutex& inMutex);
	QCMutex& operator=(
		const QCMutex& inMutex);
};

#endif /* QCMUTEX_H */
