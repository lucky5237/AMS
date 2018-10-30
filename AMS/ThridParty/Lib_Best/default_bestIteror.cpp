#include "default_bestIteror.h"

DefaultBestIterator::DefaultBestIterator()
{

}

void DefaultBestIterator::Initail(std::list<IBestBase*>* bestFieldList)
{
	
}

void DefaultBestIterator::First()
{

	
}

void DefaultBestIterator::Next()
{
	
}

bool DefaultBestIterator::IsDone()
{
	return false;
}

bool DefaultBestIterator::Erase()
{
	return false;
};

IBestBase* DefaultBestIterator::CurrentItem() const
{
	return NULL;
}


DefaultBestListIterator::DefaultBestListIterator()
{
}

void DefaultBestListIterator::Initail(std::list<IBestBase*>* bestFieldList)
{
	m_bestFieldList = bestFieldList;
	m_pCurrent = bestFieldList->end();
}

void DefaultBestListIterator::First()
{
	m_pCurrent = m_bestFieldList->begin();

}

void DefaultBestListIterator::Next()
{
	++m_pCurrent;
}

bool DefaultBestListIterator::IsDone()
{
	if (m_pCurrent == m_bestFieldList->end())
	{
		return true;
	}

	return false;
}

bool DefaultBestListIterator::Erase()
{
	if (m_pCurrent == m_bestFieldList->end())
	{
		m_bestFieldList->erase(m_pCurrent);
		return true;
	}
	return false;
};

IBestBase* DefaultBestListIterator::CurrentItem() const
{
	if (m_pCurrent == m_bestFieldList->end())
	{
		return NULL;
	}
	else
	{
		return(*m_pCurrent);
	}
}



DefaultBestMapIterator::DefaultBestMapIterator()
{
}

void DefaultBestMapIterator::Initail(std::map<int32, IBestField*>* bestFieldMap)
{
	m_bestFieldList = bestFieldMap;
	m_pCurrent = m_bestFieldList->end();
}

void DefaultBestMapIterator::First()
{
	m_pCurrent = m_bestFieldList->begin();

}

void DefaultBestMapIterator::Next()
{
	++m_pCurrent;
}

bool DefaultBestMapIterator::IsDone()
{
	if (m_pCurrent == m_bestFieldList->end())
	{
		return true;
	}

	return false;
}

bool DefaultBestMapIterator::Erase()
{
	if (m_pCurrent == m_bestFieldList->end())
	{
		m_bestFieldList->erase(m_pCurrent);
		return true;
	}
	return false;
};
	
IBestBase* DefaultBestMapIterator::CurrentItem() const
{
	if (m_pCurrent == m_bestFieldList->end())
	{
		return NULL;
	}
	else
	{
		return((*m_pCurrent).second);
	}
}