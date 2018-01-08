import QtQuick 2.9

Rectangle {
    id: root
    width: 10
    height: 10

    border {
        width: 2
        color: "blue"
    }
    opacity: 1

    property string position

    radius: (mainWindow.mode === "RotateFigure") ? width * 0.5 : 0
    color: (["SelectFigure", "FillFigure", "RemoveFigure"].indexOf(mainWindow.mode) !== -1) ?
               "blue" : "white"

    visible: (function() {
        //console.log("First :" + root.parent + "/ Second:" + scene.activeFigure);

        var isVisible = root.parent === scene.activeFigure &&
        ( mainWindow.mode === "SelectFigure" ||
        mainWindow.mode === "FillFigure" ||
        mainWindow.mode === "ResizeFigure" ||
        mainWindow.mode === "RemoveFigure" ||
        (mainWindow.mode === "RotateFigure" && position.toLowerCase().indexOf("middle") === -1))
        //console.log(isVisible);

        return isVisible;
    })();

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
        property double previousX
        property double previousY

        cursorShape: (function() {
            if (mainWindow.mode === "RotateFigure") return Qt.OpenHandCursor;
            else if (mainWindow.mode === "SelectFigure") return Qt.ForbiddenCursor;
            else if (mainWindow.mode === "FillFigure") return Qt.ForbiddenCursor;
            else if (mainWindow.mode === "RemoveFigure") return Qt.ForbiddenCursor;
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

            if (mainWindow.mode === "ResizeFigure") {
                var dx = mouseX - previousX

                if (position.toLowerCase().indexOf("left") !== -1) {
                    if (root.parent.width - dx >= root.parent.minWidth) {
                        root.parent.offsetLeft += dx;
                        root.parent.width += -dx;
                        root.parent.scaleLeft += dx;

                        if (root.parent.type === "Square") {
                            root.parent.offsetTop += dx;
                            root.parent.height += -dx;
                            root.parent.scaleTop += dx;
                        }
                    }
                }
                else if (position.toLowerCase().indexOf("right") !== -1) {
                    if (root.parent.width + dx >= root.parent.minWidth) {
                        root.parent.width += dx;
                        root.parent.scaleRight += dx;

                        if (root.parent.type === "Square") {
                            root.parent.height += dx;
                            root.parent.scaleBottom += dx;
                        }
                    }
                }
            }
            else if (mainWindow.mode === "RotateFigure") {
                var dAx = mouseX - root.parent.centralPointX;
                var dAy = mouseY - root.parent.centralPointY;
                var dBx = previousX - root.parent.centralPointX;
                var dBy = previousY - root.parent.centralPointY;

                var angle = Math.atan2(dAx * dBy - dAy * dBx, dAx * dBx + dAy * dBy);
                //if(angle < 0) {angle = angle * -1;}
                var degree_angle = angle * (180 / Math.PI);

                if (degree_angle > 1) degree_angle = 1;
                if (degree_angle < -1) degree_angle = -1;

                console.log(degree_angle);
                root.parent.rotationAngle += degree_angle;
            }
        }

        onMouseYChanged: {
            if (!isPressed) {
                return;
            }

            if (mainWindow.mode === "ResizeFigure") {
                var dy = mouseY - previousY

                if (position.toLowerCase().indexOf("top") !== -1) {
                    if (root.parent.height - dy >= root.parent.minHeight) {
                        root.parent.offsetTop += dy;
                        root.parent.height += -dy;
                        root.parent.scaleBottom -= dy;

                        if (root.parent.type === "Square") {
                            root.parent.offsetLeft += dy;
                            root.parent.width += -dy;
                            root.parent.scaleLeft += -dy;
                        }


                    }
                }
                else if (position.toLowerCase().indexOf("bottom") !== -1) {
                    if (root.parent.height + dy >= root.parent.minHeight) {
                        root.parent.height += dy;
                        root.parent.scaleTop += dy;

                        if (root.parent.type === "Square") {
                            root.parent.width += dy;
                            root.parent.scaleLeft += dy;
                        }

                    }
                }
            }
            else if (mainWindow.mode === "RotateFigure") {
                var dAx = mouseX - root.parent.centralPointX;
                var dAy = mouseY - root.parent.centralPointY;
                var dBx = previousX - root.parent.centralPointX;
                var dBy = previousY - root.parent.centralPointY;

                var angle = Math.atan2(dAx * dBy - dAy * dBx, dAx * dBx + dAy * dBy);
                //if(angle < 0) {angle = angle * -1;}
                var degree_angle = angle * (180 / Math.PI);

                if (degree_angle > 1) degree_angle = 1;
                if (degree_angle < -1) degree_angle = -1;

                console.log(degree_angle);
                root.parent.rotationAngle += degree_angle;
            }
        }

        onReleased: {
            isPressed = false;
            scene.updateFigure(root.parent);
        }

    }
}
