import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

Page {

    property var delegateComponentMap: {
        "CheckDelegate": checkDelegateComponent,
        "SliderDelegate": sliderDelegateComponent,
        "SwitchDelegate": switchDelegateComponent,
        "TextFieldDelegate": textFieldDelegateComponent,
        "DialogFolderPathDelegate": dialogFolderPathDelegateComponent
    }

    Component {
        id: dialogFolderPathDelegateComponent

        ItemDelegate {
            text: labelText
            anchors{
                left: parent.left
                right: parent.right
            }
            onClicked: folderDialogOfSettings.open()
            ToolTip {
                text: toolTipText
                delay: parseInt(myAppSettings.get_value("delayForToolTipsToAppear"))
                visible: (parent.hovered || parent.pressed) && String(myAppSettings.get_value("showToolTips")).indexOf("t") !== -1 ? true : false
            }
        }
    }

    Component {
        id: textFieldDelegateComponent

        Column{
            Rectangle{
                anchors{
                    left:parent.left
                    right:parent.right
                }
                height: 5
            }

            TextField {
                placeholderText: labelText
                text: String(myAppSettings.get_value(settingId))
                anchors{
                    left:parent.left
                    right:parent.right
                }
                onTextChanged:{
                    var disallowedChars = ["\\", "/", ":", "*", "?", "\"", "|"]
                    for (var i = 0; i < disallowedChars.length; i++) {
                        if (text.indexOf(disallowedChars[i]) !== -1) {
                            text = text.replace(disallowedChars[i], "")
                        }
                    }
                    labelRestartText.visible = (text === String(myAppSettings.get_value(settingId)) ? false : restartTextVisibility) || labelRestartText.visible
                    myAppSettings.set_value(settingId, text)
                }
                ToolTip {
                    text: toolTipText
                    delay: parseInt(myAppSettings.get_value("delayForToolTipsToAppear"))
                    //                visible: (parent.hovered || parent.pressed) && String(myAppSettings.get_value("showToolTips")).indexOf("t") !== -1 ? true : false
                    visible: ( parent.hovered) && String(myAppSettings.get_value("showToolTips")).indexOf("t") !== -1 ? true : false
                }
            }
        }
    }

    Component {
        id: checkDelegateComponent

        CheckDelegate {
            text: labelText
            anchors{
                left: parent.left
            }
            checked: String(myAppSettings.get_value(settingId)).indexOf("t") !== -1 ? true : false
            onCheckedChanged:{
                labelRestartText.visible = (checked === (String(myAppSettings.get_value(settingId)).indexOf("t") !== -1 ? true : false) ? false : restartTextVisibility) || labelRestartText.visible
                myAppSettings.set_value(settingId, checked)
            }
            ToolTip {
                text: toolTipText
                delay: parseInt(myAppSettings.get_value("delayForToolTipsToAppear"))
                visible: (parent.hovered || parent.pressed) && String(myAppSettings.get_value("showToolTips")).indexOf("t") !== -1 ? true : false
            }
        }
    }

    Component {
        id: switchDelegateComponent

        SwitchDelegate {
            text: labelText
            anchors{
                left: parent.left
            }
            checked: String(myAppSettings.get_value(settingId)).indexOf("t") !== -1 ? true : false
            onCheckedChanged: {
                labelRestartText.visible = (checked === (String(myAppSettings.get_value(settingId)).indexOf("t") !== -1 ? true : false) ? false : restartTextVisibility) || labelRestartText.visible
                myAppSettings.set_value(settingId, checked)
            }
            ToolTip {
                text: toolTipText
                delay: parseInt(myAppSettings.get_value("delayForToolTipsToAppear"))
                visible: (parent.hovered || parent.pressed) && String(myAppSettings.get_value("showToolTips")).indexOf("t") !== -1 ? true : false
            }
        }
    }

    Component {
        id: sliderDelegateComponent

        Column{
            Label {
                text: labelText
            }
            Slider {
                value: parseInt(myAppSettings.get_value(settingId))
                from: startingPositionOfSlider
                to: endingPositionOfSlider
                anchors{
                    left:parent.left
                    right:parent.right
                }

                onValueChanged: {
                    labelRestartText.visible = (value === parseInt(myAppSettings.get_value(settingId)) ? false : restartTextVisibility) || labelRestartText.visible
                    myAppSettings.set_value(settingId, value)
                }
                ToolTip {
                    text: toolTipText
                    delay: parseInt(myAppSettings.get_value("delayForToolTipsToAppear"))
                    visible: (parent.hovered || parent.pressed) && String(myAppSettings.get_value("showToolTips")).indexOf("t") !== -1 ? true : false
                }
            }
        }
    }

    ListView {
        id: listView
        anchors{
            top:parent.top
            left:parent.left
            right:parent.right
            margins: 10
        }
        height: parent.height - rowFooter.height

        clip:true

        model: ListModel {
            ListElement { type: "SwitchDelegate";
                labelTextToDisplay: "Tool Tips";
                toolTipTextToDisplay: "This is a tool tip";
                textOfSetting: "showToolTips"
            }

            ListElement { type: "SliderDelegate";
                labelTextToDisplay: "Delay for the tool tip to appear";
                toolTipTextToDisplay: "Inquires the duration of the delay after which the tool tip is expected to appear";
                textOfSetting: "delayForToolTipsToAppear";
                sliderStartingValue: 0;
                sliderEndingValue: 1000;
                restartRequired: true
            }

            ListElement { type: "TextFieldDelegate";
                labelTextToDisplay: "New Item adding format";
                toolTipTextToDisplay: "<html><body>Provides the format in which the new item name will come<br><div>dd.MM.yyyy	21.05.2001<br>ddd MMMM d yy	Tue May 21 01<br>hh:mm:ss.zzz14:13:09.120<br>hh:mm:ss.z	14:13:09.12<br>h:m:s ap	2:13:9 pm</div></body></html>";
                textOfSetting: "newItemAddingFormat";
                restartRequired: true
            }

            ListElement { type: "DialogFolderPathDelegate";
                labelTextToDisplay: "Choose Entries directory";
                toolTipTextToDisplay: "Sets the directory where all your entries are saved";
                textOfSetting: "pathOfFolderForEntry";
                restartRequired: true
            }

            ListElement { type: "SwitchDelegate";
                labelTextToDisplay: "Detailed Info. in Entry";
                toolTipTextToDisplay: "Enable if you want to use a special type of entry format provided by the author";
                textOfSetting: "useDetailedFormatForEntry";
                restartRequired: true
            }
        }

        section.property: "type"
        section.delegate: Pane {
            width:listView.width > 550 ? 550 : listView.width
            height: 20
        }

        delegate: Loader {
            id: delegateLoader
            width:listView.width > 550 ? 550 : listView.width
            sourceComponent: delegateComponentMap[type]

            property string labelText: labelTextToDisplay
            property string toolTipText: toolTipTextToDisplay
            property string settingId: textOfSetting
            property int startingPositionOfSlider: sliderStartingValue
            property int endingPositionOfSlider: sliderEndingValue
            property bool restartTextVisibility: restartRequired
            property ListView view: listView
            property int ourIndex: index
        }
    }

    footer: Row {
        id: rowFooter
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
                visible: (parent.hovered || parent.pressed) && String(myAppSettings.get_value("showToolTips")).indexOf("t") !== -1 ? true : false
            }
            onClicked: dialogConfirmation.open()
            Dialog {
                id: dialogConfirmation

                x: (parent.width - width) / 2
                y: (parent.height - height) / 2
                parent: Overlay.overlay

                title: "Confirmation"
                standardButtons: Dialog.Ok | Dialog.Cancel
                onAccepted: {
                    myAppSettings.reset_settings()
                    Qt.quit()
                }
                onRejected: console.log("Cancel clicked")
                Column {
                    spacing: 20
                    anchors.fill: parent
                    Label {
                        text: "Ensures that all your personal settings are dead\nThis also kills the current instance of the app"
                    }
                }
            }
        }

        Label {
            id: labelRestartText
            text: "Restart required"
            font.pixelSize: iconHeight*0.4

            color: "#e41e25"
            visible: false
        }

    }

    FolderDialog {
        id: folderDialogOfSettings
        title: "Select the directory to save all entries"
        onAccepted: myAppSettings.set_value("pathOfFolderForEntry", String(currentFolder))
    }

}
