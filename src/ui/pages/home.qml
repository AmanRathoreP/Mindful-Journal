import QtQuick
import QtQuick.Controls

Page {
    Row {
        id:optionsRow
        anchors {
            left: parent.left
            right: parent.right
        }
        spacing: 5

        TextArea {
            width: parent.width - buttonWrite.width *4
            height:buttonRecord.height

            font{
                pixelSize: 20
                family: "Calibri"
                italic: true
            }

            text: "Name of item!"
            onFocusChanged: {
                if (focus) {
                    selectAll()
                }
            }
        }

        Button {
            id:buttonRecord
            icon.source: "https://www.svgrepo.com/show/498929/record.svg"
            onClicked: console.log("Record clicked")
        }

        Button {
            id:buttonWrite
            icon.source: "https://www.svgrepo.com/show/489638/type.svg"
            onClicked: console.log("Edit clicked")
        }

        Button {
            id:buttonDelete
            icon.source: "https://www.svgrepo.com/show/511788/delete-1487.svg"
            onClicked: console.log("Remove clicked")
        }
    }
}
