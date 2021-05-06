import QtQuick 2.12
import QtQml 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.14
import QtLocation 5.15
import QtPositioning 5.15
import QtQuick.Controls.Material 2.12

ApplicationWindow {
    id: citychoiceWindow
    objectName: "citychoiceWindow"
    width: 1200
    height: 900
    minimumWidth: 1200
    minimumHeight: 900
    visible: true
    title: qsTr("MeteoViz")

    color: "#f8f5f0"
    Material.accent: "#f37052"

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


    Map {
        id: map
        width: parent.width * 0.75
        height: parent.height * 0.8
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.05
        plugin: Plugin {name: "osm"} //"esri", "mapboxgl"
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
        anchorPoint.y: 40
        coordinate: QtPositioning.coordinate(51.9189046, 19.1343786)
        visible: false

        sourceItem:
            Image{
                id: icon
                source: "img/marker.png"
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
                var Component = Qt.createComponent("weather_icon.qml")
                var item = Component.createObject(citychoiceWindow, {
                           coordinate: QtPositioning.coordinate(elements[0], elements[1])})

                switch(elements[2]){
                    //unknown
                    case 0: item.sourceItem.source = "img/questionmark.png";
                            break;
                    //clear
                    case 1000: item.sourceItem.source = "img/sunny.png";
                            break;
                    //cloudy
                    case 1001: item.sourceItem.source = "img/cloudy.png";
                            break;
                    //mostly cloudy
                    case 1100: item.sourceItem.source = "img/partly_sunny.png";
                            break;
                    //partly cloudy
                    case 1101: item.sourceItem.source = "img/partly_sunny.png";
                            break;
                    //mostly cloudy
                    case 1102: item.sourceItem.source = "img/cloudy.png";
                            break;
                    //fog
                    case 2000: item.sourceItem.source = "img/foggy.png";
                            break;
                    //light fog
                    case 2100: item.sourceItem.source = "img/foggy.png";
                            break;
                    //light wind
                    case 3000: item.sourceItem.source = "img/windy.png";
                            break;
                    //wind
                    case 3001: item.sourceItem.source = "img/windy.png";
                            break;
                    //strong wind
                    case 3002: item.sourceItem.source = "img/windy.png";
                            break;
                    //drizzle
                    case 4000: item.sourceItem.source = "img/rainy.png";
                            break;
                    //rain
                    case 4001: item.sourceItem.source = "img/rainy.png";
                            break;
                    //light rain
                    case 4200: item.sourceItem.source = "img/rainy.png";
                            break;
                    //heavy rain
                    case 4201: item.sourceItem.source = "img/rainy.png";
                            break;
                    //snow
                    case 5000: item.sourceItem.source = "img/snowy.png";
                            break;
                    //flurries
                    case 5001: item.sourceItem.source = "img/snowy.png";
                            break;
                    //light snow
                    case 5100: item.sourceItem.source = "img/snowy.png";
                            break;
                    //heavy snow
                    case 5101: item.sourceItem.source = "img/snowy.png";
                            break;
                    //freezing drizzle
                    case 6000: item.sourceItem.source = "img/snowy.png";
                            break;
                    //freezing rain
                    case 6001: item.sourceItem.source = "img/snowy.png";
                            break;
                    //light freezing rain
                    case 6200: item.sourceItem.source = "img/snowy.png";
                            break;
                    //heavy freezing rain
                    case 6201: item.sourceItem.source = "img/snowy.png";
                            break;
                    //ice pallets
                    case 7000: item.sourceItem.source = "img/snowy.png";
                            break;
                    //heavy ice pallets
                    case 7101: item.sourceItem.source = "img/snowy.png";
                            break;
                    //light ice pallets
                    case 7102: item.sourceItem.source = "img/snowy.png";
                            break;
                    //thunderstorm
                    case 8000: item.sourceItem.source = "img/stormy.png";
                            break;
                    //default
                    default: item.sourceItem.source = "img/questionmark.png";
                            break;
                }
                map.addMapItem(item)
            }
        }
    }
}


