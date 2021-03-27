import QtQuick 2.12
import QtQuick 2.0
import QtQuick 2.7
import QtQml 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtPositioning 5.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Styles 1.4


ApplicationWindow {
    id: app
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


    RowLayout {
        width: parent.width / 2
        height: parent.height / 20
        anchors {
            left: parent.left
            top: parent.top
            topMargin: 25
            leftMargin: 30
        }


        Text {
            id: labelCityChoice
            text: qsTr("Choose a city: ")
            font.pointSize: 10
            fontSizeMode: Text.Fit
            Layout.preferredWidth: parent.width * 0.28
            Layout.fillHeight: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            minimumPixelSize: 12
        }

        ComboBox {
            id: comboBoxCities
            model: ["None", "First", "Second", "Third"]
            Layout.preferredWidth: parent.width * 0.5
            Layout.fillHeight: true

        }
        Button{
            id: buttonNext
            text: qsTr("NEXT")

            highlighted:comboBoxCities.currentText == "None" ? false : true
            Layout.preferredWidth: parent.width * 0.12
            Layout.fillHeight: true
            anchors {
                //left: par.left
                leftMargin: parent.width * 0.1
            }
        }
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

/*Button {
    id: buttonNumberOfDevices

    highlighted: true
    enabled: (comboBoxCities.model.length > 0)
    text: (comboBoxCities.model.length > 0) ? comboBoxCities.model.length.toString() : "0"
    width: parent.width/3
    //Layout.preferredHeight: 48
}*/
/*    ColumnLayout {
        id: columnLayout
        anchors.margins: 15

        spacing: 10
        anchors.fill: parent

        Button {
            id: buttonSearch

            text: qsTr("Search")
            highlighted: true

            Layout.fillWidth: true
            Layout.preferredHeight: 48

            onClicked: comboBoxDevice.model = serialPortDevices.searchAndGetConnectedDevices()
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 48

            ComboBox {
                id: comboBoxDevice

                model: ListModel {}
                enabled: (comboBoxDevice.model.length > 0)

                Layout.fillWidth: true
                Layout.preferredHeight: 48
            }

            Button {
                id: buttonNumberOfDevices

                highlighted: true
                enabled: (comboBoxDevice.model.length > 0)
                text: (comboBoxDevice.model.length > 0) ? comboBoxDevice.model.length.toString() : "0"

                Layout.preferredHeight: 48
            }
        }

        TextField {
            id: textFieldBinary

            placeholderText: qsTr("path to binary")
            selectByMouse: true
            horizontalAlignment: Text.AlignHCenter
            enabled: (comboBoxDevice.model.length > 0)

            Layout.fillWidth: true
            Layout.preferredHeight: 48
        }

        Button {
            id: buttonUpload

            text: qsTr("Upload")
            highlighted: true
            enabled: (comboBoxDevice.model.length > 0) && textFieldBinary.text.match(".hex")

            Layout.fillWidth: true
            Layout.preferredHeight: 48
        }

    }

    AnimatedImage {
        id: animatedImage
        x: 104
        y: 156
        width: 100
        height: 100
        source: "img/trial.gif"
        smooth: false
        cache: false
    }

    Image {
        id: image
        x: 371
        y: 156
        width: 100
        height: 100
        source: "img/example.jpg"
        rotation: -0
        fillMode: Image.PreserveAspectFit
    }
*/
    /*ScrollView {
        anchors.fill: parent

        ListView {
            id: listView
            width: parent.width
            model: 20
            delegate: ItemDelegate {
                text: "Item " + (index + 1)
                width: listView.width
            }
        }
    }*/

