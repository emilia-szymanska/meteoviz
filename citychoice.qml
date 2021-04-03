import QtQuick 2.12
import QtQml 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.14
import QtLocation 5.6
import QtPositioning 5.6

ApplicationWindow {
    id: citychoiceWindow
    objectName: "citychoiceWindow"

    //signal clickedButton(string text)
    signal chosenCity(string city)
    function setTextField(text){
        textLabel.text = text
    }

    function addMarker(latitude, longitude){
        //var Component = Qt.createComponent("marker.qml")
        //var item = Component.createObject(citychoiceWindow, {
        //           coordinate: QtPositioning.coordinate(latitude, longitude)})
        //map.addMapItem(item)
        marker2.coordinate = QtPositioning.coordinate(latitude, longitude)
        marker2.visible = true
    }

    function setCitiesList(list){
        comboBoxCities.model = list
    }

    function setMapItems(list){
        console.log(list)
        var elements = [0.0, 0.0, 0]

        for(var i in list){
            elements[i%3] = list[i]
            if (i%3 == 2){
                console.log(elements)
                var Component = Qt.createComponent("marker.qml")
                var item = Component.createObject(citychoiceWindow, {
                           coordinate: QtPositioning.coordinate(elements[0], elements[1])})
                map.addMapItem(item)
            }
        }
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
            model: ["None"]
            width: parent.width * 0.5
            height: parent.height
            onCurrentTextChanged:
            {
                chosenCity(currentText)
               // textLabel.text = currentText
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

   /* Loader{
        id:ld;
        anchors.fill: parent;
    }*/



    Plugin {
            id: mapPlugin
            name: "osm" //"esri", "mapboxgl"
        }

        Map {
            id: map
            width: parent.width * 0.75
            height: parent.height * 0.75
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30
            plugin: mapPlugin
            center: QtPositioning.coordinate(51.9189046, 19.1343786) // Center Poland
            zoomLevel: 6.3

            Component.onCompleted: map.addMapItem(marker2) //addMarker(59.91, 10.75)

        }

        MapQuickItem
        {
            id: marker2
            objectName: "marker2"
            anchorPoint.x: marker2.width / 2
            anchorPoint.y: marker2.height / 2
            coordinate: QtPositioning.coordinate(51.9189046, 19.1343786)
            visible: false

            sourceItem:
                Image{
                    Image{
                        id: icon
                        source: "img/example.jpg"
                        sourceSize.width: 40
                        sourceSize.height: 40
                    }
                }
        }

    /*Text {
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
        }*/
}


