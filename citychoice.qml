import QtQuick 2.12
import QtQml 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtPositioning 5.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Styles 1.4


ApplicationWindow {
    id: citychoiceWindow
    objectName: "citychoiceWindow"

    signal clickedButton(string text)
    signal chosenCity(string city)
    function setTextField(text){

        textLabel.text = text
    }

    function setCitiesList(list){
        for (var i=0; i<list.length; i++)
                    console.log("Array item:", list[i])
        //comboBoxCities.model = list
    }



    width: 1200
    height: 800
    minimumWidth: 1200
    minimumHeight: 800
    visible: true
    title: qsTr("MeteoViz")

    background: BorderImage {
                source: "img/example.jpg"
                //border { left: 20; top: 20; right: 20; bottom: 20 }
            }


    Row {
        width: parent.width / 2
        height: parent.height / 20
        anchors {
            left: parent.left
            top: parent.top
            topMargin: 25
            leftMargin: 30
        }


        Text {
            id: textCityChoice
            text: qsTr("Choose a city: ")
            font.pointSize: 10
            fontSizeMode: Text.Fit
            width: parent.width * 0.28
            height: parent.height
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        ComboBox {
            id: comboBoxCities
            model: ["None", "Wroclaw", "Olsztyn", "Gdansk"]
            width: parent.width * 0.5
            height: parent.height
            onCurrentTextChanged:
            {
                chosenCity(currentText)
                textLabel.text = currentText
            }
        }

        Button{
            id: buttonNext
            text: qsTr("NEXT")

            highlighted: comboBoxCities.currentText == "None" ? false : true
            enabled: highlighted == true ? true : false
            width: parent.width * 0.12
            height: parent.height
            anchors {
                leftMargin: parent.width * 0.1
            }
            onClicked: {
                appManager.changeWindow()
                //citychoiceWindow.close()
                //ld.source="weather.qml"
            }
        }
    }

    Loader{
        id:ld;
        anchors.fill: parent;
    }


    Image {
        id: image

        width: parent.width * 0.5
        source: "img/example.jpg"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
    }


    Text {
        id: textLabel
        objectName: "textLabel"
        text: qsTr("HMMMM")
        font.pointSize: 10
        width: parent.width * 0.28
        height: parent.height
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Button {
            id: buttonTest
            objectName: "buttonTest"
            text: qsTr("MEH")
            onClicked: {
                buttonTest.text = ":///"
                clickedButton("xddd")
            }
        }
}


