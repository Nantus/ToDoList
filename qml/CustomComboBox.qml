import QtQuick 2.5
import QtQuick.Controls 2.2

ComboBox {
    width: root.width/2 - 10
    height: 40

    model: ["All", "In progress", "Done"]

    delegate: ItemDelegate {
        width: parent.width
        contentItem: Text {
            id: main_txt
            text: modelData
            color: text_color
            font.pointSize: 12
        }

        background: Rectangle { color: highlighted ? background_entered_color : background_color; radius: 17}

        highlighted: combo_box.highlightedIndex == index
    }

    onActivated: {
        ToDoModel.changeFilterMode(model[highlightedIndex])
    }

    contentItem: Rectangle {
        anchors.fill:parent
        anchors.leftMargin: 10
        anchors.topMargin: 9
        color: "transparent"

        Text {
            anchors.top: parent.top
            text: combo_box.displayText
            font.pointSize: 14
            color: text_color
        }
    }

    background: Rectangle {
        color: background_color
        implicitWidth: 120
        implicitHeight: 40
        border.color: text_color
        radius: 17
    }

    popup: Popup {
        y: combo_box.height + 1
        width: combo_box.width
        implicitHeight: contentItem.implicitHeight + 5

        padding: 1

        contentItem: ListView {
            clip: true
            interactive: false
            implicitHeight: contentHeight
            model: combo_box.popup.visible ? combo_box.delegateModel :  null
            currentIndex: combo_box.highlightedIndex

            ScrollIndicator.vertical: ScrollIndicator {}
        }

        background: Rectangle {
            color: background_color
            border.color: text_color
            radius: 17
        }
    }
}