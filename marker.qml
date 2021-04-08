import QtQuick 2.12
import QtQml 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.14
import QtLocation 5.6
import QtPositioning 5.6

MapQuickItem
{
    id: marker
    anchorPoint.x: 20
    anchorPoint.y: 20 //marker.height
    sourceItem:
        //Image{
        //    id: icon3
            AnimatedImage{
                id: icon2
                source: "img/trial.gif"
                width: 40
                height: 40
            }
       //}
}
