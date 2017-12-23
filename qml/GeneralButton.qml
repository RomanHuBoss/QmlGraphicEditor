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


Rectangle {
    width: 100
    height: 100
    //color: "#9E9E9E"
    //opacity: 0.7

    LinearGradient {
      anchors.fill: parent
      start: Qt.point(0, 0)
      end: Qt.point(0, 100)
      gradient: Gradient {
          GradientStop { position: 0.0; color: "#888888" }
          GradientStop { position: 1.0; color: "#999999" }
      }
    }

    anchors {
        margins: 0
    }

    property string btnImage
    property string btnText

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

    MouseArea {
        anchors.fill: parent
    }

    Text {
        id: buttonText
        text: btnText
        font.pixelSize: 11
        font.family: "Helvetica"
        font.bold: true
        color: "white"

        anchors {
            top: buttonImage.bottom
            topMargin: 10
            horizontalCenter: parent.horizontalCenter
        }
    }


}

