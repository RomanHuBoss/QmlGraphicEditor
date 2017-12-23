/*
  QML-template of about window
  Author: Rabinovich R.M.
  You can use & modificate the following code without any restrictions
  Date: 10.11.2017
*/

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.3
import QtGraphicalEffects 1.0

Window {
    id: aboutWnd
    visible: false

    color: "#00000000"

    //отключаем штатную оконную обвязку
    flags: Qt.FramelessWindowHint | Qt.Window

    //размеры по умолчанию
    width: 550
    height: 300

    //минимальные размеры
    minimumWidth: 550
    minimumHeight: 300

    //максимальные размеры
    maximumWidth: 550
    maximumHeight: 300

    Rectangle {
        id: aboutWindowContent
        anchors.fill: parent
        anchors.margins: 10

        Image {
            fillMode: Image.Stretch
            source: "qrc:/backgrounds/19.jpg"
            opacity: 0.7
            anchors.fill: parent
        }

        //добавляет заголовок окна
        AboutWndTitleBar {
            id: aboutWndTitle
        }

        //лого
        Image {
            id: logo
            fillMode: Image.PreserveAspectFit
            source: "qrc:/additional/logo.png"
            width: 200
            height: 200

            anchors {
                left: parent.left
                leftMargin: 30
                top: aboutWndTitle.bottom
                topMargin: 24
            }
        }

        Text {
            id: title
            text: "Графический редактор"

            anchors {
                left: logo.right
                leftMargin: 30
                top: logo.top
            }
        }

    }

    //тень главного окна
    DropShadow {
      id: shadow
      visible: true
      anchors.fill: aboutWindowContent
      horizontalOffset: 3
      verticalOffset: 3
      radius: 8
      samples: 12
      source: aboutWindowContent
      color: "gray"
    }

}
