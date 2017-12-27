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

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var ctx = canvas.getContext('2d');
            ctx.strokeStyle = Qt.rgba(0, 0, 0, 1);
            ctx.lineWidth = 1;
            ctx.beginPath();
            ctx.moveTo(20, 100);//start point
            ctx.lineTo(150, 100);
            ctx.lineTo(150, 200);
            ctx.lineTo(20, 200);
            ctx.lineTo(20, 100);
            ctx.stroke();
        }
    }
}
