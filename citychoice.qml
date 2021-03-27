import QtQuick 2.12
import QtQuick 2.0
import QtQuick 2.7
//import QtQuick 1.0
import QtQml 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtPositioning 5.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Styles 1.4


ApplicationWindow {
    id: citychoiceWindow
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


    Row/*Layout*/ {
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
            //Layout.preferredWidth: parent.width * 0.28
            //Layout.fillHeight: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        ComboBox {
            id: comboBoxCities
            model: ["None", "First", "Second", "Third"]
            width: parent.width * 0.5
            height: parent.height
            //Layout.preferredWidth: parent.width * 0.5
            //Layout.fillHeight: true

        }
        Button{
            id: buttonNext
            text: qsTr("NEXT")

            highlighted: comboBoxCities.currentText == "None" ? false : true
            enabled: highlighted == true ? true : false
            width: parent.width * 0.12
            height: parent.height
            //Layout.preferredWidth: parent.width * 0.12
            //Layout.fillHeight: true
            anchors {
                leftMargin: parent.width * 0.1
            }
            onClicked: {
                citychoiceWindow.visible = false
                ld.source="weather.qml"
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
        //height: parent.height * 0.5
        source: "img/example.jpg"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
    }
}


