import QtQuick 2.12
import QtQml 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtPositioning 5.12
import QtCharts 2.15

ApplicationWindow {
    id: weatherWindow
    objectName: "weatherWindow"
    width: 1200
    height: 900
    minimumWidth: 1200
    minimumHeight: 900
    visible: true
    title: qsTr("MeteoViz")

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


        ////////////////////////////////////////
        //// state + weather data + 3 buttons///

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
                titleFont.family: "Helvetica"
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
                    min: 0.0
                    max: 4
                    labelFormat: "%d&deg;C"
                    labelsFont.bold: true
                }

                SplineSeries {
                    id: temperatureSeries
                    axisX: tempAxisXTime
                    axisY: tempAxisY
                    color: "red"
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
                titleFont.family: "Helvetica"
                titleFont.bold: true
                titleFont.capitalization: Font.AllUppercase

                DateTimeAxis{
                    id: precAxisXTime
                    format: "hh:00"
                    min: fullHourPlusX(0)
                    tickCount: 8
                    max: fullHourPlusX(7)
                    labelsFont.bold: true

                }

                ValueAxis {
                    id: precAxisY
                    min: 0
                    max: 4
                    labelFormat: "%d mm"
                    labelsFont.bold: true
                }

                BarCategoryAxis {
                    id: barCategories
                    categories: hourCategories()
                }

                BarSeries {
                    id: precitipationSeries
                    axisX: barCategories
                    axisY: precAxisY
                    barWidth: 1
                    BarSet {
                        id: barSetData
                        values: [2, 2, 3, 4, 5, 6]
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
                        id: imageState1
                        width: parent.width * 0.4
                        height: parent.height
                        source: "img/sun.png"
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
                        id: imageState2
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
                        id: imageState3
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
            case 0: return  "img/sun.png";
            case 1101: return "img/example.jpg";
            default: return "img/firework_transparent.gif";
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
        tempAxisY.min = minTemp-1
        tempAxisY.max = maxTemp+1

        barSetData.remove(0, listPrec.length)
        barSetData.values = listPrec
        precAxisY.max = Math.max.apply(Math, listPrec)+3
    }


    function hourCategories(){
        let list = [];
        for(let i = 0; i < 8; i++){
            list.push(Qt.formatDateTime(fullHourPlusX(i), "hh:00"))
        }
        return list;
    }

}


