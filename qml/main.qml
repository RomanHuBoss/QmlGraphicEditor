/*
  QML-template of application main window
  Author: Rabinovich R.M.
  You can use & modificate the following code without any restrictions
  Date: 10.11.2017
*/

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.3
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3

//главное окно QML-приложения
ApplicationWindow {

    id: mainWindow
    visible: true
    color: "#00000000"

    //отключаем штатную оконную обвязку
    flags: Qt.FramelessWindowHint | Qt.Window

    //размеры по умолчанию
    width: 1100
    height: 860

    //минимальные размеры
    minimumWidth: 640
    minimumHeight: 480

    property int previousX
    property int previousY
    property int borderSize: 3
    property int cornerSize: 5

    property bool isNormal: true

    Rectangle {
        id: mainWindowContent
        anchors.fill: parent
        anchors.margins: 10        
        border.color: "gray"
        border.width: 1

        //добавляем диалог "О программе"
        AboutWnd {
            id: aboutWnd
        }

        //добавляет заголовок окна
        AppWndTitleBar {
            id: titleBar
        }

        //главный компоновщик (для кнопок слева и сцены справа)
        RowLayout {
           id: mainLayout
           spacing: 6

           anchors {
               top: titleBar.bottom
               left: mainWindowContent.left
               right: mainWindowContent.right
               bottom: mainWindowContent.bottom
               leftMargin: 1
               bottomMargin: 1
           }

           //главные кнопки приложения
           GeneralButtons {
               id: generalButtons
           }

           //сцена приложения
           Scene {
               id: scene
           }
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
                if ((mainWindow.height - dy) >= mainWindow.minimumHeight) {
                    mainWindow.setY(mainWindow.y + dy)
                    mainWindow.setHeight(mainWindow.height - dy)
                }
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
                if ((mainWindow.height + dy) >= mainWindow.minimumHeight) {
                    mainWindow.setHeight(mainWindow.height + dy)
                }
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
                if ((mainWindow.width - dx) >= mainWindow.minimumWidth) {
                    mainWindow.setX(mainWindow.x + dx)
                    mainWindow.setWidth(mainWindow.width - dx)
                }
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
                if ((mainWindow.width + dx) >= mainWindow.minimumWidth) {
                    mainWindow.setWidth(mainWindow.width + dx)
                }
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
                if ((mainWindow.width - dx) >= mainWindow.minimumWidth) {
                    mainWindow.setX(mainWindow.x + dx)
                    mainWindow.setWidth(mainWindow.width - dx)
                }
            }

            onMouseYChanged: {
                var dy = mouseY - previousY
                if ((mainWindow.height - dy) >= mainWindow.minimumHeight) {
                    mainWindow.setY(mainWindow.y + dy)
                    mainWindow.setHeight(mainWindow.height - dy)
                }
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
                if ((mainWindow.width + dx) >= mainWindow.minimumWidth) {
                    mainWindow.setWidth(mainWindow.width + dx)
                }
            }

            onMouseYChanged: {
                var dy = mouseY - previousY
                if ((mainWindow.height - dy) >= mainWindow.minimumHeight) {
                    mainWindow.setY(mainWindow.y + dy)
                    mainWindow.setHeight(mainWindow.height - dy)
                }
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
                if ((mainWindow.width - dx) >= mainWindow.minimumWidth) {
                    mainWindow.setX(mainWindow.x + dx)
                    mainWindow.setWidth(mainWindow.width - dx)
                }
            }

            onMouseYChanged: {
                var dy = mouseY - previousY
                if ((mainWindow.height + dy) >= mainWindow.minimumHeight) {
                    mainWindow.setHeight(mainWindow.height + dy)
                }
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
                if ((mainWindow.width + dx) >= mainWindow.minimumWidth) {
                    mainWindow.setWidth(mainWindow.width + dx)
                }
            }

            onMouseYChanged: {
                var dy = mouseY - previousY
                if ((mainWindow.height + dy) >= mainWindow.minimumHeight) {
                    mainWindow.setHeight(mainWindow.height + dy)
                }
            }
        }
    }


    //тень главного окна
    DropShadow {
      id: shadow
      visible: true
      anchors.fill: mainWindowContent
      horizontalOffset: 3
      verticalOffset: 3
      radius: 4
      samples: 7
      source: mainWindowContent
      color: "darkgray"
    }

}
