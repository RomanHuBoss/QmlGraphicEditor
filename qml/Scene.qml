/*
  QML-template of main scene area
  Author: Rabinovich R.M.
  You can use & modificate the following code without any restrictions
  Date: 10.11.2017
*/

import QtQuick 2.0

Rectangle {
    clip: true

    property string activeFigureUid

    anchors {
        top: parent.top
        bottom: parent.bottom
        left: generalButtons.right
        right: parent.right
    }

    Image {
        fillMode: Image.Tile
        opacity: 0.2
        anchors.fill: parent
        source: "qrc:/backgrounds/scene-background.jpg"
    }

    Canvas {
        id: drawingCanvas
        anchors.fill: parent

        property variant vertices: []
        property bool started: false
        property bool finished: false
        property int strokeWidth: 1                 //ширина линии фигуры
        property string strokeColor: "#000000"      //цвет линии
        property double tmpX
        property double tmpY

        property variant knownDrawModes: [
            "DrawLineSegment",
            "DrawTriangle",
            "DrawRectangle",
            "DrawSquare",
            "DrawMultiline",
            "DrawPolygon"
        ];

        property variant isClosed: {
            "DrawLineSegment":  false,
            "DrawTriangle":     true,
            "DrawRectangle":    true,
            "DrawSquare":       true,
            "DrawMultiline":    false,
            "DrawPolygon":      true
        }

        property variant minVertices: {
            "DrawLineSegment":  2,
            "DrawTriangle":     3,
            "DrawRectangle":    4,
            "DrawSquare":       4,
            "DrawMultiline":    2,
            "DrawPolygon":      3
        }

        property variant maxVertices: {
            "DrawLineSegment":  2,
            "DrawTriangle":     3,
            "DrawRectangle":    3,
            "DrawSquare":       2,
            "DrawMultiline":    +Infinity,
            "DrawPolygon":      +Infinity
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onDoubleClicked: {
                if (parent.knownDrawModes.indexOf(mainWindow.mode) === -1)
                    return;
                else if (!parent.started || parent.finished)
                    return;

                if (mainWindow.mode === "DrawMultiline" &&
                        parent.vertices.length >= parent.minVertices[mainWindow.mode]) {
                    parent.vertices.push({x: mouseX, y:mouseY});
                    parent.finished = true;
                }
                else if (mainWindow.mode === "DrawPolygon" &&
                         parent.vertices.length >= parent.minVertices[mainWindow.mode]) {
                    parent.finished = true;
                }
            }

            onPressed: {
                if (parent.knownDrawModes.indexOf(mainWindow.mode) === -1)
                    return;
                else if (parent.finished)
                    return;

                parent.vertices.push({x: mouseX, y:mouseY});

                if (!parent.started) {
                    parent.started = true;
                }

                parent.requestPaint();

                if (parent.vertices.length >= parent.maxVertices[mainWindow.mode]) {
                    parent.finished = true;
                }
            }

            onMouseXChanged: {
                if (parent.knownDrawModes.indexOf(mainWindow.mode) === -1)
                    return;
                else if (!parent.started || parent.finished)
                    return;

                var ctx = parent.getContext("2d");
                ctx.reset();

                parent.tmpX = mouseX;
                parent.requestPaint();
            }

            onMouseYChanged: {
                if (parent.knownDrawModes.indexOf(mainWindow.mode) === -1)
                    return;
                else if (!parent.started || parent.finished)
                    return;

                var ctx = parent.getContext("2d");
                ctx.reset();

                parent.tmpY = mouseY;
                parent.requestPaint();
            }
        }

        onFinishedChanged: {
            if (finished === true) {

                vertices = [];

                var ctx = getContext("2d");
                ctx.reset();

                started = false;
                finished = false;
                tmpX = -Math.Infinity;
                tmpY = -Math.Infinity;
            }
        }

        onPaint: {
            if (vertices.length < 1)
                return;

            var ctx = getContext("2d");

            if (tmpX != -Math.Infinity && tmpY != -Math.Infinity) {
                ctx.beginPath();
                ctx.strokeStyle = "#ff0000";
                ctx.lineWidth = 1;
                ctx.moveTo(vertices[vertices.length-1].x, vertices[vertices.length-1].y);
                ctx.lineTo(tmpX, tmpY);
                ctx.stroke();
                ctx.closePath();

                ctx.beginPath();
                ctx.moveTo(tmpX, tmpY);
                ctx.fillStyle = "#ff0000";
                ctx.arc(tmpX, tmpY, 4, 0, Math.PI * 2, false);
                ctx.fill();
                ctx.closePath();

                if (mainWindow.mode == "DrawTriangle" && vertices.length == 2) {
                    ctx.beginPath();
                    ctx.strokeStyle = "#ff0000";
                    ctx.lineWidth = 1;
                    ctx.moveTo(tmpX, tmpY);
                    ctx.lineTo(vertices[0].x, vertices[0].y);
                    ctx.lineTo(vertices[1].x, vertices[1].y);
                    ctx.stroke();
                    ctx.closePath();
                }
                else if (mainWindow.mode == "DrawSquare" && vertices.length == 1) {
                    var dx = tmpX - vertices[0].x;
                    var dy = tmpY - vertices[0].y;

                    var x3 = tmpX - dy;
                    var y3 = tmpY + dx;

                    var x4 = vertices[0].x - dy;
                    var y4 = vertices[0].y + dx;

                    ctx.beginPath();
                    ctx.strokeStyle = "#ff0000";
                    ctx.lineWidth = 1;
                    ctx.moveTo(tmpX, tmpY);
                    ctx.lineTo(x3, y3);

                    ctx.moveTo(x3, y3);
                    ctx.lineTo(x4, y4);

                    ctx.moveTo(x4, y4);
                    ctx.lineTo(vertices[0].x, vertices[0].y);

                    ctx.stroke();
                    ctx.closePath();
                }
                else if (mainWindow.mode == "DrawRectangle" && vertices.length == 2) {
                }
                else if (mainWindow.mode == "DrawPolygon" && vertices.length >= 2) {
                    ctx.beginPath();
                    ctx.strokeStyle = "#ff0000";
                    ctx.lineWidth = 1;
                    ctx.moveTo(tmpX, tmpY);
                    ctx.lineTo(vertices[0].x, vertices[0].y);
                    ctx.stroke();
                    ctx.closePath();
                }

            }

            for (var i = 0; i < vertices.length; i++) {
                ctx.beginPath();
                ctx.moveTo(vertices[i].x, vertices[i].y);
                ctx.fillStyle = strokeColor;
                ctx.arc(vertices[i].x, vertices[i].y, 4, 0, Math.PI * 2, false);
                ctx.fill();
                ctx.closePath();
            }

            ctx.beginPath();
            ctx.strokeStyle = strokeColor;
            ctx.lineWidth = strokeWidth;

            for (i = 0; i < vertices.length; i++) {
                if (i > 0) {
                    ctx.moveTo(vertices[i-1].x, vertices[i-1].y);
                    ctx.lineTo(vertices[i].x, vertices[i].y);
                }
            }

            if (vertices.length > 2 && finished && isClosed[mainWindow.mode]) {
                ctx.moveTo(vertices[vertices.length-1].x, vertices[vertices.length-1].y);
                ctx.lineTo(vertices[0].x, vertices[0].y);
            }

            ctx.stroke();
            ctx.closePath();
        }
    }

    /*
    Figure {
        width: 300
        height: 300
        offsetLeft: 20
        offsetTop: 50
    }*/

}
