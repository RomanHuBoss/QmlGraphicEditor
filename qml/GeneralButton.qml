/*
  QML-template of general button
  Author: Rabinovich R.M.
  You can use & modificate the following code without any restrictions
  Date: 10.11.2017
*/

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3

//описание типовой кнопки справа
Rectangle {
    property string btnImage
    property string btnText
    property string btnAlt
    property string btnTextColor: "white"
    property string gradientColor1: "#888888"
    property string gradientColor2: "#999999"
    property string gradientColor3: "#A5A5A5"
    property string defaultState: "normal"

    width: 100
    height: 100
    opacity: 1

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        onHoveredChanged: {
            if (parent.state === "disabled" || parent.state === "clicked") {
                return;
            }

            parent.state = containsMouse ? "hovered" : "normal"
        }

        onClicked: {
            if (parent.state === "disabled") {
                return;
            }

            state = (state === "clicked") ? "normal" : "clicked";

            //передаем контекст в ф-цию
            customClickHandler.call(mouseArea);
        }
    }

    anchors {
        margins: 0
    }

    //состояния кнопок
    states: [
        State {
            name: "disabled"
            PropertyChanges {
                target: mouseArea.parent
                opacity: 0.3
            }
        },
        State {
            name: "normal"
            PropertyChanges {
                target: mouseArea.parent
                gradientColor1: "#888888"
                gradientColor2: "#999999"
                gradientColor3: "#A5A5A5"
                opacity: 1
            }
        },
        State {
            name: "hovered"
            PropertyChanges {
                target: mouseArea.parent
                gradientColor1: "#8F8F8F"
                gradientColor2: "#9F9F9F"
                gradientColor3: "#BFAFAF"
                opacity: 1
            }
        },
        State {
            name: "clicked"
            PropertyChanges {
                target: mouseArea.parent
                gradientColor1: "#55666f"
                gradientColor2: "#77888f"
                gradientColor3: "#85959f"
                opacity: 1
            }
        }
    ]

    LinearGradient {
      anchors.fill: parent
      start: Qt.point(0, 10)
      end: Qt.point(50, 100)
      gradient: Gradient {
          GradientStop { position: 0.0; color: gradientColor1 }
          GradientStop { position: 0.5; color: gradientColor2 }
          GradientStop { position: 1.0; color: gradientColor3 }
      }
    }

    Image {
        id: buttonImage
        source: btnImage
        fillMode: Image.PreserveAspectFit
        width: 36
        height: 36

        anchors {
            top: parent.top
            topMargin: 16
            horizontalCenter: parent.horizontalCenter
        }

    }

    Text {
        id: buttonText
        text: btnText
        font.pixelSize: 11
        font.family: "Helvetica"
        font.bold: true
        color: btnTextColor

        anchors {
            top: buttonImage.bottom
            topMargin: 10
            horizontalCenter: parent.horizontalCenter
        }
    }

    //подсказка
    ToolTip {
        text: btnAlt
        visible: mouseArea.containsMouse && btnAlt !== ""

    }
}

