/*
  QML-template of alert&warning windows
  Author: Rabinovich R.M.
  You can use & modificate the following code without any restrictions
  Date: 10.11.2017
*/

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.3
import QtGraphicalEffects 1.0

Window {
    id: alertifyWnd
    visible: false
    color: "#00000000"

    property Item alertifyTitle : alertifyTitle
    property Item textNode : textNode
    property Item alertifyTitleIcon : icon

    //отключаем штатную оконную обвязку
    flags: Qt.FramelessWindowHint | Qt.Window

    //размеры по умолчанию
    width: 300
    height: 250

    //минимальные размеры
    minimumWidth: 300
    minimumHeight: 250

    //максимальные размеры
    maximumWidth: 300
    maximumHeight: 250

    Rectangle {
        id: alertifyInner

        anchors.fill: parent
        anchors.margins: 10
        border.color: "gray"
        border.width: 1

        Rectangle {
            id: alertifyTitle

            anchors {
                top: alertifyInner.top
                left: alertifyInner.left
                right: alertifyInner.right
                topMargin: 1
                leftMargin: 1
                rightMargin: 1
            }

            height: parent.height/2

            Image {
                id: icon
                fillMode: Image.PreserveAspectFit
                sourceSize {
                    height: 64
                    width: 64
                }
                anchors.centerIn: alertifyTitle
            }

            Image {
                id: closeBtn
                fillMode: Image.PreserveAspectFit
                source: "qrc:/svg/alertify-close.svg"
                sourceSize {
                    height: 18
                    width: 18
                }
                anchors {
                    right: parent.right
                    top: parent.top
                    topMargin: 8
                    rightMargin: 8
                }

                ToolTip {
                    text: "Закрыть"
                    visible: closeBtnMouseArea.containsMouse
                }
            }

            MouseArea {
                id: closeBtnMouseArea
                anchors.fill: closeBtn
                hoverEnabled: true

                onClicked: {
                    alertifyWnd.close()
                }
            }
        }

        Rectangle {
            anchors {
                top: alertifyTitle.bottom
                bottom: alertifyInner.bottom
                left: alertifyInner.left
                right: alertifyInner.right
                bottomMargin: 1
                leftMargin: 1
                rightMargin: 1
            }

            Text {
                id: textNode
                font.family: "Helvetica"
                font.pointSize: 14
                anchors.centerIn: parent
                wrapMode: Text.WordWrap
                width: parent.width - 20
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    //тень главного окна
    DropShadow {
      id: shadow
      visible: true
      anchors.fill: alertifyInner
      horizontalOffset: 3
      verticalOffset: 3
      radius: 4
      samples: 7
      source: alertifyInner
      color: "darkgray"
    }

}
