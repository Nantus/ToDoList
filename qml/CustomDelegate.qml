import QtQuick 2.5
import QtQuick.Controls 2.2

Component {
    id: dragDelegate

    Rectangle {
        id: component_rectangle
        property string image_true_source: "./../images/checkbox_true.png"
        property string image_false_source: "./../images/checkbox_false.png"

        height: 80
        width: parent.width

        anchors {
            left: parent.left
            right: parent.right
            leftMargin: 10
            rightMargin: 10
        }

        color: "transparent"
        radius: 2

        MouseArea {
            anchors.fill: parent
            onClicked: {
                list_view.currentIndex = index

                edit_name_text_field.text = Name
                edit_date_text_field.text = Date
                edit_description_text_field.text = Description
                edit_button.currentItemId = Id
            }
        }

        Column {
            id: column
            anchors {
                fill: parent
                topMargin: 10
            }

            Text {
                text: "Name: " + Name;
                color: "white"
                font.pointSize: 12
            }

            Text {
                text: "Date: " + Date;
                color: "white"
                font.pointSize: 12
            }

            Text {
                text: "Description: " + Description;
                color: "white"
                font.pointSize: 12
            }
        }

        Image {
            property bool isChecked: false

            width: 30
            height: 30

            anchors {
                top: parent.top
                right: parent.right
                topMargin: 20
                rightMargin: 20
            }

            fillMode: Image.Stretch
            source: IsDone ? image_true_source : image_false_source
            mipmap: true

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    parent.isChecked = !parent.isChecked

                    if(parent.isChecked)
                        parent.source = image_true_source
                    else
                        parent.source = image_false_source

                    ToDoModel.setDone(index, parent.isChecked)
                }
            }
        }
    }
}