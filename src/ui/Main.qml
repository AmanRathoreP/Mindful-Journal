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

    Shortcut {
        sequences: ["Esc", "Back"]
        enabled: stackView.depth > 1
        onActivated: navigateBackAction.trigger()
    }

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
                icon.source: stackView.depth > 1 ? "qrc:/graphics/images/icons/resources/icons/back.svg" : "qrc:/graphics/images/icons/resources/icons/menu.svg"
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
                icon.source: "qrc:/graphics/images/icons/resources/icons/dot-stack.svg"
                action:optionsMenuAction

                Menu {
                    id: optionsMenu
                    x: parent.width - width
                    transformOrigin: Menu.TopRight

                    Action {
                        text: "Help"
                        icon.source: "qrc:/graphics/images/icons/resources/icons/help.svg"
                        onTriggered:Qt.openUrlExternally("https://github.com/AmanRathoreP/Mindful-Journal")
                    }
                    Action {
                        text: "About"
                        icon.source: "qrc:/graphics/images/icons/resources/icons/about.svg"
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
        initialItem: Qt.createComponent("./pages/home.qml")
    }

    Dialog {
        id: aboutDialog
        modal: true
        title: "About"
        x: (window.width - width) / 2
        y: (window.height - height) / 2
        width: Math.min(window.width, window.height) / 3 * 2
        contentHeight: imageLogo.height * 2
        parent: Overlay.overlay

        standardButtons: Dialog.Close

        Flickable {
            id: flickable
            clip: true
            anchors.fill: parent
            contentHeight: aboutColumn.height

            Column {
                id: aboutColumn
                spacing: 20
                width: parent.width

                Image {
                    id: imageLogo
                    width: parent.implicitWidth / 2
                    anchors.horizontalCenter: parent.horizontalCenter
                    fillMode: Image.PreserveAspectFit
                    source: "qrc:/graphics/images/for-app/resources/images/journal.svg"
                }

                Label {
                    width: parent.width
                    text: "This apps provides user to write it's personal diary weather in the form of text or in the form of audio or whatever!"
                    wrapMode: Label.Wrap
                }

                Button{
                    text :"About author"
                    icon.source: "qrc:/graphics/images/icons/resources/icons/author.svg"
                    onClicked: Qt.openUrlExternally("https://github.com/AmanRathoreP/AmanRathoreP")
                    ToolTip {
                        delay: parseInt(myAppSettings.get_value("delayForToolTipsToAppear"))
                        text: "The author of this app is Aman whose GitHub user name is \"AmanRathoreP\""
                        visible: (parent.hovered || parent.pressed) && String(myAppSettings.get_value("showToolTips")).indexOf("t") !== -1 ? true : false
                    }
                }
            }

            ScrollIndicator.vertical: ScrollIndicator {
                parent: aboutDialog.contentItem
                anchors.top: flickable.top
                anchors.bottom: flickable.bottom
                anchors.right: parent.right
                anchors.rightMargin: -aboutDialog.rightPadding + 1
            }
        }
    }
}
