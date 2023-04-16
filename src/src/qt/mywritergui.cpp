
#include "mywritergui.h"

myWriterGUI::myWriterGUI(const QString format, QObject *parent)
    : QObject{parent}, myWriter(format){}

void myWriterGUI::addSource(const QString srcName, const QString srcPath)
{
    myWriter::addSource(srcName, srcPath);
}

void myWriterGUI::finishEntry(const QString textEntry)
{
    qDebug() << parseEntry(textEntry);
}
