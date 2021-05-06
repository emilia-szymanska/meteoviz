import QtQuick 2.12
import QtQml 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtPositioning 5.12
import QtCharts 2.15
import QtQuick.Controls.Material 2.12

ApplicationWindow {
    id: weatherWindow
    objectName: "weatherWindow"
    width: 1200
    height: 900
    minimumWidth: 1200
    minimumHeight: 900
    visible: true
    title: qsTr("MeteoViz")

    color: "#f8f5f0"

    Material.accent: "#f37052"

    /////////////////////////////
    ///// general layout ////////
    /////////////////////////////


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

        //////////////////////////////////
        /// city + date //////////////////

        Row {
            width: parent.width
            height: parent.height * 0.05

            Text {
                id: textChosenCity
                text: qsTr("---")
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
                width: parent.width * 0.1
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


        ////////////////////////////////////////
        //// state + weather data + 3 buttons///

        Row {
            width: parent.width
            height: parent.height * 0.25

            AnimatedImage {
                id: imageState
                width: parent.width * 0.22
                height: parent.height
                source: "img/partly_sunny.png"
            }

            Rectangle{
                width: parent.width * 0.13
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
                        source: "img/temperature.png"
                    }

                    Text {
                        id: textTemperature
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("-\xB0C")
                        font.pointSize: 14
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Image{
                        width: parent.width * 0.20
                        height: parent.height
                        source: "img/pressure.png"
                    }

                    Text {
                        id: textPressure
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("- hPa")
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
                        source: "img/wind_speed.png"
                    }

                    Text {
                        id: textWindVel
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("- m/s")
                        font.pointSize: 14
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Image{
                        width: parent.width * 0.20
                        height: parent.height
                        source: "img/wind_direction.png"
                    }

                    Text {
                        id: textWindDirection
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("-")
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
                        source: "img/rain.png"
                    }

                    Text {
                        id: textRain
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("- mm")
                        font.pointSize: 14
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Image{
                        width: parent.width * 0.20
                        height: parent.height
                        source: "img/humidity.png"
                    }

                    Text {
                        id: textHumidity
                        width: parent.width * 0.3
                        height: parent.height
                        text: qsTr("-%")
                        font.pointSize: 14
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

            }

            Rectangle{
                width: parent.width * 0.15
                height: parent.height
                color: "transparent"
            }

            Column{
                width: parent.width * 0.15
                height: parent.height

                Button{
                    width: parent.width
                    height: parent.height * 0.33
                    text: qsTr("Refresh")
                    highlighted: true
                    enabled: true
                    onClicked: refresh()
                }

                Button{
                    width: parent.width
                    height: parent.height * 0.33
                    text: qsTr("BACK")
                    highlighted: true
                    enabled: true
                    onClicked: {
                        appManager.changeWindow()
                    }
                }

                Button{
                    width: parent.width
                    height: parent.height * 0.33
                    text: qsTr("CLOSE")
                    highlighted: true
                    enabled: true
                    onClicked: Qt.callLater(Qt.quit)
                }
            }

        }

        ////////////////////////////////////////
        /////// 2 charts - spline and bars /////


        Row{
            width: parent.width
            height: parent.height * 0.3

            ChartView {
                title: "Temperature"
                id: temperatureChart
                legend.visible: false
                backgroundColor: "transparent"
                plotAreaColor: "white"
                width: parent.width * 0.5
                height: parent.height
                antialiasing: true
                titleFont.family: "Arial"
                titleFont.bold: true
                titleFont.capitalization: Font.AllUppercase


                DateTimeAxis{
                    id: tempAxisXTime
                    format: "hh:00"
                    min: fullHourPlusX(0)
                    tickCount: 8
                    max: fullHourPlusX(7)
                    labelsFont.bold: true

                }

                ValueAxis {
                    id: tempAxisY
                    tickInterval: 1
                    min: 0
                    max: 4
                    labelFormat: "%d&deg;C"
                    labelsFont.bold: true
                }

                SplineSeries {
                    id: temperatureSeries
                    axisX: tempAxisXTime
                    axisY: tempAxisY
                    width: 4.0
                    color: "#f37052"
                }
            }

            ChartView {
                title: "Precipitation"
                legend.visible: false
                backgroundColor: "transparent"
                plotAreaColor: "white"
                width: parent.width * 0.5
                height: parent.height
                antialiasing: true
                titleFont.family: "Arial"
                titleFont.bold: true
                titleFont.capitalization: Font.AllUppercase
                titleColor: "black"

                DateTimeAxis{
                    id: precAxisXTime
                    format: "hh:00"
                    min: fullHourPlusX(0)
                    tickCount: 8
                    max: fullHourPlusX(7)
                    labelsFont.bold: true
                    labelsColor: "white"

                }

                ValueAxis {
                    id: precAxisY
                    min: 0
                    max: 4
                    tickInterval: 1
                    labelFormat: "%d mm"
                    labelsFont.bold: true
                }

                BarCategoryAxis {
                    id: barCategories
                    categories: hourCategories()
                    labelsFont.bold: true
                }

                BarSeries {
                    id: precitipationSeries
                    axisX: barCategories
                    axisY: precAxisY
                    barWidth: 1
                    BarSet {
                        id: barSetData
                        color: "#bcc9e0"
                        values: [0, 0, 0, 0, 0, 0]
                    }
                }
            }
        }

        ////////////////////////////////////////////
        //// 3x (state image, weather data, date)///

        Row{
            width: parent.width
            height: parent.height * 0.4

            Rectangle{
                width: parent.width * 0.02
                height: parent.height
                color: "transparent"
            }

            GroupBox {
                width: parent.width * 0.31
                height: parent.height

                background: Rectangle {
                        width: parent.width
                        height: parent.height
                        color: "#ece4d7"
                        border.color: "transparent"
                        radius: 2
                    }

                Column{
                    anchors.fill: parent


                    Row{
                        width: parent.width
                        height: parent.height * 0.36

                        Image{
                            id: imageState1
                            width: parent.width * 0.4
                            height: parent.height
                            source: "img/partly_sunny.png"
                        }

                        Text {
                            id: textDate1
                            width: parent.width * 0.6
                            height: parent.height
                            text: Qt.formatDateTime(datePlusX(1), "dd.MM.yyyy")
                            font.pointSize: 12
                            font.bold: true
                            fontSizeMode: Text.Fit
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                    }

                    Rectangle{
                        width: parent.width
                        height: parent.height * 0.04
                        color: "transparent"
                    }

                    Row{
                        width: parent.width
                        height: parent.height * 0.2

                        Image{
                            width: parent.width * 0.20
                            height: parent.height
                            source: "img/temperature.png"
                        }

                        Text {
                            id: textTemperature1
                            width: parent.width * 0.3
                            height: parent.height
                            text: qsTr("- C")
                            font.pointSize: 10
                            fontSizeMode: Text.Fit
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        Image{
                            width: parent.width * 0.20
                            height: parent.height
                            source: "img/pressure.png"
                        }

                        Text {
                            id: textPressure1
                            width: parent.width * 0.3
                            height: parent.height
                            text: qsTr("1015 hPa")
                            font.pointSize: 10
                            fontSizeMode: Text.Fit
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Row{
                        width: parent.width
                        height: parent.height * 0.2

                        Image{
                            width: parent.width * 0.20
                            height: parent.height
                            source: "img/wind_speed.png"
                        }

                        Text {
                            id: textWindVel1
                            width: parent.width * 0.3
                            height: parent.height
                            text: qsTr("- m/s")
                            font.pointSize: 10
                            fontSizeMode: Text.Fit
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        Image{
                            width: parent.width * 0.20
                            height: parent.height
                            source: "img/wind_direction.png"
                        }

                        Text {
                            id: textWindDirection1
                            width: parent.width * 0.3
                            height: parent.height
                            text: qsTr("-")
                            font.pointSize: 10
                            fontSizeMode: Text.Fit
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Row{
                        width: parent.width
                        height: parent.height * 0.2

                        Image{
                            width: parent.width * 0.20
                            height: parent.height
                            source: "img/rain.png"
                        }

                        Text {
                            id: textRain1
                            width: parent.width * 0.3
                            height: parent.height
                            text: qsTr("- mm")
                            font.pointSize: 10
                            fontSizeMode: Text.Fit
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        Image{
                            width: parent.width * 0.20
                            height: parent.height
                            source: "img/humidity.png"
                        }

                        Text {
                            id: textHumidity1
                            width: parent.width * 0.3
                            height: parent.height
                            text: qsTr("-%")
                            font.pointSize: 10
                            fontSizeMode: Text.Fit
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                }
            }

            Rectangle{
                width: parent.width * 0.02
                height: parent.height
                color: "transparent"
            }

            GroupBox {
                width: parent.width * 0.31
                height: parent.height

                background: Rectangle {
                        width: parent.width
                        height: parent.height
                        color: "#ece4d7"
                        border.color: "transparent"
                        radius: 2
                    }

                Column{
                    anchors.fill: parent

                    Row{
                        width: parent.width
                        height: parent.height * 0.36

                        Image{
                            id: imageState2
                            width: parent.width * 0.4
                            height: parent.height
                            source: "img/snowy.png"
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

                    Rectangle{
                        width: parent.width
                        height: parent.height * 0.04
                        color: "transparent"
                    }

                    Row{
                        width: parent.width
                        height: parent.height * 0.2

                        Image{
                            width: parent.width * 0.20
                            height: parent.height
                            source: "img/temperature.png"
                        }

                        Text {
                            id: textTemperature2
                            width: parent.width * 0.3
                            height: parent.height
                            text: qsTr("- C")
                            font.pointSize: 10
                            fontSizeMode: Text.Fit
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        Image{
                            width: parent.width * 0.20
                            height: parent.height
                            source: "img/pressure.png"
                        }

                        Text {
                            id: textPressure2
                            width: parent.width * 0.3
                            height: parent.height
                            text: qsTr("- hPa")
                            font.pointSize: 10
                            fontSizeMode: Text.Fit
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Row{
                        width: parent.width
                        height: parent.height * 0.2

                        Image{
                            width: parent.width * 0.20
                            height: parent.height
                            source: "img/wind_speed.png"
                        }

                        Text {
                            id: textWindVel2
                            width: parent.width * 0.3
                            height: parent.height
                            text: qsTr("- m/s")
                            font.pointSize: 10
                            fontSizeMode: Text.Fit
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        Image{
                            width: parent.width * 0.20
                            height: parent.height
                            source: "img/wind_direction.png"
                        }

                        Text {
                            id: textWindDirection2
                            width: parent.width * 0.3
                            height: parent.height
                            text: qsTr("-")
                            font.pointSize: 10
                            fontSizeMode: Text.Fit
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Row{
                        width: parent.width
                        height: parent.height * 0.2

                        Image{
                            width: parent.width * 0.20
                            height: parent.height
                            source: "img/rain.png"
                        }

                        Text {
                            id: textRain2
                            width: parent.width * 0.3
                            height: parent.height
                            text: qsTr("- mm")
                            font.pointSize: 10
                            fontSizeMode: Text.Fit
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        Image{
                            width: parent.width * 0.20
                            height: parent.height
                            source: "img/humidity.png"
                        }

                        Text {
                            id: textHumidity2
                            width: parent.width * 0.3
                            height: parent.height
                            text: qsTr("-%")
                            font.pointSize: 10
                            fontSizeMode: Text.Fit
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                }

            }

            Rectangle{
                width: parent.width * 0.02
                height: parent.height
                color: "transparent"
            }

            GroupBox {
                width: parent.width * 0.30
                height: parent.height

                background: Rectangle {
                        width: parent.width
                        height: parent.height
                        color: "#ece4d7"
                        border.color: "transparent"
                        radius: 2
                    }

                Column{
                    anchors.fill: parent

                    Row{
                        width: parent.width
                        height: parent.height * 0.36

                        Image{
                            id: imageState3
                            width: parent.width * 0.4
                            height: parent.height
                            source: "img/cloudy.png"
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

                    Rectangle{
                        width: parent.width
                        height: parent.height * 0.04
                        color: "transparent"
                    }

                    Row{
                        width: parent.width
                        height: parent.height * 0.2

                        Image{
                            width: parent.width * 0.20
                            height: parent.height
                            source: "img/temperature.png"
                        }

                        Text {
                            id: textTemperature3
                            width: parent.width * 0.3
                            height: parent.height
                            text: qsTr("- C")
                            font.pointSize: 10
                            fontSizeMode: Text.Fit
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        Image{
                            width: parent.width * 0.20
                            height: parent.height
                            source: "img/pressure.png"
                        }

                        Text {
                            id: textPressure3
                            width: parent.width * 0.3
                            height: parent.height
                            text: qsTr("- hPa")
                            font.pointSize: 10
                            fontSizeMode: Text.Fit
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Row{
                        width: parent.width
                        height: parent.height * 0.2

                        Image{
                            width: parent.width * 0.20
                            height: parent.height
                            source: "img/wind_speed.png"
                        }

                        Text {
                            id: textWindVel3
                            width: parent.width * 0.3
                            height: parent.height
                            text: qsTr("- m/s")
                            font.pointSize: 10
                            fontSizeMode: Text.Fit
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        Image{
                            width: parent.width * 0.20
                            height: parent.height
                            source: "img/wind_direction.png"
                        }

                        Text {
                            id: textWindDirection3
                            width: parent.width * 0.3
                            height: parent.height
                            text: qsTr("-")
                            font.pointSize: 10
                            fontSizeMode: Text.Fit
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Row{
                        width: parent.width
                        height: parent.height * 0.2

                        Image{
                            width: parent.width * 0.20
                            height: parent.height
                            source: "img/rain.png"
                        }

                        Text {
                            id: textRain3
                            width: parent.width * 0.3
                            height: parent.height
                            text: qsTr("- mm")
                            font.pointSize: 10
                            fontSizeMode: Text.Fit
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        Image{
                            width: parent.width * 0.20
                            height: parent.height
                            source: "img/humidity.png"
                        }

                        Text {
                            id: textHumidity3
                            width: parent.width * 0.3
                            height: parent.height
                            text: qsTr("-%")
                            font.pointSize: 10
                            fontSizeMode: Text.Fit
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                }

            }

            Rectangle{
                width: parent.width * 0.02
                height: parent.height
                color: "transparent"
            }
        }
    }


    ////////////////
    ///SIGNALS//////
    //FUNCTIONS/////
    ////////////////

    signal refresh()

    function setCityLabel(cityName){
        textChosenCity.text = cityName
    }


    function datePlusX(value){
        var currentDate = new Date();
        currentDate.setDate(currentDate.getDate() + value);
        return currentDate
    }


    function fullHourPlusX(value){
        var date = new Date();
        date.setHours(date.getHours() + value);
        date.setMinutes(0, 0, 0)
        return date
    }


    function setFourWeatherForecast(list){
        var elements = [0.0, 0.0, 0.0, "", 0.0, 0.0, 0] // temp, press, windSpeed, windDir, precit, hum, code
        var j = 0;

        for(var i in list){
            elements[i%7] = list[i]
            if (i%7 == 6){
                if(j===0){
                    textTemperature.text = elements[0] + "\xB0C";
                    textPressure.text = elements[1] + "hPa";
                    textWindVel.text = elements[2] + "m/s";
                    textWindDirection.text = elements[3];
                    textRain.text = elements[4] + "mm/h";
                    textHumidity.text = elements[5] + "%";
                    var path = returnSourcePath(elements[6]);
                    imageState.source = path;
                }
                if(j===1){
                    textTemperature1.text = elements[0] + "\xB0C";
                    textPressure1.text = elements[1] + "hPa";
                    textWindVel1.text = elements[2] + "m/s";
                    textWindDirection1.text = elements[3];
                    textRain1.text = elements[4] + "mm/h";
                    textHumidity1.text = elements[5] + "%";
                    var path1 = returnSourcePath(elements[6]);
                    imageState1.source = path;
                }
                if(j===2){
                    textTemperature2.text = elements[0] + "\xB0C";
                    textPressure2.text = elements[1] + "hPa";
                    textWindVel2.text = elements[2] + "m/s";
                    textWindDirection2.text = elements[3];
                    textRain2.text = elements[4] + "mm/h";
                    textHumidity2.text = elements[5] + "%";
                    var path2 = returnSourcePath(elements[6]);
                    imageState2.source = path;
                }
                if(j===3){
                    textTemperature3.text = elements[0] + "\xB0C";
                    textPressure3.text = elements[1] + "hPa";
                    textWindVel3.text = elements[2] + "m/s";
                    textWindDirection3.text = elements[3];
                    textRain3.text = elements[4] + "mm/h";
                    textHumidity3.text = elements[5] + "%";
                    var path3 = returnSourcePath(elements[6]);
                    imageState3.source = path;
                }
                j++;
               }
            }
    }


    function returnSourcePath(code){
        switch(code){
            //unknown
            case 0: return "img/questionmark.png";
            //clear
            case 1000: return "img/sunny.png";
            //cloudy
            case 1001: return "img/cloudy.png";
            //mostly cloudy
            case 1100: return "img/partly_sunny.png";
            //partly cloudy
            case 1101: return "img/partly_sunny.png";
            //mostly cloudy
            case 1102: return "img/cloudy.png";
            //fog
            case 2000: return "img/foggy.png";
            //light fog
            case 2100: return "img/foggy.png";
            //light wind
            case 3000: return "img/windy.png";
            //wind
            case 3001: return "img/windy.png";
            //strong wind
            case 3002: return "img/windy.png";
            //drizzle
            case 4000: return "img/rainy.png";
            //rain
            case 4001: return "img/rainy.png";
            //light rain
            case 4200: return "img/rainy.png";
            //heavy rain
            case 4201: return "img/rainy.png";
            //snow
            case 5000: return "img/snowy.png";
            //flurries
            case 5001: return "img/snowy.png";
            //light snow
            case 5100: return "img/snowy.png";
            //heavy snow
            case 5101: return "img/snowy.png";
            //freezing drizzle
            case 6000: return "img/snowy.png";
            //freezing rain
            case 6001: return "img/snowy.png";
            //light freezing rain
            case 6200: return "img/snowy.png";
            //heavy freezing rain
            case 6201: return "img/snowy.png";
            //ice pallets
            case 7000: return "img/snowy.png";
            //heavy ice pallets
            case 7101: return "img/snowy.png";
            //light ice pallets
            case 7102: return "img/snowy.png";
            //thunderstorm
            case 8000: return "img/stormy.png";
            //default
            default: return "img/questionmark.png";
        }
    }


    function updateSeries(listTemp, listPrec){
        var minTemp = 100
        var maxTemp = -100
        temperatureSeries.removePoints(0, listTemp.length)
        for(let i = 0; i < listTemp.length; i++)
        {
            if(minTemp > listTemp[i]) minTemp = listTemp[i]
            if(maxTemp < listTemp[i]) maxTemp = listTemp[i]

            temperatureSeries.insert(i, fullHourPlusX(i), listTemp[i])
        }
        tempAxisY.min = Math.floor(minTemp-1)
        tempAxisY.max = Math.floor(maxTemp+1)

        barSetData.remove(0, listPrec.length)
        barSetData.values = listPrec
        precAxisY.max = Math.ceil(Math.max.apply(Math, listPrec)+3)

        precAxisY.tickCount = precAxisY.max + 1
        tempAxisY.tickCount = tempAxisY.max - tempAxisY.min + 1
    }


    function hourCategories(){
        let list = [];
        for(let i = 0; i < 8; i++){
            list.push(Qt.formatDateTime(fullHourPlusX(i), "hh:00"))
        }
        return list;
    }

}


