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

    Figure {
        width: 300
        height: 300
        offsetLeft: 20
        offsetTop: 50
    }

    /*Item {
        id: container;
        width: 250;
        height: width;
        anchors.centerIn: parent;

        property real centerX : (width / 2);
        property real centerY : (height / 2);

        Rectangle{
            id: rect;
            color: "white";
            transformOrigin: Item.Center;
            radius: (width / 2);
            antialiasing: true;
            anchors.fill: parent;

            Rectangle {
                id: handle;
                color: "red";
                width: 50;
                height: width;
                radius: (width / 2);
                antialiasing: true;
                anchors {
                    top: parent.top;
                    margins: 10;
                    horizontalCenter: parent.horizontalCenter;
                }

                MouseArea{
                    anchors.fill: parent;
                    onPositionChanged:  {
                        var point =  mapToItem (container, mouse.x, mouse.y);
                        var diffX = (point.x - container.centerX);
                        var diffY = -1 * (point.y - container.centerY);
                        var rad = Math.atan (diffY / diffX);
                        var deg = (rad * 180 / Math.PI);
                        if (diffX > 0 && diffY > 0) {
                            rect.rotation = 90 - Math.abs (deg);
                        }
                        else if (diffX > 0 && diffY < 0) {
                            rect.rotation = 90 + Math.abs (deg);
                        }
                        else if (diffX < 0 && diffY > 0) {
                            rect.rotation = 270 + Math.abs (deg);
                        }
                        else if (diffX < 0 && diffY < 0) {
                            rect.rotation = 270 - Math.abs (deg);
                        }
                    }
                }
            }
        }
        Text {
            text: "%1 secs".arg (Math.round (rect.rotation / 6));
            font {
                pixelSize: 20;
                bold: true;
            }
            anchors.centerIn: parent;
        }
    }*/

    /*MouseArea {
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

    }*/
}
