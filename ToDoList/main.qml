import QtQuick 2.12
import QtQuick.Controls 2.12
ApplicationWindow {
    id: root
    visible: true   
    width: 320
    height: 480
    title: qsTr("Hello World")
    header: ToolBar{
        contentHeight: label.implicitHeight
        background: Rectangle{
            color: "#0080FF"
        }
        ToolButton{
            id: tool
            icon.source: stackView.depth>1?"md-arrow-round-back.svg":""
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                if(stackView.depth >1){
                    stackView.pop()
                }
            }
        }
        Label{
            id: label
            text: stackView.currentItem.title
            anchors.centerIn: parent
            font.family: "cursive"
            bottomPadding: 5
            font.pixelSize: 25
            style: Text.Raised
            styleColor: Qt.lighter(color)
            font.bold: true
            color: "white"
        }
    }
    StackView{
        id: stackView
        anchors.fill: parent
        anchors.margins: 5
        initialItem: Home{}
    }
}
