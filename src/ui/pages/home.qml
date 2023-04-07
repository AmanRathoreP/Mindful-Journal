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

            TextArea {
                width: parent.width - buttonWrite.width *4
                height:buttonRecord.height
                font {
                    pixelSize: 25
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

            Button {
                width:iconWidth
                height:iconHeight
                id:buttonRecord
                icon.source: "https://www.svgrepo.com/show/498929/record.svg"
                onClicked: console.log("Record clicked")
            }

            Button {
                width:iconWidth
                height:iconHeight
                id:buttonWrite
                icon.source: "https://www.svgrepo.com/show/489638/type.svg"
                onClicked: console.log("Edit clicked")
            }

            Button {
                width:iconWidth
                height:iconHeight
                id:buttonDelete
                icon.source: "https://www.svgrepo.com/show/511788/delete-1487.svg"
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
        Button {
            id:buttonAddSource
            width:iconWidth
            height:iconHeight
            icon.source: "https://www.svgrepo.com/show/513800/add-square.svg"
            onClicked: testModel.append({})
        }
        Button {
            id:buttonStartEntry
            width:iconWidth
            height:iconHeight
            icon.source: "https://www.svgrepo.com/show/500138/animation-play.svg"
            onClicked: {
                buttonSaveEntry.enabled=true
                buttonStartEntry.enabled=false
            }
        }
        Button {
            id:buttonSaveEntry
            width:iconWidth
            height:iconHeight
            icon.source: "https://www.svgrepo.com/show/500137/animation-stop.svg"
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

