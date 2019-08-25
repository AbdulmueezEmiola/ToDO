import QtQuick 2.6
import QtQml 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import org.example 1.0
Page{
    title: qsTr("Edit")  
    id: root
    property string time
    property string important
    property var indexNo
    property alias  text: titleInput.text
    property alias  date: dateSelect.text
    property alias time: root.time
    property alias note: noteInput.text
    property alias important: root.important
    property alias index: root.indexNo

    Column{
        anchors.fill: parent
        spacing: 10
        anchors.margins: 5
        Row{
            width: parent.width
            spacing: 10
            Text {
                id: titleText
                text: qsTr("Title ")
                font.pixelSize: 20
                styleColor: Qt.lighter(color)
                font.weight: Font.DemiBold
                color: "black"
            }
            Rectangle{
                border.color: "white"
                width: parent.width - titleText.width-20
                height: parent.height
                Label{
                    id: titleInput
                    font.pixelSize: 20
                    anchors.fill: parent
                    verticalAlignment: TextInput.AlignVCenter
                    leftPadding: 5
                    clip: true                    
                }
            }
        }
        Row{
            width: parent.width
            spacing: 10
            Text {
                id: dateText
                text: qsTr("Date ")
                font.pixelSize: 20
                styleColor: Qt.lighter(color)
                font.weight: Font.DemiBold
                color: "black"
            }
            Rectangle{
                id: dateRect
                border.color: "black"
                height: parent.height
                width: 90
                color: "lightgrey"
                Text{
                    id: dateSelect
                    text: Qt.formatDate(date,"dd:MM:yyyy")
                    color: "black"
                    anchors.centerIn: parent
                    font.pixelSize: 15
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        popup.open()
                    }
                }
            }
        }
        Row{
            width: parent.width
            spacing: 5            

            Text {
                id: timeText
                text: qsTr("Time ")
                font.pixelSize: 20
                styleColor: Qt.lighter(color)
                font.weight: Font.DemiBold
                color: "black"
            }
            Combo{
                id: hourInput
                width: (parent.width-timeText.width-15)/3
                model:11
                Component.onCompleted: {
                    var date = Date.fromLocaleString(Qt.locale(),time,"hh:mm")
                    var hour = date.getHours()%12;
                    if(find(hour+'')!== -1){
                        hourInput.currentIndex = find(hour+'')
                    }
                }
            }
            Combo{
                id: minuteInput
                width: (parent.width-timeText.width-15)/3
                model:60
                Component.onCompleted: {
                    var date = Date.fromLocaleString(Qt.locale(),time,"hh:mm")
                    var minute = date.getMinutes();
                    if(find(minute+'')!==-1){
                        minuteInput.currentIndex = find(minute+'')
                    }
                }
            }
            Combo{
                id: timeInput
                width: (parent.width-timeText.width-15)/3
                model:ListModel{
                    ListElement{
                        text: "AM"
                    }
                    ListElement{
                        text: "PM"
                    }
                    Component.onCompleted: {
                        var date = Date.fromLocaleString(Qt.locale(),time,"hh:mm")
                        timeInput.currentIndex = date.getHours()>12?1:0
                    }
                }
            }
        }
        Text {
            id: noteText
            text: qsTr("Note ")
            font.pixelSize: 20
            styleColor: Qt.lighter(color)
            font.weight: Font.DemiBold
            color: "black"
        }
        Rectangle{
            width: parent.width
            height: root.height/4
            border.color: "black"
            TextEdit{
                id: noteInput
                anchors.fill: parent
                wrapMode: Text.Wrap
                clip: true
                leftPadding: 5
            }
        }
        Row{
            width: parent.width
            spacing: 10
            Text {
                id: importantText
                text: qsTr("Important ")
                font.pixelSize: 20
                styleColor: Qt.lighter(color)
                font.weight: Font.DemiBold
                color: "black"
            }
            Combo{
                id: importantInput
                width: parent.width - importantText.width -20
                model: ListModel{
                    ListElement{
                        text: "Very"
                    }
                    ListElement{
                        text: "Moderate"
                    }
                    ListElement{
                        text: "Low"
                    }
                }
                Component.onCompleted: {
                    console.log(important)
                    if(find(important)!== -1){
                        importantInput.currentIndex = find(important)
                    }
                }
            }
        }
        Rectangle{
            focus: true
            color: "#0080FF"
            height: 35
            width: parent.width
            Text {
                id: text
                text: qsTr("EDIT")
                anchors.centerIn: parent
                font.pixelSize: 30
                padding: 5
                color: "white"
                style:Text.Raised
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    stackView.pop();
                    console.log(indexNo)
                    myModel.replace(indexNo,titleInput.text,Date.fromLocaleString(Qt.locale(),dateSelect.text,"dd:MM:yyyy"),
                                    Date.fromLocaleString(Qt.locale(),hourInput.currentText+":"+minuteInput.currentText+" "
                                                                            +timeInput.currentText,"h:m a"),noteInput.text,
                                    importantInput.currentText
                                    )
                }
            }
        }
    }
    Popup{
        id: popup
        x: dateRect.x
        y: dateRect.y
        width: contentWidth
        height: contentHeight
        contentItem: Calendar{
            minimumDate: new Date()
            onClicked: {
                dateSelect.text = Qt.formatDate(date,"dd:MM:yyyy")
                popup.close()
            }
        }
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
    }
}
