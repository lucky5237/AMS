#ifndef __ATOMIC_COUNT_H
#define __ATOMIC_COUNT_H

#if defined(_WIN32) || defined(WIN32) || defined(__WIN32__)
#include <windows.h>
#ifdef _WIN64

//extern "C" long_type __cdecl _InterlockedIncrement(long volatile *);
//extern "C" long_type __cdecl _InterlockedDecrement(long volatile *);
//extern "C" long_type __cdecl _InterlockedExchangeAdd(long volatile *, long);
//
//#pragma intrinsic(_InterlockedIncrement)
//#pragma intrinsic(_InterlockedDecrement)
//
//inline long InterlockedIncrement(long volatile * lp)
//{
//	return _InterlockedIncrement(lp);
//}
//
//inline long InterlockedDecrement(long volatile * lp)
//{
//	return _InterlockedDecrement(lp);
//}
//
//inline long InterlockedExchangeAdd(long volatile * lp, long var)
//{
//	return _InterlockedExchangeAdd(lp, var);
//}

#else
/*
extern "C" __declspec(dllimport) long __stdcall InterlockedIncrement(long volatile *);
extern "C" __declspec(dllimport) long __stdcall InterlockedDecrement(long volatile *);
extern "C" __declspec(dllimport) long __stdcall InterlockedExchangeAdd(long volatile *, long);
*/
#endif

class atomic_count
{
public:
	atomic_count() : value_(0) {}

	explicit atomic_count( long v ): value_( v )
	{
	}

	long operator++()
	{
		return InterlockedIncrement(const_cast<long*>(&value_));
	}

	long operator--()
	{
		return InterlockedDecrement(const_cast<long*>(&value_));
	}

	long add(long n)
	{
		return InterlockedExchangeAdd(const_cast<long*>(&value_), n) + n;
	}

	operator long() const
	{
		return value_;
	}

    long operator += (long n)
    {
        add(n);
        return value_;
    }

    long operator -= (long n)
    {
        add(-n);
        return value_;
    }

private:

	atomic_count( atomic_count const & );
	atomic_count & operator=( atomic_count const & );

	volatile long value_;
};

#elif defined(__GLIBCPP__) || defined(__GLIBCXX__)
#if defined( __GNUC__ ) && ( __GNUC__ * 100 + __GNUC_MINOR__ >= 402 )
#  include <ext/atomicity.h>
#else
#  include <bits/atomicity.h>
#endif

#if defined(__GLIBCXX__) // g++ 3.4+
using __gnu_cxx::__atomic_add;
using __gnu_cxx::__exchange_and_add;
#endif

class atomic_count
{
public:
	atomic_count() : value_(0) {}

	explicit atomic_count( long v ) : value_( static_cast< int >( v ) ) {}

	long operator++()
	{
		return __exchange_and_add( &value_, +1 ) + 1;
	}

	long operator--()
	{
		return __exchange_and_add( &value_, -1 ) - 1;
	}

	long add(long n)
	{
		return __exchange_and_add( &value_, n ) + n;
	}

	operator long() const
	{
		return __exchange_and_add( &value_, 0 );
	}

    long operator += (long n)
    {
        add(n);
        return value_;
    }

    long operator -= (long n)
    {
        add(-n);
        return value_;
    }

private:

	atomic_count(atomic_count const &);
	atomic_count & operator=(atomic_count const &);

	mutable _Atomic_word value_;
};
#elif defined( __GNUC__ ) && ( defined( __i386__ ) || defined( __x86_64__ ) )
class atomic_count
{
public:
	atomic_count() : value_(0) {}

	explicit atomic_count( long v ) : value_( static_cast< int >( v ) ) {}

	long operator++()
	{
		return atomic_exchange_and_add( &value_, +1 ) + 1;
	}

	long operator--()
	{
		return atomic_exchange_and_add( &value_, -1 ) - 1;
	}

	long add(long n)
	{
		return atomic_exchange_and_add( &value_, n ) + n;
	}

	operator long() const
	{
		return atomic_exchange_and_add( &value_, 0 );
	}

    long operator += (long n)
    {
        add(n);
        return value_;
    }

    long operator -= (long n)
    {
        add(-n);
        return value_;
    }

private:

	atomic_count(atomic_count const &);
	atomic_count & operator=(atomic_count const &);

	mutable int value_;

private:

	static int atomic_exchange_and_add( int * pw, int dv )
	{
		// int r = *pw;
		// *pw += dv;
		// return r;

		int r;

		__asm__ __volatile__
			(
			"lock\n\t"
			"xadd %1, %0":
		"+m"( *pw ), "=r"( r ): // outputs (%0, %1)
		"1"( dv ): // inputs (%2 == %1)
		"memory", "cc" // clobbers
			);

		return r;
	}
};
#else
	typedef long atomic_count;
#endif

#endif

