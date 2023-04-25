
#include "mywritergui.h"

myWriterGUI::myWriterGUI(const QString format, const QString itemFormat, QObject *parent)
    : QObject{parent}, myWriter(format, itemFormat){}

void myWriterGUI::addSource(const QString srcName, const QString srcPath)
{
    myWriter::addSource(srcName, srcPath);
}

void myWriterGUI::finishEntry(const QString textEntry, QString pathToSaveIn, const bool useDetailedFormat)
{
    saveEntry(textEntry, pathToSaveIn, useDetailedFormat);
}

QString myWriterGUI::getNewSrcName(const int8_t index)
{
    return myWriter::getNewSrcName(index);
}
