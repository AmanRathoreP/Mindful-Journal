
#ifndef MYWRITERGUI_H
#define MYWRITERGUI_H


#include <QObject>
#include "../others/mywriter.h"
#include <QVariant>
#include <QDebug>


class myWriterGUI : public QObject, public myWriter
{
    Q_OBJECT
public:
    explicit myWriterGUI(const QString format, const QString itemFormat, QObject *parent = nullptr);
    Q_INVOKABLE void addSource(const QString srcName, const QString srcPath);
    Q_INVOKABLE void finishEntry(const QString textEntry);
    Q_INVOKABLE QString getNewSrcName(const int8_t index);
};

#endif // MYWRITERGUI_H
