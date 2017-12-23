/*
  QML-template of application main window
  Author: Rabinovich R.M.
  You can use & modificate the following code without any restrictions
  Date: 10.11.2017
*/

import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Window 2.3
import QtGraphicalEffects 1.0

//главное окно QML-приложения
ApplicationWindow {

    id: mainWindow
    visible: true
    color: "#00000000"

    //отключаем штатную оконную обвязку
    flags: Qt.FramelessWindowHint | Qt.Window

    //размеры по умолчанию
    width: 1024
    height: 768

    property int previousX
    property int previousY
    property int borderSize: 3
    property int cornerSize: 5

    Rectangle {
        id: mainWindowContent
        anchors.fill: parent
        anchors.margins: mainWindow.visibility === Window.FullScreen ? 0 : 10

        //добавляет заголовок окна
        AppWndTitleBar {
        }


        //ресайз за верхний бордер
        MouseArea {
            id: topArea
            height: borderSize

            anchors {
                top: parent.top
                left: parent.left
                leftMargin: cornerSize
                right: parent.right
                rightMargin: cornerSize
            }

            cursorShape: Qt.SizeVerCursor

            onPressed: {
                previousY = mouseY
            }

            onMouseYChanged: {
                var dy = mouseY - previousY
                mainWindow.setY(mainWindow.y + dy)
                mainWindow.setHeight(mainWindow.height - dy)
            }
        }

        //ресайз за нижний бордер
        MouseArea {
            id: bottomArea
            height: borderSize

            anchors {
                bottom: parent.bottom
                left: parent.left
                leftMargin: cornerSize
                right: parent.right
                rightMargin: cornerSize
            }

            cursorShape: Qt.SizeVerCursor

            onPressed: {
                previousY = mouseY
            }

            onMouseYChanged: {
                var dy = mouseY - previousY
                mainWindow.setHeight(mainWindow.height + dy)
            }
        }

        //ресайз за левый бордер
        MouseArea {
            id: leftArea
            width: borderSize
            anchors {
                left: parent.left
                top: topArea.bottom
                topMargin: cornerSize
                bottom: bottomArea.top
                bottomMargin: cornerSize
            }
            cursorShape: Qt.SizeHorCursor

            onPressed: {
                previousX = mouseX
            }

            onMouseXChanged: {
                var dx = mouseX - previousX
                mainWindow.setX(mainWindow.x + dx)
                mainWindow.setWidth(mainWindow.width - dx)
            }
        }

        //ресайз за правый бордер
        MouseArea {
            id: rightArea
            width: borderSize
            anchors {
                right: parent.right
                top: topArea.bottom
                topMargin: cornerSize
                bottom: bottomArea.top
                bottomMargin: cornerSize
            }
            cursorShape:  Qt.SizeHorCursor

            onPressed: {
                previousX = mouseX
            }

            onMouseXChanged: {
                var dx = mouseX - previousX
                mainWindow.setWidth(mainWindow.width + dx)
            }
        }

        //ресайз за пересечение сверху слева
        MouseArea {
            id: topLeftArea
            height: cornerSize
            width: cornerSize
            anchors {
                top: parent.top
                left: parent.left
            }

            cursorShape:  Qt.SizeFDiagCursor

            onPressed: {
                previousX = mouseX
                previousY = mouseY
            }

            onMouseXChanged: {
                var dx = mouseX - previousX
                mainWindow.setX(mainWindow.x + dx)
                mainWindow.setWidth(mainWindow.width - dx)
            }

            onMouseYChanged: {
                var dy = mouseY - previousY
                mainWindow.setY(mainWindow.y + dy)
                mainWindow.setHeight(mainWindow.height - dy)
            }
        }

        //ресайз за пересечение сверху справа
        MouseArea {
            id: topRightArea
            height: cornerSize
            width: cornerSize
            anchors {
                top: parent.top
                right: parent.right
            }

            cursorShape:  Qt.SizeBDiagCursor

            onPressed: {
                previousX = mouseX
                previousY = mouseY
            }

            onMouseXChanged: {
                var dx = mouseX - previousX
                mainWindow.setWidth(mainWindow.width + dx)
            }

            onMouseYChanged: {
                var dy = mouseY - previousY
                mainWindow.setY(mainWindow.y + dy)
                mainWindow.setHeight(mainWindow.height - dy)
            }
        }

        //ресайз за пересечение снизу слева
        MouseArea {
            id: bottomLeftArea
            height: cornerSize
            width: cornerSize

            anchors {
                bottom: parent.bottom
                left: parent.left
            }

            cursorShape:  Qt.SizeBDiagCursor

            onPressed: {
                previousX = mouseX
                previousY = mouseY
            }

            onMouseXChanged: {
                var dx = mouseX - previousX
                mainWindow.setX(mainWindow.x + dx)
                mainWindow.setWidth(mainWindow.width - dx)
            }

            onMouseYChanged: {
                var dy = mouseY - previousY
                mainWindow.setHeight(mainWindow.height + dy)
            }
        }

        //ресайз за пересечение снизу справа
        MouseArea {
            id: bottomRightArea
            height: cornerSize
            width: cornerSize

            anchors {
                bottom: parent.bottom
                right: parent.right
            }

            cursorShape:  Qt.SizeFDiagCursor

            onPressed: {
                previousX = mouseX
                previousY = mouseY
            }

            onMouseXChanged: {
                var dx = mouseX - previousX
                mainWindow.setWidth(mainWindow.width + dx)
            }

            onMouseYChanged: {
                var dy = mouseY - previousY
                mainWindow.setHeight(mainWindow.height + dy)
            }
        }
    }


    //тень главного окна
    DropShadow {
      anchors.fill: mainWindowContent
      horizontalOffset: 2
      verticalOffset: 2
      radius: 5
      samples: 10
      source: mainWindowContent
      color: "black"
      Behavior on radius { PropertyAnimation { duration: 100 } }
    }

}
