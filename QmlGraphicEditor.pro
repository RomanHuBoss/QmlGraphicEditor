QT += quick
CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += src/main.cpp \
    src/main.cpp \
    src/point.cpp \
    src/figure.cpp \
    src/linesegment.cpp \
    src/triangle.cpp \
    src/rectangle.cpp \
    src/square.cpp \
    src/figuresstorage.cpp \
    src/multiline.cpp \
    src/qtqmlinteractor.cpp

RESOURCES += qml/qml.qrc \
    qml/qml.qrc \
    icons/icons.qrc \
    backgrounds/backgrounds.qrc \
    additional/additional.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = qml

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH = qml

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    src/point.h \
    src/figure.h \
    src/linesegment.h \
    src/geometry.h \
    src/triangle.h \
    src/rectangle.h \
    src/square.h \
    src/figuresstorage.h \
    src/multiline.h \
    src/qtqmlinteractor.h

DISTFILES += \
    qml/AppWndTitleBar.qml \
    qml/GeneralButtons.qml \
    qml/Scene.qml \
    qml/AboutWnd.qml \
    qml/AboutWndTitleBar.qml \
    qml/main.qml \
    qml/GeneralButton.qml \
    qml/Alertify.qml \
    qml/CustomFileDialog.qml \
    qml/Figure.qml \
    qml/BBoxActionPoint.qml \
    qml/CustomColorPicker.qml

