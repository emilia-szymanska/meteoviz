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

            Rectangle{
                width: parent.width * 0.1
                height: parent.height
                color: "transparent"
            }

            Column{
                width: parent.width * 0.15
                height: parent.height

                Button{
                    width: parent.width
                    height: parent.height * 0.5
                    text: qsTr("Refresh")
                    highlighted: true
                    enabled: true
                }

                Button{
                    width: parent.width
                    height: parent.height * 0.5
                    text: qsTr("BACK")
                    highlighted: true
                    enabled: true
                    onClicked: {
                        weatherWindow.visible = false
                        ld.source="citychoice.qml"
                    }
                }
            }

        }

        Row{
            width: parent.width
            height: parent.height * 0.2

            Image {
                width: parent.width * 0.5
                height: parent.height
                source: "img/example.jpg"
            }

            Image {
                width: parent.width * 0.5
                height: parent.height
                source: "img/example.jpg"
            }
        }

        Row{
            width: parent.width
            height: parent.height * 0.5

            Column{
                width: parent.width * 0.33
                height: parent.height

                Row{
                    width: parent.width
                    height: parent.height * 0.33

                    Image{
                        width: parent.width * 0.4
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textDate1
                        width: parent.width * 0.6
                        height: parent.height
                        text: qsTr("27.03.2021")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                }

                Row{
                    width: parent.width
                    height: parent.height * 0.22

                    Image{
                        width: parent.width * 0.20
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textTemperature1
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("22 C")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Image{
                        width: parent.width * 0.20
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textPressure1
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("1020 hPa")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Row{
                    width: parent.width
                    height: parent.height * 0.22

                    Image{
                        width: parent.width * 0.20
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textWindVel1
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("4 m/s")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Image{
                        width: parent.width * 0.20
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textWindDirection1
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("1020 hPa")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Row{
                    width: parent.width
                    height: parent.height * 0.22

                    Image{
                        width: parent.width * 0.20
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textRain1
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("10 mm")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Image{
                        width: parent.width * 0.20
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textHumidity1
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("50%")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

            }

            Column{
                width: parent.width * 0.33
                height: parent.height

                Row{
                    width: parent.width
                    height: parent.height * 0.33

                    Image{
                        width: parent.width * 0.4
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textDate2
                        width: parent.width * 0.6
                        height: parent.height
                        text: qsTr("28.03.2021")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                }

                Row{
                    width: parent.width
                    height: parent.height * 0.22

                    Image{
                        width: parent.width * 0.20
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textTemperature2
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("22 C")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Image{
                        width: parent.width * 0.20
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textPressure2
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("1020 hPa")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Row{
                    width: parent.width
                    height: parent.height * 0.22

                    Image{
                        width: parent.width * 0.20
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textWindVel2
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("4 m/s")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Image{
                        width: parent.width * 0.20
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textWindDirection2
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("1020 hPa")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Row{
                    width: parent.width
                    height: parent.height * 0.22

                    Image{
                        width: parent.width * 0.20
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textRain2
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("10 mm")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Image{
                        width: parent.width * 0.20
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textHumidity2
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("50%")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

            }

            Column{
                width: parent.width * 0.33
                height: parent.height

                Row{
                    width: parent.width
                    height: parent.height * 0.33

                    Image{
                        width: parent.width * 0.4
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textDate3
                        width: parent.width * 0.6
                        height: parent.height
                        text: qsTr("28.03.2021")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                }

                Row{
                    width: parent.width
                    height: parent.height * 0.22

                    Image{
                        width: parent.width * 0.20
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textTemperature3
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("22 C")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Image{
                        width: parent.width * 0.20
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textPressure3
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("1020 hPa")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Row{
                    width: parent.width
                    height: parent.height * 0.22

                    Image{
                        width: parent.width * 0.20
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textWindVel3
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("4 m/s")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Image{
                        width: parent.width * 0.20
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textWindDirection3
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("1020 hPa")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Row{
                    width: parent.width
                    height: parent.height * 0.22

                    Image{
                        width: parent.width * 0.20
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textRain3
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("10 mm")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Image{
                        width: parent.width * 0.20
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textHumidity3
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("50%")
                        font.pointSize: 10
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

            }
        }
    }

    Loader{
        id:ld;
        anchors.fill: parent;
    }
}

