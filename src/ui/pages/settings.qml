import QtQuick
import QtQuick.Controls

Page {

    Column{
        anchors{
            fill: parent
            margins: 10
        }
        spacing: 10

        CheckBox {
            text: "Show tool tips to user"
            checked: myAppSettings.get_value("showToolTips").indexOf("t") !== -1 ? true : false
            onCheckedChanged: myAppSettings.set_value("showToolTips", checked)
            ToolTip {
                text: "Sets weather to show the tooltips or not"
                visible: parent.hovered || parent.pressed
            }
        }

    }

    footer: Row {
        padding: 5
        anchors {
            left: parent.left
            right: parent.right
            bottom:parent.bottom
        }
        spacing: 5
        ToolButton  {
            width:iconWidth
            height:iconHeight
            icon.source: "qrc:/graphics/images/icons/resources/icons/reset.svg"
            ToolTip {
                delay: parseInt(myAppSettings.get_value("delayForToolTipsToAppear"))
                text: "Resets the app settings to it's default"
                visible: (parent.hovered || parent.pressed) && myAppSettings.get_value("showToolTips").indexOf("t") !== -1 ? true : false
            }
            onClicked: {
                myAppSettings.myFunction()
                dialogConfirmation.open()
            }
            Dialog {
                id: dialogConfirmation

                x: (parent.width - width) / 2
                y: (parent.height - height) / 2
                parent: Overlay.overlay

                title: "Confirmation"
                standardButtons: Dialog.Ok | Dialog.Cancel
                onAccepted: console.log("Ok clicked")
                onRejected: console.log("Cancel clicked")
                Column {
                    spacing: 20
                    anchors.fill: parent
                    Label {
                        text: "This will ensure that all your personal settings are dead"
                    }
                }
            }
        }
        ToolButton  {
            width:iconWidth
            height:iconHeight
            icon.source: "qrc:/graphics/images/icons/resources/icons/save.svg"
            ToolTip {
                delay: parseInt(myAppSettings.get_value("delayForToolTipsToAppear"))
                text: "Saves and apply the current changed settings"
                visible: (parent.hovered || parent.pressed) && myAppSettings.get_value("showToolTips").indexOf("t") !== -1 ? true : false
            }
            onClicked: dialogMessage.open()
            Dialog {
                id: dialogMessage

                x: (parent.width - width) / 2
                y: (parent.height - height) / 2
                parent: Overlay.overlay

                title: "Message"

                Label {
                    text: "Your settings are saved"
                }
            }
        }

    }

}
