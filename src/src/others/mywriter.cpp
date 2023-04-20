
#include "mywriter.h"

myWriter::myWriter(const QString format, const QString itemFormat) : entryFormat(format), newItemFormat(itemFormat){}

void myWriter::addSource(const QString srcName, const QString srcPath)
{
    this->sourceList.append(qMakePair(srcName, srcPath));
}

QString myWriter::getNewSrcName(const int8_t index)
{
    QString newSrcName = this->newItemFormat;
    newSrcName = newSrcName.replace("<source_number>", QString::number(index + 1));
    newSrcName = newSrcName.replace("<entry_number>", "(entry_number)");

    return newSrcName;
}

QString myWriter::parseEntry(QString textEntry)
{
    for (int i = 0; i < sourceList.size(); i++) {
        qDebug()<<QDateTime::currentDateTime().toString("hh:mm:ss.zzz")<<sourceList.at(i).first<< sourceList.at(i).second;
    }
    return QDateTime::currentDateTime().toString("hh:mm:ss.zzz ") + this->entryFormat + "           " +textEntry;
}
