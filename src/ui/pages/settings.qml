import QtQuick
import QtQuick.Controls

Page {
    Label {
        text: "<html><h1>This is the settings panel for the app!</h1></html>"
        anchors{
            top:parent.top
            right:parent.right
            left: parent.left
        }                horizontalAlignment: Label.AlignHCenter
        verticalAlignment: Label.AlignVCenter
        wrapMode: Label.Wrap
    }
}
