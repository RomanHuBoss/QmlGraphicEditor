import QtQuick 2.9

Rectangle {
    id: root
    width: 10
    height: 10
    color: "white"
    border {
        width: 2
        color: "blue"
    }
    opacity: 1

    property string position

    visible: (mainWindow.mode === "resize" || (mainWindow.mode === "rotate" && position.toLowerCase().indexOf("middle") === -1))

    anchors {
        horizontalCenter: (function() {
            if (position.toLowerCase().indexOf("left") !== -1) return parent.left;
            else if (position.toLowerCase().indexOf("right") !== -1) return parent.right;
            else if (position.toLowerCase().indexOf("middle") !== -1) return parent.horizontalCenter;
        })()

        verticalCenter: (function() {
            if (position.toLowerCase().indexOf("top") !== -1) return parent.top;
            else if (position.toLowerCase().indexOf("bottom") !== -1) return parent.bottom;
            else if (position.toLowerCase().indexOf("middle") !== -1) return parent.verticalCenter;
        })()
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        property bool isPressed: false

        cursorShape: (function() {
            if (mainWindow.mode === "rotate") return Qt.OpenHandCursor;
            else if (position === "topLeft") return Qt.SizeFDiagCursor;
            else if (position === "bottomLeft") return Qt.SizeBDiagCursor;
            else if (position === "topRight") return Qt.SizeBDiagCursor;
            else if (position === "bottomRight") return Qt.SizeFDiagCursor;
            else if (position === "leftMiddle") return Qt.SizeHorCursor;
            else if (position === "rightMiddle") return Qt.SizeHorCursor;
            else if (position === "topMiddle") return Qt.SizeVerCursor;
            else if (position === "bottomMiddle") return Qt.SizeVerCursor;
        })()

        onPressed: {
            isPressed = true
            previousX = mouseX
            previousY = mouseY
        }

        onMouseXChanged: {
            if (!isPressed) {
                return;
            }

            if (mainWindow.mode === "resize") {
                var dx = mouseX - previousX

                if (position.toLowerCase().indexOf("left") !== -1) {
                    if (root.parent.width - dx >= root.parent.minWidth) {
                        root.parent.offsetLeft += dx;
                        root.parent.width += -dx;
                    }
                }

                if (position.toLowerCase().indexOf("right") !== -1) {
                    if (root.parent.width + dx >= root.parent.minWidth) {
                        root.parent.width += dx;
                    }
                }
            }
        }

        onMouseYChanged: {
            if (!isPressed) {
                return;
            }

            if (mainWindow.mode === "resize") {
                var dy = mouseY - previousY

                if (position.toLowerCase().indexOf("top") !== -1) {
                    if (root.parent.height - dy >= root.parent.minHeight) {
                        root.parent.offsetTop += dy;
                        root.parent.height += -dy;
                    }
                }

                if (position.toLowerCase().indexOf("bottom") !== -1) {
                    if (root.parent.height + dy >= root.parent.minHeight) {
                        root.parent.height += dy;
                    }
                }
            }
        }

        onReleased: {
            isPressed = false;
        }

        onHoveredChanged: {
            //parent.state = containsMouse ? "hovered" : "normal"
        }
    }
}
