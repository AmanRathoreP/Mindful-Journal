import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

Page {

    header: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: "Entry Text"
            ToolTip {
                delay: parseInt(myAppSettings.get_value("delayForToolTipsToAppear"))
                text: "Here is the final text which will be added to your main file of the entry"
                visible: (parent.hovered || parent.pressed) && String(myAppSettings.get_value("showToolTips")).indexOf("t") !== -1 ? true : false
            }
        }
        TabButton {
            text: "Sources"
            ToolTip {
                delay: parseInt(myAppSettings.get_value("delayForToolTipsToAppear"))
                text: "Contains sources which you can add to the entry"
                visible: (parent.hovered || parent.pressed) && String(myAppSettings.get_value("showToolTips")).indexOf("t") !== -1 ? true : false
            }
        }
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Item{
            ScrollView {
                width:parent.width*0.957
                height:parent.height*0.971
                anchors {
                    horizontalCenter : parent.horizontalCenter
                    bottom:parent.bottom
                }
                clip: true

                TextArea {
                    id: textMainWriting
                    enabled: false
                    width:parent.width
                    font.pixelSize: 15
                    text: "Today, ..."
                }

            }
        }

        Item {
            ListView {
                id:listSources
                height: parent.height-(rowOptions.height*1.5)
                anchors {
                    left: parent.left
                    right: parent.right
                }
                model: testModel
                delegate:Row {
                    id:optionsRow
                    height:iconHeight*1.26
                    padding: 5
                    width:listSources.width
                    spacing: 5

                    TextField {
                        id: textNameOfSource
                        width: parent.width - iconWidth * 4
                        height: iconHeight
                        font {
                            pixelSize: 15
                            family: "Calibri"
                            italic: true
                        }
                        placeholderText: "Name of Item!"
                        text: myWriter.getNewSrcName(index)
                        onFocusChanged: {
                            if (focus)
                            {
                                selectAll()
                            }
                        }
                        onTextChanged: {
                            var disallowedChars = ["\\", "/", ":", "*", "?", "\"", "<", ">", "|" ]
                            for (var i = 0; i < disallowedChars.length; i++) {
                                if (text.indexOf(disallowedChars[i]) !== -1) {
                                    text = text.replace(disallowedChars[i], "")
                                }
                            }
                            testModel.setProperty(index, "textName", text);
                        }
                    }

                    ToolButton  {
                        width:iconWidth
                        height:iconHeight
                        id:buttonAttachExternalFolder
                        icon.source: "qrc:/graphics/images/icons/resources/icons/external-folder.svg"
                        FolderDialog {
                            id: folderDialog
                            title: "Select a new source folder for the entry"
                            onAccepted:testModel.setProperty(index, "textSrc", String(currentFolder))
                        }
                        onClicked: folderDialog.open()
                        ToolTip {
                            delay: parseInt(myAppSettings.get_value("delayForToolTipsToAppear"))
                            text: "Can be use to add external folders to the current entry from the device's storage"
                            visible: (parent.hovered || parent.pressed) && String(myAppSettings.get_value("showToolTips")).indexOf("t") !== -1 ? true : false
                        }
                    }

                    ToolButton  {
                        width:iconWidth
                        height:iconHeight
                        id:buttonAttachExternalFile
                        icon.source: "qrc:/graphics/images/icons/resources/icons/external-file.svg"
                        FileDialog {
                            id: fileDialog
                            title: "Select a new source file for the entry"
                            onAccepted:testModel.setProperty(index, "textSrc", String(currentFile))
                        }
                        onClicked: fileDialog.open()
                        ToolTip {
                            delay: parseInt(myAppSettings.get_value("delayForToolTipsToAppear"))
                            text: "Can be used to attach files from the device's file system"
                            visible: (parent.hovered || parent.pressed) && String(myAppSettings.get_value("showToolTips")).indexOf("t") !== -1 ? true : false
                        }
                    }

                    ToolButton  {
                        width:iconWidth
                        height:iconHeight
                        id:buttonDelete
                        icon.source: "qrc:/graphics/images/icons/resources/icons/delete.svg"
                        onClicked:testModel.remove(index)
                        ToolTip {
                            delay: parseInt(myAppSettings.get_value("delayForToolTipsToAppear"))
                            text: "Deletes the source from the entry"
                            visible: (parent.hovered || parent.pressed) && String(myAppSettings.get_value("showToolTips")).indexOf("t") !== -1 ? true : false
                        }
                    }
                }
            }
        }
    }
    footer: Row {
        padding: 5
        id:rowOptions
        anchors {
            left: parent.left
            right: parent.right
            bottom:parent.bottom
        }
        spacing: 5
        ToolButton  {
            id:buttonAddSource
            width:iconWidth
            height:iconHeight
            icon.source: "qrc:/graphics/images/icons/resources/icons/add.svg"
            enabled: false
            onClicked: testModel.append({
                                            textName:"noSourceNameGiven",
                                            textSrc:""
                                        })
            ToolTip {
                delay: parseInt(myAppSettings.get_value("delayForToolTipsToAppear"))
                text: "Adds a new source for you entry"
                visible: (parent.hovered || parent.pressed) && String(myAppSettings.get_value("showToolTips")).indexOf("t") !== -1 ? true : false
            }
        }
        ToolButton  {
            id:buttonStartEntry
            width:iconWidth
            height:iconHeight
            icon.source: "qrc:/graphics/images/icons/resources/icons/start.svg"
            onClicked: {
                buttonSaveEntry.enabled=true
                buttonStartEntry.enabled=false
                buttonAddSource.enabled=true
                textMainWriting.enabled=true
            }
            ToolTip {
                delay: parseInt(myAppSettings.get_value("delayForToolTipsToAppear"))
                text: "Starts today's entry"
                visible: (parent.hovered || parent.pressed) && String(myAppSettings.get_value("showToolTips")).indexOf("t") !== -1 ? true : false
            }
        }
        ToolButton {
            id:buttonSaveEntry
            width:iconWidth
            height:iconHeight
            icon.source: "qrc:/graphics/images/icons/resources/icons/stop.svg"
            enabled: false
            onClicked: {
                var myEmptySourcePathMessage = "";
                var myEmptySourceNameMessage = "";
                var myAmbiguousNamesMessage = "";

                for (var j = 0; j < testModel.count; j++) {
                    for (var k = 0; k < testModel.count; k++) {
                        if (j !== k && testModel.get(j).textName === testModel.get(k).textName) {
                            console.log("Text names are similar:", testModel.get(j).textName)
                            myAmbiguousNamesMessage += String("Item source name is similar with items at index <" + String(j+1) + "> & <" + String(k+1) + "> and the similar name is <" + testModel.get(j).textName + ">\n\n")
                            //                            var tempMessage= String("Item source name is similar with items at index <" + String(j+1) + "> & <" + String(k+1) + "> and the similar name is <" + testModel.get(j).textName + ">\n\n")
                            //                            myAmbiguousNamesMessage += myAmbiguousNamesMessage.indexOf(tempMessage) === -1 ? "" : tempMessage
                        }
                    }
                    if (testModel.get(j).textSrc === "") {
                        myEmptySourcePathMessage += String("Item source path is empty with item name <" + testModel.get(j).textName + "> which is at index <" + String(j+1) + ">\n\n")
                    }
                    if (testModel.get(j).textName === "") {
                        myEmptySourceNameMessage += String("Item source name is empty with item index<" + String(j+1) + ">\n\n")
                    }
                }
                if (myEmptySourcePathMessage + myEmptySourceNameMessage + myAmbiguousNamesMessage === "") {
                    buttonSaveEntry.enabled=false
                    buttonStartEntry.enabled=true
                    buttonAddSource.enabled=false
                    textMainWriting.enabled=false
                    for (var i = 0; i < testModel.count; i++) {
                        myWriter.addSource(testModel.get(i).textName, testModel.get(i).textSrc)
                    }
                    myWriter.finishEntry(textMainWriting.text)
                }
                showError(myEmptySourcePathMessage, "Error: Empty Source Path")
                showError(myEmptySourceNameMessage, "Error: Empty Source Name")
                showError(myAmbiguousNamesMessage, "Error: Ambiguous Source Names")
            }

            ToolTip {
                delay: parseInt(myAppSettings.get_value("delayForToolTipsToAppear"))
                text: "Ends the current entry"
                visible: (parent.hovered || parent.pressed) && String(myAppSettings.get_value("showToolTips")).indexOf("t") !== -1 ? true : false
            }
        }
    }

    ListModel {
        id:testModel
    }

    MessageDialog {
        id: errorDialog
        title: "Error"
        text: "An error occurred."
        buttons: MessageDialog.Ok
        visible: false

        onAccepted: {
            errorDialog.visible = false
        }
    }

    function showError(errorMessageText, errorMessageTitle) {
        if (errorMessageText !== "") {
            errorDialog.text = errorMessageText
            errorDialog.title = errorMessageTitle
            errorDialog.visible = true
        }
    }

}

