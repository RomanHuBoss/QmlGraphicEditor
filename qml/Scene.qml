/*
  QML-template of main scene area
  Author: Rabinovich R.M.
  You can use & modificate the following code without any restrictions
  Date: 10.11.2017
*/

import QtQuick 2.0

Rectangle {
    anchors {
        top: parent.top
        bottom: parent.bottom
        left: generalButtons.right
        right: parent.right
    }

    clip: true

    Image {
        fillMode: Image.Tile
        opacity: 0.2
        anchors.fill: parent
        source: "qrc:/backgrounds/scene-background.jpg"
    }

    MouseArea {
        id: sceneArea
        anchors.fill: parent

        onPressed: {
            console.log("clicked");
        }

        onMouseXChanged: {
            console.log("x changed");
        }

        onMouseYChanged: {
            console.log("y changed");
        }

    }
}
