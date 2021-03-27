import QtQuick 2.12
import QtQml 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtPositioning 5.12
import QtQuick.Layouts 1.12

ApplicationWindow {
    id: weatherWindow
    width: 1200
    height: 800
    minimumWidth: 1200
    minimumHeight: 800
    visible: true
    title: qsTr("MeteoViz")

    Column{
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

        Row {
            width: parent.width
            height: parent.height * 0.05

            Text {
                id: textChosenCity
                text: qsTr("Warsaw")
                width: parent.width * 0.2
                height: parent.height
                font.pointSize: 10
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }


            Text {
                id: textDate
                text: qsTr("26.03.2021")
                width: parent.width * 0.3
                height: parent.height
                font.pointSize: 10
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: parent.width * 0.4
            }
        }

        Row {
            width: parent.width
            height: parent.height * 0.25

            Image {
                id: imageState
                width: parent.width * 0.25
                height: parent.height
                source: "img/example.jpg"
            }

            Column{
                width: parent.width * 0.5
                height: parent.height

                Row{
                    width: parent.width
                    height: parent.height * 0.5

                    Image {
                        width: parent.width * 0.1
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textTemperature
                        width: parent.width * 0.23
                        height: parent.height
                        text: qsTr("22 C")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Image {
                        width: parent.width * 0.1
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textWindVel
                        width: parent.width * 0.23
                        height: parent.height
                        text: qsTr("4 m/s")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Image {
                        width: parent.width * 0.1
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textHumidity
                        width: parent.width * 0.24
                        height: parent.height
                        text: qsTr("50%")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Row{
                    width: parent.width
                    height: parent.height * 0.5

                    Image {
                        width: parent.width * 0.1
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textPressure
                        width: parent.width * 0.23
                        height: parent.height
                        text: qsTr("1020hPa")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Image {
                        width: parent.width * 0.1
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textWindDirection
                        width: parent.width * 0.23
                        height: parent.height
                        text: qsTr("NE")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Image {
                        width: parent.width * 0.1
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textRain
                        width: parent.width * 0.24
                        height: parent.height
                        text: qsTr("10mm")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }

            /*Row {
                width: parent.width * 0.5
                height: parent.height

                Image {
                    id: imageState2
                    width: parent.width * 0.15
                    height: parent.height
                    source: "img/example.jpg"
                }

                Image {
                    id: imageState21
                    width: parent.width * 0.15
                    height: parent.height
                    source: "img/example.jpg"
                }

                Image {
                    id: imageState22
                    width: parent.width * 0.15
                    height: parent.height
                    source: "img/example.jpg"
                }

                Image {
                    id: imageState23
                    width: parent.width * 0.15
                    height: parent.height
                    source: "img/example.jpg"
                }

                Image {
                    id: imageState24
                    width: parent.width * 0.15
                    height: parent.height
                    source: "img/example.jpg"
                }

                Image {
                    id: imageState25
                    width: parent.width * 0.15
                    height: parent.height
                    source: "img/example.jpg"
                }


            }*/

            Image {
                id: imageState3
                width: parent.width * 0.25
                height: parent.height
                source: "img/example.jpg"
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

