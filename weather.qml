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
    id: app2
    width: 1200
    height: 800
    minimumWidth: 1200
    minimumHeight: 800
    visible: true
    title: qsTr("MeteoViz")


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

