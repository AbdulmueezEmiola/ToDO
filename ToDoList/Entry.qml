import QtQuick 2.0
import QtQuick.Controls 2.12
Item {
    id: root
    property alias text: text.text
    property alias checker:plusText.text
    height: 30
    signal clicked
    Rectangle{
        height: parent.height
        anchors.fill: parent
        width: parent.width
        color: "#0080FF"
        Text {
            id: text
            text: qsTr("text")
            color: "white"
            font.capitalization: Font.AllUppercase
            font.pixelSize: 15
            anchors.margins: 5
            styleColor: Qt.lighter(color)
            style: Text.Raised
            anchors.left: parent.left
            elide: Text.ElideRight
            anchors.verticalCenter: parent.verticalCenter
        }
        Button{
            height: parent.height
            width: parent.height
            anchors.right: parent.right
            anchors.margins: 5
            background: Rectangle{
                color: "#0080FF"
            }
            Text{
                id: plusText
                font.bold: true
                style: Text.Outline
                font.pixelSize: 25
                styleColor: Qt.lighter(color)
                anchors.centerIn: parent
                text: "+"
                color: "white"
            }
            onClicked:{
                plusText.text = (plusText.text=="+")?"-":"+"
                root.clicked()
            }
        }
    }
}
