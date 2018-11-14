// 为QS而设计，最终未使用
// “不加锁”的情况下，Alloc/Free的耗时只有new/delete的30%左右
// 加CThreadMutex锁之后的性能未测
#ifndef __MEMORY_POOL_H__
#define __MEMORY_POOL_H__

#include <vector>
using std::vector;
#include "best_message.h"
#include "qcstutils.h"

/// 内存池类
/// 适合频繁申请/释放固定长度小内存的场景
class MemoryPool
{
public:
    inline MemoryPool();
    inline ~MemoryPool();

    // 返回0表示成功
    // 返回-1表示内存申请失败
    // block_size为内存块大小
    // block_count为初始内存块个数
    inline int Init(int block_size, int block_count);

    // 从池子里取内存块
    // 返回NULL表示内存申请失败
    inline uint8 * Alloc();
    // 把内存归还到池子里
    inline void Free(void *block);

private:
    // 屏蔽拷贝构造方法和赋值运算符重载
    MemoryPool(const MemoryPool &another);
    MemoryPool & operator = (const MemoryPool &another);

private:
    // 第一块内存块的地址
    uint8 *m_head;

    // 初始化时每块内存的大小
    int m_block_size;
    // 初始化时内存块的个数
    int m_block_count;

    // 用于存放从操作系统获取的内存首地址
    vector<uint8 *> m_start_address;

    // 用锁来保证多线程访问安全
    QCMutex m_mutex;
};

#include "memory_pool.inl"

#endif
