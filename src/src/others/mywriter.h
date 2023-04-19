
#ifndef MYWRITER_H
#define MYWRITER_H

#include <QString>
#include <QDebug>
#include <QList>
#include <QDateTime>


class myWriter
{
public:
    myWriter(const QString format, const QString itemFormat);
protected:
    void addSource(const QString srcName, const QString srcPath);
    QString getNewSrcName(const int8_t index);
public:
    QString parseEntry(QString textEntry);
private:
    QList<QPair<QString, QString>> sourceList;
    QString entryFormat;
    QString newItemFormat;
};

#endif // MYWRITER_H
