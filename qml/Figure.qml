import QtQuick 2.9

Rectangle {
    id: figure
    color: "transparent"

    /*
    тип фигуры
    LineSegment - отрезок
    Multiline   - ломаная/полигон
    Triangle    - треугольник
    Rectangle   - прямоугольник
    Square      - квадрат
    */
    property string type
    property string uid            //идентификатор фигуры, синхронизированный с хранилищем
    property variant vertices: []  //массив вершин {x,y}
    property bool isClosed         //признак замкнутой фигуры

    property double offsetLeft: 0   //смещение описывающего прямоугольника по x
    property double offsetTop: 0    //смещение описывающего прямоугольника по y
    property double minWidth: 20    //минимальная ширина описывающего прямоугольника
    property double minHeight: 20   //минимальная высота описываюшего прямоугольника

    property int strokeWidth: 1                 //ширина линии фигуры
    property string strokeColor: "#000000"      //цвет линии
    property bool isFilled                      //признак заливки
    property string fillColor                   //цвет заливки

    property double centralPointX: width/2      //X-координата центральной точки
    property double centralPointY: height/2     //Y-координата центральной точки
    property double rotationAngle: 0            //угол поворота

    property double movedX: anchors.leftMargin - offsetLeft
    property double movedY: anchors.topMargin - offsetTop

    transform: Rotation {
        origin.x: centralPointX;
        origin.y: centralPointY;
        angle: rotationAngle
    }

    anchors {
        left: parent.left
        top: parent.top
        leftMargin: offsetLeft
        topMargin: offsetTop
    }

    Canvas {
        id: bboxCanvas

        visible: true
        anchors.fill:parent

        onPaint: {
            if (parent.vertices.length < 2)
                return;

            var ctx = getContext("2d");
            ctx.strokeStyle = strokeColor;
            ctx.lineWidth = strokeWidth;
            ctx.beginPath();
            ctx.moveTo(parent.vertices[0].x, parent.vertices[0].y);

            for (var i = 1; i < parent.vertices.length; i++) {
                ctx.lineTo(parent.vertices[i].x, parent.vertices[i].y);
            }

            if (parent.vertices.length > 2 && parent.isClosed) {
                ctx.lineTo(parent.vertices[0].x, parent.vertices[0].y);
                ctx.closePath();
            }

            if (parent.isClosed && parent.isFilled && parent.fillColor.length > 0) {
                ctx.fillStyle = parent.fillColor;
                ctx.fill();
            }

            ctx.stroke();
        }

        MouseArea {
            id: mouseArea
            anchors.fill: bboxCanvas === parent ? parent : null;
            hoverEnabled: true
            property bool isPressed: false

            onPressed: {
                isPressed = true
                previousX = mouseX
                previousY = mouseY

                if (["SelectFigure", "ResizeFigure", "RotateFigure"].indexOf(mainWindow.mode) !== -1 &&
                        scene.activeFigure !== figure) {
                    scene.activeFigure = figure;
                }
                else if (mainWindow.mode === "RemoveFigure") {
                    scene.removeFigure(figure);
                }
                else if (mainWindow.mode === "FillFigure" && isClosed) {
                    fillColor = scene.fillColor;
                    isFilled = true;
                    parent.requestPaint();
                    scene.fillFigure(figure, fillColor);
                }
            }

            onMouseXChanged: {
                if (!isPressed) {
                    return;
                }

                if (mainWindow.mode === "SelectFigure") {
                    var dx = mouseX - previousX
                    figure.anchors.leftMargin += dx;
                }
            }

            onMouseYChanged: {
                if (!isPressed) {
                    return;
                }

                if (mainWindow.mode === "SelectFigure") {
                    var dy = mouseY - previousY
                    figure.anchors.topMargin += dy;
                }

            }

            onReleased: {
                isPressed = false;

                if (mode === "SelectFigure" &&
                        (movedX != 0 || movedY != 0)) {
                    scene.moveFigure(figure);
                }
            }
        }

    }

    BBoxActionPoint {
        id: topLeftCorner
        position: "topLeft"
    }

    BBoxActionPoint {
        id: topRightCorner
        position: "topRight"
    }

    BBoxActionPoint {
        id: bottomLeftCorner
        position: "bottomLeft"
    }

    BBoxActionPoint {
        id: bottomRightCorner
        position: "bottomRight"
    }

    BBoxActionPoint {
        id: topMiddle
        position: "topMiddle"
    }

    BBoxActionPoint {
        id: bottomMiddle
        position: "bottomMiddle"
    }

    BBoxActionPoint {
        id: leftMiddle
        position: "leftMiddle"
    }

    BBoxActionPoint {
        id: rightMiddle
        position: "rightMiddle"
    }

}
