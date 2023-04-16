import QtQuick
import QtQuick.Controls

Page {

    header: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: "Raw Edit"
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
                        width: parent.width - iconWidth * 4
                        height:buttonRecord.height
                        font {
                            pixelSize: 15
                            family: "Calibri"
                            italic: true
                        }
                        placeholderText: "Name of Item!"
                        onFocusChanged: {
                            if (focus)
                            {
                                selectAll()
                            }
                        }
                    }

                    ToolButton  {
                        width:iconWidth
                        height:iconHeight
                        id:buttonRecord
                        icon.source: "qrc:/graphics/images/icons/resources/icons/record.svg"
                        onClicked: console.log("Record clicked")
                        ToolTip {
                            delay: parseInt(myAppSettings.get_value("delayForToolTipsToAppear"))
                            text: "Can be use to record the live audio from the current default mic of the device"
                            visible: (parent.hovered || parent.pressed) && String(myAppSettings.get_value("showToolTips")).indexOf("t") !== -1 ? true : false
                        }
                    }

                    ToolButton  {
                        width:iconWidth
                        height:iconHeight
                        id:buttonAttachExternalFile
                        icon.source: "qrc:/graphics/images/icons/resources/icons/external-file.svg"
                        onClicked: console.log("External files add clicked")
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
                        onClicked:console.log("Remove clicked")
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
            onClicked: testModel.append({})
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
                buttonSaveEntry.enabled=false
                buttonStartEntry.enabled=true
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
        ListElement{}
    }
}

