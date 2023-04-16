
#ifndef MYWRITER_H
#define MYWRITER_H

#include <QString>
#include <QDebug>
#include <QList>
#include <QDateTime>


class myWriter
{
public:
    myWriter(const QString format);
protected:
    void addSource(const QString srcName, const QString srcPath);
public:
    QString parseEntry(QString textEntry);
private:
    QList<QPair<QString, QString>> sourceList;
    QString entryFormat;
};

#endif // MYWRITER_H
