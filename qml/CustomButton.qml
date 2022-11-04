import QtQuick 2.5
import QtQuick.Controls 2.2

Rectangle {
    id: rect

    width: 80
    height: 30

    radius: 17
    color: background_color
    border.color: text_color
    border.width: 1

    property string button_text: ""

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        text: button_text
        font.pointSize: 12
	    color: text_color
	}

	MouseArea {
	    id: mouse_area
	    anchors.fill: parent
	    hoverEnabled: true

		onEntered: {
		    parent.color = background_entered_color
		}

		onExited: {
		    parent.color = background_color
	    }
    }
}