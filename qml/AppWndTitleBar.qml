/*
  QML-template of main window title bar
  Author: Rabinovich R.M.
  You can use & modificate the following code without any restrictions
  Date: 10.11.2017
*/
import QtQuick 2.8

Rectangle {
    height: 30
    color: "gray"

    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
    }

    //захват и перетаскивание окна путем нажатия на основную область
    MouseArea {
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        onDoubleClicked: {
            if(mouse.button === Qt.RightButton) {

                console.log("Double Click");
            }
        }

        onPressed: {
            previousX = mouseX
            previousY = mouseY
        }

        onMouseXChanged: {
            var dx = mouseX - previousX
            mainWindow.setX(mainWindow.x + dx)
        }

        onMouseYChanged: {
            var dy = mouseY - previousY
            mainWindow.setY(mainWindow.y + dy)
        }
    }
}
