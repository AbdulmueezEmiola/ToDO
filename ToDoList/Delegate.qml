import QtQuick 2.12
import QtQuick.Controls 2.5
//import QtQuick.Controls 1.4
import org.example 1.0
import QtQml.Models 2.12
import QtLocation 5.12
Page{
    id: root
    title: qsTr("Tasks")
    Column{
        anchors.fill: parent
        spacing: 5
        Entry{
            id: today
            width: parent.width
            text: "Today"
            onClicked: {
                if(checker == '-'){
                    listView.visible=true
                    listView.enabled = true
                }else{
                    listView.visible=false
                    listView.enabled = false
                }
            }
        }
        ListView{
            id: listView
            clip: true
            visible: false
            enabled: false
            height: count * 40
            width: parent.width
            model: delegateModelToday

        }
        Entry{
            id: week
            width: parent.width
            text: "Tomorrow"
            onClicked: {
                if(checker == '-'){
                    listViewTomorrow.visible=true
                    listViewTomorrow.enabled = true
                }else{
                    listViewTomorrow.visible=false
                    listViewTomorrow.enabled = false
                }
            }
        }
        ListView{
            id: listViewTomorrow
            clip: true
            visible: false
            enabled: false
            height: count * 40
            width: parent.width
            model: delegateModelTomorrow
        }
        Entry{
            width: parent.width
            text: "This week"
            onClicked: {
                if(checker == '-'){
                    listViewWeek.visible=true
                    listViewWeek.enabled = true
                }else{
                    listViewWeek.visible=false
                    listViewWeek.enabled = false
                }
            }
        }
        ListView{
            id: listViewWeek
            clip: true
            visible: false
            enabled: false
            height: count * 40
            width: parent.width
            model: delegateModelWeek
        }
        Entry{
            width: parent.width
            text: "This month"
            onClicked: {
                if(checker == '-'){
                    listViewMonth.visible=true
                    listViewMonth.enabled = true
                }else{
                    listViewMonth.visible=false
                    listViewMonth.enabled = false
                }
            }
        }
        ListView{
            id: listViewMonth
            clip: true
            visible: false
            enabled: false
            height: count * 40
            width: parent.width
            model: delegateModelMonth
        }
        Entry{
            width: parent.width
            text: "This year"
            onClicked: {
                if(checker == '-'){
                    listViewYear.visible=true
                    listViewYear.enabled = true
                }else{
                    listViewYear.visible=false
                    listViewYear.enabled = false
                }
            }
        }
        ListView{
            id: listViewYear
            clip: true
            visible: false
            enabled: false
            height: count * 40
            width: parent.width
            model: delegateModelYear
        }
        Entry{
            width: parent.width
            text: "Other"
            onClicked: {
                if(checker == '-'){
                    listViewOther.visible=true
                    listViewOther.enabled = true
                }else{
                    listViewOther.visible=false
                    listViewOther.enabled = false
                }
            }
        }
        ListView{
            id: listViewOther
            clip: true
            visible: false
            enabled: false
            height: count * 40
            width: parent.width
            model: delegateModelOther
        }
    }
    Component{
        id: listDelegate
        Rectangle{
            id: wrapper
            width: root.width
            height: 40
            border.color: Qt.lighter("blue")
            Rectangle{
                id: importantRect
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: 30
                height: 30
                radius: 15
                anchors.margins: 10
            }
            Text {
                id: nameText
                text: title
                anchors.left: importantRect.right
                anchors.top: parent.top
                color: "black"
                font.pixelSize: 20
                style: Text.Outline
                styleColor: "lightgray"
                elide: Text.ElideRight
                anchors.leftMargin: 10
            }
            Text {
                id: dateText
                text: date.toLocaleString(Qt.locale(),"dd:MM:yyyy")
                anchors.left: importantRect.right
                anchors.top: nameText.bottom
                color: "grey"
                font.pixelSize: 10
                style: Text.Sunken
                styleColor: "lightgray"
                anchors.leftMargin: 10
            }
            Text{
                id: timeText
                anchors.leftMargin: 5
                anchors.bottomMargin: 5
                text: time.toLocaleString(Qt.locale(),"hh:mm")
                anchors.left: dateText.right
                anchors.top: nameText.bottom
                color: "grey"
                font.pixelSize: 10
                style: Text.Sunken
                styleColor: "lightgray"
            }
            Button{
                icon.source: "md-trash.svg"
                icon.color: "black"
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.bottomMargin: 10
                anchors.margins: 10
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        myModel.remove(position)
                        console.log(myModel.count)
                    }
                }
                background: Rectangle{
                    visible: false
                    border.color: Qt.lighter(color)
               }

            }
            Component.onCompleted: {
                if(important == "Very"){
                    importantRect.color = "red"
                }else if(important == "Moderate"){
                    importantRect.color = "yellow"
                }else{
                    importantRect.color = "green"
                }
            }
        }
    }
    Model{
        id: myModel
        onRowCountChanged: delegateModelToday.setGroups()
    }
    DelegateModel{
        id: delegateModelToday
        delegate: listDelegate
        model: myModel
        groups: [
            DelegateModelGroup{
                includeByDefault: false
                name: "todayField"
                id: todayGroup
            }
        ]
        filterOnGroup: "todayField"
        function setGroups(){
            todayGroup.remove(0,todayGroup.count)
            var rowCount = myModel.count;
            console.log(rowCount)
            items.remove(0,count);
            for(var i =0;i<rowCount;i++){
                var entry = myModel.get(i);
                if(entry.date.getDate() === new Date().getDate()){
                    items.insert(entry,"todayField");
                }
            }
        }
        Component.onCompleted: {
            var rowCount = myModel.count;
            items.remove(0,rowCount);
            for(var i =0;i<rowCount;i++){
                var entry = myModel.get(i);
                if(entry.date.getDate() === new Date().getDate()){
                    items.insert(entry,"todayField");
                }
            }
        }
    }
    DelegateModel{
        id: delegateModelTomorrow
        delegate: listDelegate
        model: myModel
        groups: [
            DelegateModelGroup{
                includeByDefault: false
                name: "tomorrowField"
            }
        ]
        filterOnGroup: "tomorrowField"
        Component.onCompleted: {
            var rowCount = myModel.count;
            items.remove(0,rowCount);
            for(var i =0;i<rowCount;i++){
                var entry = myModel.get(i);
                if(entry.date.getDate() === new Date().getDate()+1){
                    items.insert(entry,"tomorrowField");
                }
            }
        }
    }
    function getWeek(date) {
      if (!(date instanceof Date)) date = new Date();
      var nDay = date.getDay() ;
      date.setDate(date.getDate() - nDay + 3);
      var n1stThursday = date.valueOf();
      date.setMonth(0, 1);
      if (date.getDay() !== 4) {
        date.setMonth(0, 1 + ((4 - date.getDay()) + 7) % 7);
      }
      return 1 + Math.ceil((n1stThursday - date) / 604800000);
    }
    DelegateModel{
        id: delegateModelWeek
        delegate: listDelegate
        model: myModel
        groups: [
            DelegateModelGroup{
                includeByDefault: false
                name: "weekField"
            }
        ]
        filterOnGroup: "weekField"
        Component.onCompleted: {
            var rowCount = myModel.count;
            items.remove(0,rowCount);
            for(var i =0;i<rowCount;i++){
                var entry = myModel.get(i);
                if(getWeek(entry.date.getDate()) === getWeek(new Date().getDate())){
                    items.insert(entry,"weekField");
                }
            }
        }
    }
    DelegateModel{
        id: delegateModelMonth
        delegate: listDelegate
        model: myModel
        groups: [
            DelegateModelGroup{
                includeByDefault: false
                name: "monthField"
            }
        ]
        filterOnGroup: "monthField"
        Component.onCompleted: {
            var rowCount = myModel.count;
            items.remove(0,rowCount);
            for(var i =0;i<rowCount;i++){
                var entry = myModel.get(i);
                if(entry.date.getMonth() === new Date().getMonth()){
                    items.insert(entry,"monthField");
                }
            }
        }
    }
    DelegateModel{
        id: delegateModelYear
        delegate: listDelegate
        model: myModel
        groups: [
            DelegateModelGroup{
                includeByDefault: false
                name: "yearField"
            }
        ]
        filterOnGroup: "yearField"
        Component.onCompleted: {
            var rowCount = myModel.count;
            items.remove(0,rowCount);
            for(var i =0;i<rowCount;i++){
                var entry = myModel.get(i);
                if(entry.date.getFullYear() === new Date().getFullYear()){
                    items.insert(entry,"yearField");
                }
            }
        }
    }
    DelegateModel{
        id: delegateModelOther
        delegate: listDelegate
        model: myModel
        groups: [
            DelegateModelGroup{
                includeByDefault: false
                name: "otherField"
            }
        ]
        filterOnGroup: "otherField"
        Component.onCompleted: {
            var rowCount = myModel.count;
            items.remove(0,rowCount);
            for(var i =0;i<rowCount;i++){
                var entry = myModel.get(i);
                if(entry.date.getFullYear() > new Date().getFullYear()){
                    items.insert(entry,"otherField");
                }
            }
        }
    }
}
