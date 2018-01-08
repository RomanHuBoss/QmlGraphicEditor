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
    /*режим работы приложения:
    SelectFigure    - выбор фигуры для ее перемещения, окрашивания, удаления
    RotateFigure    - поворот фигуры
    ResizeFigure    - изменение размера фигуры
    RemoveFigure    - удаление фигур с экрана
    FillFigure      - заливка фигуры цветом
    DrawLineSegment - рисует отрезок
    DrawMultiline   - рисует полигон
    DrawTriangle    - рисование треугольника
    DrawRectangle   - рисование прямоугольника
    DrawSquare      - рисование квадрата
    */
    property string mode

    id: mainWindow
    visible: true
    color: "transparent"

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
    property var scene: scene
    property var buttons: generalButtons

    onModeChanged: {
        generalButtons.resetModeButtons();

        if (["DrawLineSegment",  "DrawMultiline", "DrawTriangle", "DrawRectangle", "DrawSquare"].indexOf(mode) !== -1)
            scene.prevMode = "";
    }

    Rectangle {
        id: mainWindowContent
        anchors.fill: parent
        anchors.margins: 10        
        border.color: "gray"
        border.width: 1

        //добавляем диалог ошибок/предупреждений
        Alertify {
            id: alertifyWnd
        }

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
               Layout.fillWidth: true
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

    Connections {
        target: appInteractor
        onRaiseAlertifyError: {
            alertifyWnd.visible = true;
            alertifyWnd.alertifyTitle.color = "#e95350";
            alertifyWnd.alertifyTitleIcon.source = "qrc:/svg/error-msg.svg";
            alertifyWnd.textNode.text = text;
        }
        onRaiseAlertifyWarning: {
            alertifyWnd.visible = true;
            alertifyWnd.alertifyTitle.color = "#e9b850";
            alertifyWnd.alertifyTitleIcon.source = "qrc:/svg/warning-msg.svg";
            alertifyWnd.textNode.text = text;
        }
        onRaiseAlertifyInfo: {
            alertifyWnd.visible = true;
            alertifyWnd.alertifyTitle.color = "#18a2c6";
            alertifyWnd.alertifyTitleIcon.source = "qrc:/svg/info-msg.svg";
            alertifyWnd.textNode.text = text;
        }
        onRaiseDrawFigureOnScene: {
            scene.addNewFigure(data);
        }
        onRaiseRemoveQmlFigure: {
            scene.removeFigure(scene.getFigureByUid(uuid));
        }
    }
}
