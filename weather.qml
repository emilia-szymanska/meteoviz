//import QtQuick 2.12
import QtQuick 2.0
//import QtQuick 2.7
import QtQml 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtPositioning 5.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Styles 1.4


ApplicationWindow {
    id: weatherWindow
    width: 1200
    height: 800
    minimumWidth: 1200
    minimumHeight: 800
    visible: true
    title: qsTr("MeteoViz")

    ColumnLayout {
        //Layout.preferredWidth: parent.width
        //Layout.preferredHeight: parent.height
        width: parent.width
        height: parent.height

        anchors {
            left: parent.left
            top: parent.top
            right: parent.right
            bottom: parent.bottom
            topMargin: 20
            leftMargin: 20
            rightMargin: 20
            bottomMargin: 20
        }

        RowLayout{
            //Layout.preferredHeight: parent.height * 0.1
            //Layout.fillWidth: true
            width: parent.width
            height: parent.height * 0.1

            Text {
                id: textChosenCity
                text: qsTr("Warsaw")
                Layout.preferredWidth: parent.width * 0.3
                Layout.fillHeight: true
                font.pointSize: 10
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }


            Text {
                id: textDate
                text: qsTr("26.03.2021")
                Layout.preferredWidth: parent.width * 0.3
                Layout.fillHeight: true
                font.pointSize: 10
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors {
                    leftMargin: parent.width * 0.1
                }
            }
        }


    }

    /*Image {
        id: image

        width: parent.width * 0.5
        //height: parent.height * 0.5
        source: "img/example.jpg"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
    }*/


}

