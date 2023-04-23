import QtQuick
import QtQuick.Controls

Page {

    property var delegateComponentMap: {
        "CheckDelegate": checkDelegateComponent,
        "SliderDelegate": sliderDelegateComponent,
        "SwitchDelegate": switchDelegateComponent,
        "TextFieldDelegate": textFieldDelegateComponent
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
                toolTipTextToDisplay: "Provides the format in which the new item name will come";
                textOfSetting: "newItemAddingFormat";
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

}
