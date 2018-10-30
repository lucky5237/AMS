inline MemoryPool::MemoryPool():
  m_head(NULL),
  m_block_size(0),
  m_block_count(0)
{}

inline MemoryPool::~MemoryPool()
{
    for (size_t i = 0; i < m_start_address.size(); ++i)
    {
        delete[] m_start_address[i];
    }
}

inline int MemoryPool::Init(int block_size, int block_count)
{
    const int BLOCK_SIZE_MIN = (int)sizeof(uint8 *);

    m_block_size = block_size < BLOCK_SIZE_MIN ? BLOCK_SIZE_MIN : block_size;
    m_block_count = block_count;

    m_head = new(std::nothrow) uint8[m_block_size * m_block_count];

    if (m_head == NULL)
    {
        return -1;
    }

    m_start_address.push_back(m_head);

    uint8 *block = m_head;

    // m_block_count - 1´ÎÑ­»·
    for (int i = 1; i < m_block_count; ++i)
    {
        uint8 *next_block = block + block_size;

        *(uint8 **)block = next_block;
        block = next_block;
    }

    *(uint8 **)block = NULL;

    return 0;
}

inline uint8 * MemoryPool::Alloc()
{
	m_mutex.Lock();
    if (m_head == NULL && Init(m_block_size, m_block_count) != 0)
    {
		m_mutex.Unlock();
        return NULL;
    }

    uint8 *block = m_head;
    m_head = *(uint8 **)m_head;
	m_mutex.Unlock();
    return block;
}

inline void MemoryPool::Free(void *block)
{
	m_mutex.Lock();
    *(uint8 **)block = m_head;
    m_head = (uint8 *)block;
	m_mutex.Unlock();
}
