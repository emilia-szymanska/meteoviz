import QtQuick 2.12
import QtQml 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtPositioning 5.12
//import QtQuick.Layouts 1.12
import QtCharts 2.15

ApplicationWindow {

    signal refresh()

    function setCityLabel(cityName)
    {
        textChosenCity.text = cityName
    }

    function datePlusX(value)
    {
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
        //console.log(list)
        var elements = [0.0, 0.0, 0.0, "", 0.0, 0.0, 0] // temp, press, windSpeed, windDir, precit, hum, code
        var j = 0;

        for(var i in list){
            elements[i%7] = list[i]

            if (i%7 == 6){
                console.log(j)
                console.log(elements)

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

    function returnSourcePath(code)
    {
        switch(code){
            case 0: return  "img/sun.png";
            case 1101: return "img/example.jpg";
            default: return "img/firework_transparent.gif";
        }
    }

    function updateTemperatureSeries(list){
        var min = 100
        var max = -100

        for(let i = 0; i < list.length; i++)
        {
            if(min > list[i]) min = list[i]
            if(max < list[i]) max = list[i]

            temperatureSeries.insert(i, fullHourPlusX(i), list[i])
        }
        tempAxisY.min = min-1
        tempAxisY.max = max+1
    }

    function updatePrecitipationSeries(list){
        var min = 100
        var max = -100

        for(let i = 0; i < list.length; i++)
        {
            if(min > list[i]) min = list[i]
            if(max < list[i]) max = list[i]

            precitipationSeries.insert(i, fullHourPlusX(i), list[i])
        }
        tempAxisY.min = min-1
        tempAxisY.max = max+1
    }

    function updateSeries(listTemp, listPrec){
        var minTemp = 100
        var maxTemp = -100
        var minPrec = 100
        var maxPrec = -100

        temperatureSeries.removePoints(0, listTemp.length)
        for(let i = 0; i < listTemp.length; i++)
        {
            if(minTemp > listTemp[i]) minTemp = listTemp[i]
            if(maxTemp < listTemp[i]) maxTemp = listTemp[i]

            temperatureSeries.insert(i, fullHourPlusX(i), listTemp[i])
        }
        tempAxisY.min = minTemp-1
        tempAxisY.max = maxTemp+1

        precitipationSeries.removePoints(0, listPrec.length)
        for(let j = 0; j < listPrec.length; j++)
        {
            if(minPrec > listPrec[j]) minPrec = listPrec[j]
            if(maxPrec < listPrec[j]) maxPrec = listPrec[j]

            precitipationSeries.insert(j, fullHourPlusX(j), listPrec[j])
        }
        console.log(listTemp)
        console.log(listPrec);
        //precitipationSeries.insert(0, "2014", [0.0, 1.0, 0.0, 0.0, 3.0, 0.0, 0.0, 0.0]);
        //precitipationSeries.insert(1, "hmmm2", listPrec);
        if(minPrec <= 1) precAxisY.min = minPrec
        else precAxisY.min = minPrec-1
        precAxisY.max = maxPrec+1
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
                    onClicked: refresh()
                }

                Button{
                    width: parent.width
                    height: parent.height * 0.5
                    text: qsTr("BACK")
                    highlighted: true
                    enabled: true
                    onClicked: {
                        appManager.changeWindow()
                    }
                }
            }

        }

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
                    //name: "SplineSeries"
                    //XYPoint { x: 1; y: 0.0 }
                    //XYPoint { x: 2; y: 3.2 }
                    //XYPoint { x: 3; y: 2.4 }
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
                    min: 0.0
                    max: 4
                    labelFormat: "%d mm"
                    labelsFont.bold: true
                }

                AreaSeries {
                    //id: precitipationSeries
                    axisX: precAxisXTime
                    axisY: precAxisY
                    upperSeries: LineSeries {
                        id: precitipationSeries}

                    //axisX: BarCategoryAxis { categories: ["2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014"] }

                }
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

    /*Loader{
        id:ld;
        anchors.fill: parent;
    }*/
}

