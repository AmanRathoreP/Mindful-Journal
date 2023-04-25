
#ifndef MYWRITER_H
#define MYWRITER_H

#include <QString>
#include <QDebug>
#include <QList>
#include <QDateTime>
#include <QRegularExpression>
#include <QFile>


class myWriter
{
public:
    myWriter(const QString format, const QString itemFormat);
protected:
    void addSource(const QString srcName, const QString srcPath);
    QString getNewSrcName(const int8_t index);
public:
    QString parseEntry(QString textEntry, const bool useDetailedFormat);
    void saveEntry(const QString textEntry, QString pathToSaveIn, const bool useDetailedFormat);
private:
    QList<QPair<QString, QString>> sourceList;
    QString entryFormat;
    QString newItemFormat;
};

#endif // MYWRITER_H
