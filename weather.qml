import QtQuick 2.12
import QtQml 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtPositioning 5.12
import QtQuick.Layouts 1.12
import QtCharts 2.15

ApplicationWindow {
    function setCityLabel(cityName)
    {
        textChosenCity.text = cityName
    }

    function datePlusX(value)
    {
        console.log(value)
        var currentDate = new Date();
        console.log(currentDate)
        currentDate.setDate(currentDate.getDate() + value);
        console.log(currentDate)
        return currentDate
    }

    id: weatherWindow
    objectName: "weatherWindow"
    width: 1200
    height: 900
    minimumWidth: 1200
    minimumHeight: 900
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
                width: parent.width * 0.25
                height: parent.height
                font.pointSize: 14
                font.bold: true
                font.capitalization: Font.AllUppercase
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            Rectangle{
                width: parent.width * 0.05
                height: parent.height
                color: "transparent"
            }

            Text {
                id: textDate
                text: Qt.formatDateTime(new Date(), "dd.MM.yyyy")
                width: parent.width * 0.35
                height: parent.height
                font.pointSize: 14
                font.bold: true
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
                source: "img/sun.png"
            }

            Rectangle{
                width: parent.width * 0.05
                height: parent.height
                color: "transparent"
            }

            Column{
                width: parent.width * 0.35
                height: parent.height


                Row{
                    width: parent.width
                    height: parent.height * 0.33

                    Image{
                        width: parent.width * 0.20
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textTemperature
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("22 C")
                        font.pointSize: 14
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
                        id: textPressure
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("1020 hPa")
                        font.pointSize: 14
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Row{
                    width: parent.width
                    height: parent.height * 0.33

                    Image{
                        width: parent.width * 0.20
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textWindVel
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("4 m/s")
                        font.pointSize: 14
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
                        id: textWindDirection
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("NE")
                        font.pointSize: 14
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Row{
                    width: parent.width
                    height: parent.height * 0.34

                    Image{
                        width: parent.width * 0.20
                        height: parent.height
                        source: "img/example.jpg"
                    }

                    Text {
                        id: textRain
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("10 mm")
                        font.pointSize: 14
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
                        id: textHumidity
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("50%")
                        font.pointSize: 14
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

            }

            Rectangle{
                width: parent.width * 0.2
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
                        appManager.changeWindow()
                        //weatherWindow.close()
                        //weatherWindow.visible = false
                        //ld.source="citychoice.qml"
                    }
                }
            }

        }

        Row{
            width: parent.width
            height: parent.height * 0.3

            ChartView {
                title: "Temperature"
                legend.visible: false
                backgroundColor: "transparent"
                plotAreaColor: "white"
                //anchors.fill: parent
                width: parent.width * 0.5
                height: parent.height
                antialiasing: true

                SplineSeries {
                    //name: "SplineSeries"
                    XYPoint { x: 0; y: 0.0 }
                    XYPoint { x: 1.1; y: 3.2 }
                    XYPoint { x: 1.9; y: 2.4 }
                    XYPoint { x: 2.1; y: 2.1 }
                    XYPoint { x: 2.9; y: 2.6 }
                    XYPoint { x: 3.2; y: 2.3 }
                    XYPoint { x: 4.1; y: 3.1 }
                }
                /*ValueAxis {
                        id: xAxis
                        min: 0
                        max: 5
                    }*/
            }

            ChartView {
                title: "Precipitation"
                legend.visible: false
                backgroundColor: "transparent"
                plotAreaColor: "white"
                //anchors.fill: parent
                width: parent.width * 0.5
                height: parent.height
                antialiasing: true

                SplineSeries {
                    //name: "SplineSeries"
                    XYPoint { x: 0; y: 0.0 }
                    XYPoint { x: 1.1; y: 3.2 }
                    XYPoint { x: 1.9; y: 2.4 }
                    XYPoint { x: 2.1; y: 2.1 }
                    XYPoint { x: 2.9; y: 2.6 }
                    XYPoint { x: 3.2; y: 2.3 }
                    XYPoint { x: 4.1; y: 3.1 }
                }
                /*ValueAxis {
                        id: yAxis
                        min: 0
                        max: 5
                    }*/
            }

        }

        Row{
            width: parent.width
            height: parent.height * 0.4

            Rectangle{
                width: parent.width * 0.05
                height: parent.height
                color: "transparent"
            }

            Column{
                width: parent.width * 0.27
                height: parent.height

                Row{
                    width: parent.width
                    height: parent.height * 0.33

                    Image{
                        width: parent.width * 0.4
                        height: parent.height
                        source: "img/sun.png"
                    }

                    Text {
                        id: textDate1
                        width: parent.width * 0.6
                        height: parent.height
                        text: /*Qt.formatDateTime(new Date() + 1, "dd.MM.yyyy")*/ Qt.formatDateTime(datePlusX(1), "dd.MM.yyyy")
                        font.pointSize: 12
                        font.bold: true
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
                        text: qsTr("NE")
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

            Rectangle{
                width: parent.width * 0.05
                height: parent.height
                color: "transparent"
            }

            Column{
                width: parent.width * 0.27
                height: parent.height

                Row{
                    width: parent.width
                    height: parent.height * 0.33

                    Image{
                        width: parent.width * 0.4
                        height: parent.height
                        source: "img/sun.png"
                    }

                    Text {
                        id: textDate2
                        width: parent.width * 0.6
                        height: parent.height
                        text: Qt.formatDateTime(datePlusX(2), "dd.MM.yyyy")
                        font.pointSize: 12
                        font.bold: true
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
                        text: qsTr("NE")
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

            Rectangle{
                width: parent.width * 0.05
                height: parent.height
                color: "transparent"
            }

            Column{
                width: parent.width * 0.26
                height: parent.height

                Row{
                    width: parent.width
                    height: parent.height * 0.33

                    Image{
                        width: parent.width * 0.4
                        height: parent.height
                        source: "img/sun.png"
                    }

                    Text {
                        id: textDate3
                        width: parent.width * 0.6
                        height: parent.height
                        text: Qt.formatDateTime(datePlusX(3), "dd.MM.yyyy")
                        font.pointSize: 12
                        font.bold: true
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
                        text: qsTr("NE")
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

            Rectangle{
                width: parent.width * 0.05
                height: parent.height
                color: "transparent"
            }
        }
    }

    Loader{
        id:ld;
        anchors.fill: parent;
    }
}

