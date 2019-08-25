import QtQuick 2.0
import QtQuick.Controls 2.12
Page{
    title: qsTr("Binary")
    Column{
        id: column
        anchors.centerIn: parent
        spacing: 10
        Button{
            text: "Add New..."
            background: Rectangle{
                id: rect1
                color: "#0080FF"
                border.color: Qt.lighter(color)
                width: column.width

            }
            contentItem: Text {
                text: qsTr("Add new")
                styleColor: Qt.lighter(color)
                font.bold: true
                font.pixelSize: 15
                color: "white"
                anchors.centerIn: rect1
            }
            onClicked: {
                stackView.push("Add.qml")
            }
        }
        Button{
            text: "View Tasks..."
            background: Rectangle{
                id: rect2
                color: "#0080FF"
                width: column.width
                border.color: Qt.lighter(color)
            }
            contentItem: Text {
                text: qsTr("View Tasks")
                color: "white"
                styleColor: Qt.lighter(color)
                font.bold: true
                font.pixelSize: 15
                anchors.centerIn: rect2
            }
            onClicked: {
                stackView.push("Tasks.qml")
            }
        }
    }
}

