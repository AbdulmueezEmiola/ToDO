import QtQuick 2.6
import QtQml 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import org.example 1.0
Page{
    title: qsTr("Add")
    id: root
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
                border.color: "black"
                width: parent.width - titleText.width-20
                height: parent.height
                TextInput{
                    id: titleInput
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
                    text: Qt.formatDate(new Date(),"dd:MM:yyyy")
                    color: "black"
                    anchors.centerIn: parent
                    anchors.margins: 10
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
            clip: true
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
                    sizeToContents: true
                    width: (parent.width-timeText.width-15)/3
                    model:12
                }
                Combo{
                    id: minuteInput
                    width:(parent.width-timeText.width-15) /3
                    model:60
                }
                Combo{
                    id: timeInput
                    width: (parent.width-timeText.width-15) /3
                    model:ListModel{
                        ListElement{
                            text: "AM"
                        }
                        ListElement{
                            text: "PM"
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
            }
        }
        Rectangle{
            focus: true
            color: "#0080FF"
            height: 35
            width: parent.width
            Text {
                id: text
                text: qsTr("ADD")
                anchors.centerIn: parent
                font.pixelSize: 30
                padding: 5
                color: "white"
                style:Text.Raised
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    var temp = Date.fromLocaleString(Qt.locale(),dateSelect.text,"dd:MM:yyyy");
                    if(titleInput.text.length>0 ){
                        saveDocument();
                        stackView.pop();
                    }else{
                        warningDialog.open()
                    }
                }
            }
        }
    }
    Popup{
        id: popup
        x: dateRect.x
        y: dateRect.y
        width: parent.width - x -5
        height: parent.width - y -5
        contentItem: Calendar{
            minimumDate: new Date()
            onClicked: {
                dateSelect.text = Qt.formatDate(date,"dd:MM:yyyy")
                popup.close()
            }
        }
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
    }
    MessageDialog{
        id: warningDialog
        icon: StandardIcon.Warning
        title: "Error"
        text: "Title and date need to be selected"
        onAccepted: {
            close()
        }
    }

    FileIO{
        id : io
    }

    function saveDocument(){
        io.member.title = titleInput.text;
        io.member.date = Date.fromLocaleString(Qt.locale(),dateSelect.text,"dd:MM:yyyy");
        console.log(io.member.date)
        io.member.time = Date.fromLocaleString(Qt.locale(),hourInput.currentText+":"+minuteInput.currentText+" "
                                        +timeInput.currentText,"h:m a")
        console.log(io.member.time)
        io.member.note = noteInput.text;
        io.member.important = importantInput.currentText;
        io.write();
    }
}
