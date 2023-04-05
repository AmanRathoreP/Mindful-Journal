import QtQuick
import QtQuick.Controls

Page {
    Label {
        text: "<html><body><h1>Here you will be able to entry you day/week/month etc.</h1></body></html>"
        anchors{
            margins: 20
            left: parent.left
            right: parent.right
        }
        horizontalAlignment: Label.AlignHCenter
        verticalAlignment: Label.AlignVCenter
        wrapMode: Label.Wrap
    }

}
