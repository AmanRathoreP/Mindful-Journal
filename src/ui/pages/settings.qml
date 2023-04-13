import QtQuick
import QtQuick.Controls

Page {
    //TODO: add a option for weather to put tooltips or not for the components
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
