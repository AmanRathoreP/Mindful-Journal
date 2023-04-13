import QtQuick
import QtQuick.Controls

Page {

    property int iconHeight: 42
    property int iconWidth: 42

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
            }

            ToolButton  {
                width:iconWidth
                height:iconHeight
                id:buttonAttachExternalFile
                icon.source: "qrc:/graphics/images/icons/resources/icons/external-file.svg"
                onClicked: console.log("External files add clicked")
            }

            ToolButton  {
                width:iconWidth
                height:iconHeight
                id:buttonDelete
                icon.source: "qrc:/graphics/images/icons/resources/icons/delete.svg"
                onClicked:console.log("Remove clicked")
            }
        }
    }

    Row {
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
            width:iconWidth * 1.5
            height:iconHeight * 1.5
            icon.source: "qrc:/graphics/images/icons/resources/icons/add.svg"
            onClicked: testModel.append({})
        }
        ToolButton  {
            id:buttonStartEntry
            width:iconWidth * 1.5
            height:iconHeight * 1.5
            icon.source: "qrc:/graphics/images/icons/resources/icons/start.svg"
            onClicked: {
                buttonSaveEntry.enabled=true
                buttonStartEntry.enabled=false
            }
        }
        ToolButton {
            id:buttonSaveEntry
            width:iconWidth * 1.5
            height:iconHeight * 1.5
            icon.source: "qrc:/graphics/images/icons/resources/icons/stop.svg"
            enabled: false
            onClicked: {
                buttonSaveEntry.enabled=false
                buttonStartEntry.enabled=true
            }
        }
    }

    ListModel {
        id:testModel

        ListElement{}
    }
}

