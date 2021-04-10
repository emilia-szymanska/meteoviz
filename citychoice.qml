import QtQuick 2.12
import QtQml 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.14
import QtLocation 5.6
import QtPositioning 5.6

ApplicationWindow {
    id: citychoiceWindow
    objectName: "citychoiceWindow"
    width: 1200
    height: 900
    minimumWidth: 1200
    minimumHeight: 900
    visible: true
    title: qsTr("MeteoViz")

    background: BorderImage
            {
                source: "img/example.jpg"
                //border { left: 20; top: 20; right: 20; bottom: 20 }
            }

    ///////////////////////////////
    /////label+combobox+button////

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
            editable: true
            onCurrentTextChanged:
            {
                chosenCity(currentText)
                if(currentText == "Custom" && mapMarker.visible == false){
                    addMarker(51.9189046, 19.1343786)
                }
                if(currentText == "None" && mapMarker.visible == true){
                    mapMarker.visible = false
                }
            }
        }

        Rectangle{
            width: parent.width * 0.05
            height: parent.height
            color: "transparent"
        }

        Button{
            id: buttonNext
            text: qsTr("NEXT")
            highlighted: comboBoxCities.currentText == "None" ? false : true
            enabled: highlighted == true ? true : false
            width: parent.width * 0.12
            height: parent.height
            onClicked: {
                if(comboBoxCities.currentText == "Custom"){
                   var coordsFormat = mapMarker.coordinate.latitude + "," + mapMarker.coordinate.longitude
                   customCoords(coordsFormat)
                }
                appManager.changeWindow()
            }
        }

    }

    //////////////////////
    ////EXIT BUTTON//////


    Button{
        width: parent.width  * 0.1
        height: parent.height * 0.05
        text: qsTr("CLOSE")
        anchors {
            rightMargin: 30
            right: parent.right
            top: parent.top
            topMargin: 25
        }
        highlighted: true
        enabled: true
        onClicked: Qt.callLater(Qt.quit)
    }


    /////////////////
    ///MAP-RELATED///
    /////////////////

    Plugin {
        id: mapPlugin
        name: "osm" //"esri", "mapboxgl"
    }

    Map {
        id: map
        width: parent.width * 0.75
        height: parent.height * 0.8
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.05
        plugin: mapPlugin
        center: QtPositioning.coordinate(51.9189046, 19.1343786) // Center Poland
        zoomLevel: 6.6

        Component.onCompleted: map.addMapItem(mapMarker) //addMarker(59.91, 10.75)

        MouseArea {
            anchors.fill: parent
            onDoubleClicked:  {
                var coordinate = map.toCoordinate(Qt.point(mouse.x,mouse.y))
                mapMarker.coordinate = coordinate
                mapMarker.visible = true
                comboBoxCities.currentIndex = 1

            }
        }
    }

    MapQuickItem
    {
        id: mapMarker
        objectName: "mapMarker"
        anchorPoint.x: 20
        anchorPoint.y: 20
        coordinate: QtPositioning.coordinate(51.9189046, 19.1343786)
        visible: false

        sourceItem:
            Image{
                id: icon
                source: "img/example.jpg"
                sourceSize.width: 40
                sourceSize.height: 40
            }
    }


    ////////////////
    ///SIGNALS//////
    //FUNCTIONS/////
    ////////////////

    signal customCoords(string coords)
    signal chosenCity(string city)


    function addMarker(latitude, longitude){
        mapMarker.coordinate = QtPositioning.coordinate(latitude, longitude)
        mapMarker.visible = true
    }


    function setCitiesList(list){
        comboBoxCities.model = list
    }


    function setMapItems(list){
        var elements = [0.0, 0.0, 0] // lat, lon, code
        for(var i in list){
            elements[i%3] = list[i]

            if (i%3 == 2){
                var Component = Qt.createComponent("marker.qml")
                var item = Component.createObject(citychoiceWindow, {
                           coordinate: QtPositioning.coordinate(elements[0], elements[1])})

                switch(elements[2]){
                    case 0: item.sourceItem.source = "img/firework_transparent.gif";
                            break;
                    case 1101: item.sourceItem.source = "img/firework.gif";
                            break;
                    default: item.sourceItem.source = "img/trial.gif";
                            break;
                }
                map.addMapItem(item)
            }
        }
    }
}


