import QtQuick
import QtQuick.Controls

Page {

    property var delegateComponentMap: {
        "CheckDelegate": checkDelegateComponent,
        "SliderDelegate": sliderDelegateComponent
    }
    Component {
        id: checkDelegateComponent

        CheckDelegate {
            text: labelText
            anchors{
                left: parent.left
            }
            checked: String(myAppSettings.get_value(settingId)).indexOf("t") !== -1 ? true : false
            onCheckedChanged: myAppSettings.set_value(settingId, checked)
            ToolTip {
                text: toolTipText
                delay: parseInt(myAppSettings.get_value("delayForToolTipsToAppear"))
                visible: (parent.hovered || parent.pressed) && String(myAppSettings.get_value("showToolTips")).indexOf("t") !== -1 ? true : false
            }
        }
    }
    Component {
        id: sliderDelegateComponent

        Slider {
            value: parseInt(myAppSettings.get_value(settingId))
            from: startingPositionOfSlider
            to: endingPositionOfSlider
            onValueChanged: {
                myAppSettings.set_value(settingId, value)
            }
            ToolTip {
                text: toolTipText
                delay: parseInt(myAppSettings.get_value("delayForToolTipsToAppear"))
                visible: (parent.hovered || parent.pressed) && String(myAppSettings.get_value("showToolTips")).indexOf("t") !== -1 ? true : false
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
            ListElement { type: "CheckDelegate";
                labelTextToDisplay: "Make Tool Tips visible";
                toolTipTextToDisplay: "This is a tool tip";
                textOfSetting: "showToolTips" }

            ListElement { type: "SliderDelegate";
                labelTextToDisplay: "Delay for the tool tip to appear";
                toolTipTextToDisplay: "Inquires the duration of the delay after which the tool tip is expected to appear";
                textOfSetting: "delayForToolTipsToAppear";
                sliderStartingValue: 0;
                sliderEndingValue: 1000
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
                visible: (parent.hovered || parent.pressed) && String(myAppSettings.get_value("showToolTips")).indexOf("t") !== -1 ? true : false
            }
            onClicked: dialogMessage.open()
            Dialog {
                id: dialogMessage

                x: (parent.width - width) / 2
                y: (parent.height - height) / 2
                parent: Overlay.overlay

                title: "Message"

                Label {
                    text: "Your settings are saved\nPlease restart the app in order to see chages"
                }
            }
        }

    }

}
