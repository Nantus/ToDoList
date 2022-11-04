import QtQuick 2.5
import QtQuick.Controls 2.2

TextField {
    placeholderTextColor: text_field_text_color
    font.pointSize: 13
    color: "white"
    selectByMouse: true

    background: Rectangle {
	    color: text_field_background_color
	    radius: 17
    }

    onActiveFocusChanged: {
        if(activeFocus)
            background.color = text_field_background_color
    }
}
