/*
  QML-template of main window title bar
  Author: Rabinovich R.M.
  You can use & modificate the following code without any restrictions
  Date: 10.11.2017
*/
import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4

Rectangle {
    id: titleBar
    height: 30
    color: "#607D8B"

    property int buttonSize: 22
    property int buttonInterval: 5

    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
    }

    Image {
        width: 24
        height: 24
        fillMode: Image.PreserveAspectFit
        source: "qrc:/24px/app-icon.png"
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            leftMargin: 4
        }
    }

    //название приложения
    Text {
        id: title
        text: "Графический редактор v. 1.0 (2017)"
        color: "white"
        font.family: "Helvetica"
        font.pointSize: 12
        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }
    }

    //захват и перетаскивание окна путем нажатия на основную область
    MouseArea {
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        onDoubleClicked: {
            if (mainWindow.isNormal) {
                maxNormalBtnImg.source = "qrc:/24px/window-restore.png";
                mainWindow.isNormal = false;
                mainWindow.showMaximized();
                mainWindowContent.anchors.margins = 0;
            }
            else {
                maxNormalBtnImg.source = "qrc:/24px/window-maximize.png";
                mainWindow.isNormal = true;
                mainWindow.showNormal();
                mainWindowContent.anchors.margins = 10;
            }
        }

        onPressed: {
            previousX = mouseX
            previousY = mouseY
        }

        onMouseXChanged: {
            var dx = mouseX - previousX
            mainWindow.setX(mainWindow.x + dx)
        }

        onMouseYChanged: {
            var dy = mouseY - previousY
            mainWindow.setY(mainWindow.y + dy)
        }
    }

    Rectangle {
        id: appAboutBtn
        width: buttonSize
        height: buttonSize
        color: aboutBtnMouseArea.containsMouse ? "#506D6B" : "transparent"

        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: buttonInterval
        }

        Image {
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
            source: "qrc:/24px/window-about.png"
        }

        MouseArea {
            id: aboutBtnMouseArea
            hoverEnabled: true

            anchors {
                fill:parent
            }

            onClicked: {
                aboutWnd.show();
            }
        }

        ToolTip {
            id: aboutBtnTooltip
            text: "О программе";
            visible: aboutBtnMouseArea.containsMouse
        }
    }

    Rectangle {
        id: closeAppBtn
        width: buttonSize
        height: buttonSize
        color: closeAppBtnMouseArea.containsMouse ? "#506D6B" : "transparent"

        anchors {
            verticalCenter: parent.verticalCenter
            right: appAboutBtn.left
            rightMargin: buttonInterval
        }

        Image {
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
            source: "qrc:/24px/window-close.png"
        }

        MouseArea {
            id: closeAppBtnMouseArea
            hoverEnabled: true
            anchors {
                fill:parent
            }

            onClicked: {
                mainWindow.close()
            }

        }

        ToolTip {
            text: "Закрыть"
            visible: closeAppBtnMouseArea.containsMouse
        }
    }

    Rectangle {
        id: appWndMaxNormalBtn
        width: buttonSize
        height: buttonSize
        color: maxNormalBtnMouseArea.containsMouse ? "#506D6B" : "transparent"

        anchors {
            verticalCenter: parent.verticalCenter
            right: closeAppBtn.left
            rightMargin: buttonInterval
        }

        Image {
            id: maxNormalBtnImg
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
            source: (mainWindow.isNormal)? "qrc:/24px/window-maximize.png" : "qrc:/24px/window-restore.png";
        }

        MouseArea {
            id: maxNormalBtnMouseArea
            hoverEnabled: true

            anchors {
                fill:parent
            }

            onClicked: {
                if (mainWindow.isNormal) {
                    maxNormalBtnImg.source = "qrc:/24px/window-restore.png";
                    maxNormalBtnTooltip.text = "Свернуть в окно"
                    mainWindow.isNormal = false;
                    mainWindow.showMaximized();
                    mainWindowContent.anchors.margins = 0;
                }
                else {
                    maxNormalBtnImg.source = "qrc:/24px/window-maximize.png";
                    maxNormalBtnTooltip.text = "На весь экран"
                    mainWindow.isNormal = true;
                    mainWindow.showNormal();
                    mainWindowContent.anchors.margins = 10;
                }
            }

            ToolTip {
                id: maxNormalBtnTooltip
                text: (mainWindow.isNormal)? "На весь экран" : "Свернуть в окно";
                visible: maxNormalBtnMouseArea.containsMouse
            }
        }
    }

    Rectangle {
        id: appWndMinimizeBtn
        width: buttonSize
        height: buttonSize
        color: minimizeBtnMouseArea.containsMouse ? "#506D6B" : "transparent"

        anchors {
            verticalCenter: parent.verticalCenter
            right: appWndMaxNormalBtn.left
            rightMargin: buttonInterval
        }

        Image {
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
            source: "qrc:/24px/window-minimize.png"
        }

        MouseArea {
            id: minimizeBtnMouseArea
            hoverEnabled: true

            anchors {
                fill:parent
            }

            onClicked: {
                mainWindow.showMinimized();
            }
        }

        ToolTip {
            id: minimizeBtnTooltip
            text: "Свернуть";
            visible: minimizeBtnMouseArea.containsMouse
        }
    }


}
