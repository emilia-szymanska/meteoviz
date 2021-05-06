QT += quick widgets location charts

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        src/app_manager.cpp \
        src/citychoice_manager.cpp \
        src/main.cpp \
        src/url_connection.cpp \
        src/weather_manager.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


HEADERS += \
    inc/additional_structs.h \
    inc/app_manager.h \
    inc/citychoice_manager.h \
    inc/url_connection.h \
    inc/weather_manager.h
