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
    src/appsettings.cpp \
    src/appsettings.cpp \
    src/main.cpp

RESOURCES += qml/qml.qrc \
    qml/qml.qrc \
    icons/icons.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = qml

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH = qml

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    src/appsettings.h \
    src/appsettings.h

DISTFILES += \
    icons/24px/window-close.png \
    icons/24px/window-maximize.png \
    icons/24px/window-minimize.png \
    icons/24px/window-restore.png \
    icons/36px/window-close.png \
    icons/36px/window-maximize.png \
    icons/36px/window-minimize.png \
    icons/36px/window-restore.png \
    qml/AppWndTitleBar.qml \
    qml/main.qml
