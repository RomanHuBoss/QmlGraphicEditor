/*
  QML-template of About window title bar
  Author: Rabinovich R.M.
  You can use & modificate the following code without any restrictions
  Date: 10.11.2017
*/
import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4

Rectangle {
    id: titleBar
    height: 30
    color: "gray"

    property int buttonSize: 22
    property int buttonInterval: 5

    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
    }

    Image {
        width: 24
        height: 24
        fillMode: Image.PreserveAspectFit
        source: "qrc:/24px/app-icon.png"
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            leftMargin: 4
        }
    }

    //название приложения
    Text {
        id: title
        text: "О программе"
        color: "white"
        font.family: "Helvetica"
        font.pointSize: 12
        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }
    }

    //захват и перетаскивание окна путем нажатия на заголовке
    MouseArea {
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        onPressed: {
            previousX = mouseX
            previousY = mouseY
        }

        onMouseXChanged: {
            var dx = mouseX - previousX
            aboutWnd.setX(aboutWnd.x + dx)
        }

        onMouseYChanged: {
            var dy = mouseY - previousY
            aboutWnd.setY(aboutWnd.y + dy)
        }
    }

    Rectangle {
        id: closeBtn
        width: buttonSize
        height: buttonSize
        color: closeBtnMouseArea.containsMouse ? "darkgray" : "transparent"

        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: buttonInterval
        }

        Image {
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
            source: "qrc:/24px/window-close.png"
        }

        MouseArea {
            id: closeBtnMouseArea
            hoverEnabled: true
            anchors {
                fill:parent
            }

            onClicked: {
                aboutWnd.close()
            }
        }

        ToolTip {
            text: "Закрыть"
            visible: closeBtnMouseArea.containsMouse
        }
    }

}
