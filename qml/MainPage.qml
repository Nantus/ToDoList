import QtQuick 2.5
import QtQuick.Controls 2.2

Rectangle {
	id: root
	width: 650
	height: 700
	color: background_color

    property color background_color: "#2a2a2a"
    property color background_entered_color: "#555555"
	property color text_field_background_color: "#3b3b3b"
	property color text_field_text_color: "#535353"
	property color text_field_wrong_input: "#5e091a"
	property color text_color: "#59ca96"

	Column {
	    id: add_column

        anchors {
            top: root.top
            left: root.left
            topMargin: 8
            leftMargin: 8
        }
		spacing: 8

		Text {
		    id: id_text

		    height: 20
		    anchors.horizontalCenter: parent.horizontalCenter

			text: "<b>To Do</b>"
			color: text_color
			font.pointSize: 14
		}

        CustomComboBox {
            id: combo_box
        }

		ListView {
		    id: list_view

		    width: root.width/2 - 10
		    height: root.height - id_text.height - combo_box.height - 3*name_text_field.height - add_button.height - 80

		    model: ToDoModel
		    snapMode: ListView.SnapToItem
            delegate: CustomDelegate {}
            clip: true
            //focus: true

            highlight: Rectangle {
                border.color: text_color
                color: "transparent"
                radius: 14
            }

            onActiveFocusChanged: {
                console.log("changed")
            }
		}

		CustomTextField {
		    id: name_text_field

		    height: 30
            width: root.width/2 - 20
            anchors.left: add_column.left

		    placeholderText: "Name"
		}

        CustomTextField {
		    id: date_text_field

		    height: 30
            width: root.width/2 - 20
            anchors.left: add_column.left

			placeholderText: "Date"
		}

        CustomTextField {
		    id: description_text_field

		    height: 30
            width: root.width/2 - 20
            anchors.left: add_column.left

			placeholderText: "Description"
		}

	    CustomButton {
	        id: add_button

            anchors.horizontalCenter: add_column.horizontalCenter

	        button_text: "Add"

	        MouseArea {
	            anchors.fill: add_button

	            onClicked: {
		            if(name_text_field.text == "")
		                name_text_field.background.color = text_field_wrong_input

                    if(date_text_field.text == "")
		                date_text_field.background.color = text_field_wrong_input

		            if(description_text_field.text == "")
		                description_text_field.background.color = text_field_wrong_input

                    if(name_text_field.text != "" &&
                       date_text_field.text != "" &&
                       description_text_field.text != "")
                    {
		                ToDoModel.addTask(name_text_field.text, date_text_field.text, description_text_field.text)
		                name_text_field.clear()
		                date_text_field.clear()
		                description_text_field.clear()
		            }
		        }
	        }
	     }
    }

    Rectangle{
        id: popup_rect

        anchors {
            left: add_column.right
            right: root.right
            top: parent.top
        }

        Popup {
            id: popup_edit
            width: root.width/2 - 10
            height: 200
            padding: 8

            background: Rectangle {
                anchors.fill: parent
                color: background_color
            }

            contentItem: Column{
                spacing: 8

                Text {
		            id: edit_text

		            height: 20
		            anchors.horizontalCenter: parent.horizontalCenter

			        text: "<b>Edit Task</b>"
			        color: text_color
			        font.pointSize: 14
		        }

                CustomTextField {
	                id: edit_name_text_field

		            height: 30
                    width: root.width/2 - 20

		            placeholderText: "Edit name"
		        }

		        CustomTextField {
		            id: edit_date_text_field

		            height: 30
                    width: root.width/2 - 20

		            placeholderText: "Edit date"
		        }

		        CustomTextField {
		            id: edit_description_text_field

		            height: 30
                    width: root.width/2 - 20

        		    placeholderText: "Edit description"
		        }

                CustomButton {
                    id: edit_button

                    anchors.horizontalCenter: parent.horizontalCenter

                    property int currentItemId: 0

                    button_text: "Edit task"

                    MouseArea{
                        anchors.fill: parent

                        onClicked: {
	                        if(edit_name_text_field.text == ""){
		                        edit_name_text_field.background.color = text_field_wrong_input
		                    }

                            if(edit_date_text_field.text == ""){
		                        edit_date_text_field.background.color = text_field_wrong_input
		                    }

		                    if(edit_description_text_field.text == ""){
		                        edit_description_text_field.background.color = text_field_wrong_input
		                    }

                            if(edit_name_text_field.text != "" &&
                               edit_date_text_field.text != "" &&
                               edit_description_text_field.text != "")
                            {
		                        ToDoModel.editTask(edit_button.currentItemId, edit_name_text_field.text, edit_date_text_field.text, edit_description_text_field.text)
                                //list_view.itemAtIndex(list_view.currentIndex).Name = edit_name_text_field.text
                                //console.log(ToDoModel.editData())
		                        name_text_field.clear()
		                        date_text_field.clear()
		                        description_text_field.clear()
		                    }
		                }
                    }
                }
		    }
		}
    }
}
