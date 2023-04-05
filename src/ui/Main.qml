import QtCore
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material


ApplicationWindow {
    id: window
    width: 360
    height: 520
    visible: true
    title: "Mindful Journal"
    Material.theme: Material.Dark
//    Material.accent: Material.Lime

    Action {
        id: navigateBackAction
        onTriggered: {
            if (stackView.depth > 1) {
                stackView.pop()
                listView.currentIndex = -1
            } else {
                drawer.open()
            }
        }
    }


    Action {
        id: optionsMenuAction
        onTriggered: optionsMenu.open()
    }

    header: ToolBar {
        RowLayout {
            spacing: 20
            anchors.fill: parent

            ToolButton {
                icon.source: stackView.depth > 1 ? "https://www.svgrepo.com/show/238203/backward.svg" : "https://www.svgrepo.com/show/509382/menu.svg"
                action: navigateBackAction
            }

            Label {
                id: titleLabel
                text: listView.currentItem ? listView.currentItem.text : "Home Screen"
                font.pixelSize: 20
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

            ToolButton {
                icon.source: "https://www.svgrepo.com/show/452277/dot-stack.svg"
                action:optionsMenuAction

                Menu {
                    id: optionsMenu
                    x: parent.width - width
                    transformOrigin: Menu.TopRight

                    Action {
                        text: "Help"
                        onTriggered:Qt.openUrlExternally("https://github.com/AmanRathoreP/Mindful-Journal")
                    }
                    Action {
                        text: "About"
                        onTriggered: aboutDialog.open()
                    }
                }
            }
        }
    }

    Drawer {
        id: drawer
        width: Math.min(window.width, window.height) / 3 * 2
        height: window.height
        interactive: stackView.depth === 1

        ListView {
            id: listView

            focus: true
            currentIndex: -1
            anchors.fill: parent

            delegate: ItemDelegate {
                width: listView.width
                text: model.title
                highlighted: ListView.isCurrentItem
                onClicked: {
                    listView.currentIndex = index
                    stackView.push(Qt.createComponent(model.source))
                    drawer.close()
                }
            }

            model: ListModel {
                ListElement { title: "App settings"; source: "./pages/settings.qml" }
            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: Pane {
            id: pane
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
    }



    Dialog {
        id: aboutDialog
        modal: true
        focus: true
        title: "About"
        x: (window.width - width) / 2
        y: window.height / 6
        width: Math.min(window.width, window.height) / 3 * 2
        contentHeight: aboutColumn.height

        Column {
            id: aboutColumn
            spacing: 20

            Label {
                width: aboutDialog.availableWidth
                text: "This apps provides user to write it's personal diary weather in the form of text or in the form of audio or whatever!"
                wrapMode: Label.Wrap
                font.pixelSize: 24
            }
        }
    }

}
