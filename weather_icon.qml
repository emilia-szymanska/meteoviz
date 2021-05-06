import QtQuick 2.12
import QtQml 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.14
import QtLocation 5.6
import QtPositioning 5.6

MapQuickItem
{
    id: weather_marker
    anchorPoint.x: 50
    anchorPoint.y: 50
    sourceItem:
        AnimatedImage
        {
            id: icon
            source: "img/questionmark.png"
            width: 100
            height: 100
        }
}
