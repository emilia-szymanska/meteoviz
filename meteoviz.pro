QT += quick widgets location charts

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        app_manager.cpp \
        citychoice_manager.cpp \
        main.cpp \
        url_connection.cpp \
        weather_manager.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES +=

HEADERS += \
    additional_structs.h \
    app_manager.h \
    citychoice_manager.h \
    url_connection.h \
    weather_manager.h

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../../Biblioteki/curl-7.75.0-win64-mingw/lib/ -llibcurl.dll
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../../Biblioteki/curl-7.75.0-win64-mingw/lib/ -llibcurl.dll

INCLUDEPATH += $$PWD/../../Biblioteki/curl-7.75.0-win64-mingw/include
DEPENDPATH += $$PWD/../../Biblioteki/curl-7.75.0-win64-mingw/include

win32: LIBS += -L$$PWD/../../Biblioteki/OpenSSL-Win64/lib/ -lopenssl

INCLUDEPATH += $$PWD/../../Biblioteki/OpenSSL-Win64/include
DEPENDPATH += $$PWD/../../Biblioteki/OpenSSL-Win64/include
