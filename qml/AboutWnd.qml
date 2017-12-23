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
    width: 600
    height: 330

    //минимальные размеры
    minimumWidth: 600
    minimumHeight: 330

    //максимальные размеры
    maximumWidth: 600
    maximumHeight: 330

    Rectangle {
        id: aboutWindowContent
        anchors.fill: parent
        anchors.margins: 10
        border.color: "gray"
        border.width: 1

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
                topMargin: 34
            }
        }

        Text {
            id: title
            text: "Графический редактор"
            font.pixelSize: 20
            font.bold: true
            color: "white"
            wrapMode: Text.WordWrap

            anchors {
                left: logo.right
                leftMargin: 25
                top: logo.top
                topMargin: -7
                right: parent.right
                rightMargin: 12
            }

            layer.enabled: true
            layer.effect: DropShadow {
                verticalOffset: 1
                color: "#80000000"
                radius: 1
                samples: 2
            }
        }

        Text {
            id: version
            text: "Версия: 1.0 (2017) / Автор: Рабинович Р.М."
            font.pixelSize: 11
            font.bold: false
            color: "black"
            wrapMode: Text.WordWrap

            anchors {
                left: title.left
                top: title.bottom
                topMargin: 12
                right: parent.right
                rightMargin: 12
            }
        }

        Text {
            id: about
            text: "Программа демонстрирует некоторые возможности создания графических примитивов средствами QML и C++ фреймворка Qt"
            font.pixelSize: 14
            font.bold: false
            color: "black"
            wrapMode: Text.WordWrap

            anchors {
                left: version.left
                top: version.bottom
                topMargin: 10
                right: parent.right
                rightMargin: 12
            }
        }

        Text {
            id: author
            text: "Программа предоставляется на условиях «как есть» (as is). Автор не даёт никаких гарантий в отношении бесперебойной работы Программы и в отсутствии ошибок в Программе. Автор не несет ответственности за прямой, косвенный или другие виды ущерба, в т.ч. потерю данных, повреждения или любые другие виды потерь, связанные с использованием Программы (правильным или неправильным)."
            font.pixelSize: 11
            font.bold: false
            color: "black"
            wrapMode: Text.WordWrap

            anchors {
                left: about.left
                top: about.bottom
                topMargin: 10
                right: parent.right
                rightMargin: 12
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
      radius: 4
      samples: 7
      source: aboutWindowContent
      color: "darkgray"
    }

}
