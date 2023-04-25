
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

    /*
dd.MM.yyyy	21.05.2001
ddd MMMM d yy	Tue May 21 01
hh:mm:ss.zzz	14:13:09.120
hh:mm:ss.z	14:13:09.12
h:m:s ap	2:13:9 pm
*/

    auto __myCurrentDateTime = QDateTime::currentDateTime();
    for (const QString& str : {"dd", "MM", "yyyy", "ddd", "MMMM", "d", "yy", "hh", "mm", "ss", "zzz", "z", "h", "m", "s", "ap"})
    {
        newSrcName = newSrcName.replace("<" + str + ">", __myCurrentDateTime.toString(str));
    }

    return newSrcName;
}

QString myWriter::parseEntry(QString textEntry, const bool useDetailedFormat)
{
    // TODO: make use of var useDetailedFormat
    for (int i = 0; i < sourceList.size(); i++) {
        qDebug()<<QDateTime::currentDateTime().toString("hh:mm:ss.zzz")<<sourceList.at(i).first<< sourceList.at(i).second;
    }
    return QDateTime::currentDateTime().toString("hh:mm:ss.zzz ") + this->entryFormat + "           " +textEntry;
}

void myWriter::saveEntry(const QString textEntry, QString pathToSaveIn, const bool useDetailedFormat)
{
    QString fileName = (pathToSaveIn + "/" + getNewSrcName(0).replace(QRegularExpression("\\[.*?\\]"), "").trimmed() + ".txt").remove(0, 8);

  qDebug()<< fileName;
    QFile file(fileName);
    if (file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        QTextStream stream(&file);
        stream << parseEntry(textEntry, useDetailedFormat);
        file.close();
    }
}
