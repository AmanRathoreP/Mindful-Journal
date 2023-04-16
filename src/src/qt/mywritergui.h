
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
    explicit myWriterGUI(const QString format, QObject *parent = nullptr);
    Q_INVOKABLE void addSource(const QString srcName, const QString srcPath);
    Q_INVOKABLE void finishEntry(const QString textEntry);

};

#endif // MYWRITERGUI_H
