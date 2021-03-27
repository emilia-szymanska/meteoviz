import QtQuick 2.12
import QtQml 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtPositioning 5.12

/*ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Scroll") */

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

   /* Map {
          id: map
          width: 540
          height: 380
          zoomLevel: (maximumZoomLevel - minimumZoomLevel)/2
          center {
              // The Qt Company in Oslo
              latitude: 59.9485
              longitude: 10.7686
          }
      }

*/


//}

import QtQuick 2.0
import QtQuick.Window 2.0
import QtLocation 5.6
import QtPositioning 5.6

Window {
    width: 512
    height: 512
    visible: true

    Plugin {
        id: mapPlugin
        name: "mapboxgl" //"osm" // "mapboxgl", "esri", ...
        // specify plugin parameters if necessary
        // PluginParameter {
        //     name:
        //     value:
        // }
    }

    Map {
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(59.91, 10.75) // Oslo
        zoomLevel: 14
    }
}
