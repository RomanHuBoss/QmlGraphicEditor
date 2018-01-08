/*
  QML-template of main scene area
  Author: Rabinovich R.M.
  You can use & modificate the following code without any restrictions
  Date: 10.11.2017
*/

import QtQuick 2.0

Rectangle {
    id: root
    clip: true

    property int figuresQuant: 0;
    property var activeFigure
    property string prevMode

    property var moveFigure: function(figure) {
        prevMode = "SelectFigure";
        appInteractor.onMoveQmlFigure(figure.uid, figure.movedX, figure.movedY);
        figure.destroy();
    }

    property var fillFigure: function(figure, color) {
        prevMode = "FillFigure";
        appInteractor.onFillQmlFigure(figure.uid, figure.fillColor);
        figure.destroy();
    }

    property var updateFigure: function(figure) {
        if (figure.rotationAngle !== 0) {
            prevMode = "RotateFigure";
            appInteractor.onRotateQmlFigure(figure.uid, figure.rotationAngle);
            figure.destroy();
        }
    }

    property var removeFigure: function(figure) {
        prevMode = "RemoveFigure"
        appInteractor.onRemoveQmlFigure(figure.uid);
        figure.destroy();
        figuresQuant = appInteractor.figuresQuant();
    }

    onFiguresQuantChanged: {
        generalButtons.saveBtn.state = (Number(scene.figuresQuant) > 0) ?
                    "normal" : "disabled"
    }

    property var getFigureByUid: function(uid) {
        for(var i = 0; i < root.children.length; ++i) {
            if("uid" in root.children[i] && root.children[i].uid === uid) {
                return root.children[i];
            }
        }
        return null;
    }

    property var addNewFigure: function(data) {

        var component = Qt.createComponent("qrc:/Figure.qml");
        if (component.status === Component.Ready) {

            //в силу того, что левый верхний угол холста имеет координату (0,0),
            //причем Y нарастает при движении вниз по оси, а реализованный ранее Qt (c++)
            //набор классов работает в декартовой системе, то
            var bboxOffsetTop = Number(data.bbox[3][1]);
            var bboxOffsetLeft = Number(data.bbox[0][0]);
            var bboxWidth = data.bbox[1][0] - data.bbox[0][0];
            var bboxHeight = data.bbox[0][1] - data.bbox[3][1];

            //вершины фигуры
            var vertices = [];
            for (var i in data.points) {
                vertices.push({x: Number(data.points[i][0])-bboxOffsetLeft, y: Number(data.points[i][1])-bboxOffsetTop});
            }

            var sprite = component.createObject(this,
                {
                    "uid": data["uid"],
                    "isClosed": data.isClosed,
                    "isFilled": data.isFilled,
                    "fillColor": data.fillColor,
                    "type": data.type,
                    "offsetLeft": bboxOffsetLeft,
                    "offsetTop": bboxOffsetTop,
                    "width": bboxWidth,
                    "height": bboxHeight,
                    "vertices": vertices
                }
            );

            activeFigure = sprite;

            if (prevMode !== "" && mainWindow.mode !== prevMode) {
                mainWindow.mode = prevMode;
            }
            else if (prevMode === "") {
                mainWindow.mode = "SelectFigure";
            }

            prevMode = "";

            figuresQuant = appInteractor.figuresQuant();
        }
    }

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
        property variant tmpVertices: []
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
            "DrawRectangle":    3,
            "DrawSquare":       2,
            "DrawMultiline":    2,
            "DrawPolygon":      3
        }

        property variant maxVertices: {
            "DrawLineSegment":  2,
            "DrawTriangle":     3,
            "DrawRectangle":    4,
            "DrawSquare":       4,
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

                    if (Math.abs(mouseX - parent.vertices[0].x) > 5 || Math.abs(mouseY - parent.vertices[0].y) > 5) {
                        parent.vertices.push({x: mouseX, y:mouseY});
                    }

                    parent.finished = true;
                }
            }

            onPressed: {
                if (parent.knownDrawModes.indexOf(mainWindow.mode) === -1)
                    return;
                else if (parent.finished)
                    return;

                if (!parent.started) {
                    parent.started = true;
                }

                parent.vertices.push({x: mouseX, y:mouseY});

                if ((mainWindow.mode == "DrawRectangle" || mainWindow.mode == "DrawSquare") && parent.vertices.length >= parent.minVertices[mainWindow.mode] ) {
                    parent.vertices = parent.tmpVertices.slice(0);;
                    parent.finished = true;
                }
                else if (parent.vertices.length >= parent.maxVertices[mainWindow.mode]) {
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
                //отправляем информацию в Qt
                var consoled = "";
                for (var i = 0; i < vertices.length; i++) {
                    consoled += "(" + vertices[i].x + "," + vertices[i].y + "); ";
                }
                console.log(consoled);

                var figureData = {};
                figureData.mode = mainWindow.mode;
                figureData.vertices = vertices;
                appInteractor.onAddQmlFigure(figureData);

                started = false;
                finished = false;
                tmpX = -Math.Infinity;
                tmpY = -Math.Infinity;
                vertices = [];
                tmpVertices = [];

                var ctx = getContext("2d");
                ctx.reset();
                requestPaint();
            }
        }

        onPaint: {
            if (vertices.length < 1)
                return;

            var ctx = getContext("2d");

            if (tmpX != -Math.Infinity && tmpY != -Math.Infinity) {

                if (mainWindow.mode !== "DrawRectangle" ||
                        (mainWindow.mode === "DrawRectangle" && vertices.length < 2)) {
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
                }

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

                    tmpVertices = vertices.slice(0);
                    tmpVertices.push({x: tmpX, y: tmpY});
                    tmpVertices.push({x: x3, y: y3});
                    tmpVertices.push({x: x4, y: y4});
                }
                else if (mainWindow.mode == "DrawRectangle" && vertices.length == 2) {
                    var x3, y3, x4, y4;

                    if (vertices[1].x !== vertices[0].x) {
                        //угловой коэффициент
                        var k = (vertices[1].y - vertices[0].y)/(vertices[1].x-vertices[0].x)
                        var ySearch = -1/k*(tmpX - vertices[1].x) + vertices[1].y;
                        var xSearch = -k*(tmpY - vertices[1].y) + vertices[1].x;

                        if (Math.abs(tmpX - xSearch) > Math.abs(tmpY - ySearch)) {
                            x3 = -k*(ySearch - vertices[1].y) + vertices[1].x;
                            y3 = ySearch;
                        }
                        else {
                            x3 = xSearch;
                            y3 = -1/k*(x3 - vertices[1].x) + vertices[1].y;
                        }
                    }
                    else {
                        x3 = tmpX;
                        y3 = vertices[1].y;
                    }

                    var midpX = (vertices[0].x + x3)/2;
                    var midpY = (vertices[0].y + y3)/2;

                    var x4 = 2*midpX - vertices[1].x;
                    var y4 = 2*midpY - vertices[1].y;

                    ctx.beginPath();
                    ctx.strokeStyle = "#ff0000";
                    ctx.lineWidth = 1;
                    ctx.moveTo(vertices[1].x, vertices[1].y);
                    ctx.lineTo(x3, y3);
                    ctx.moveTo(x3, y3);
                    ctx.lineTo(x4, y4);
                    ctx.moveTo(x4, y4);
                    ctx.lineTo(vertices[0].x, vertices[0].y);
                    ctx.stroke();
                    ctx.closePath();

                    ctx.beginPath();
                    ctx.moveTo(x3, y3);
                    ctx.fillStyle = "#ff0000";
                    ctx.arc(x3, y3, 4, 0, Math.PI * 2, false);
                    ctx.fill();
                    ctx.closePath();

                    tmpVertices = vertices.slice(0);
                    tmpVertices.push({x: x3, y: y3});
                    tmpVertices.push({x: x4, y: y4});

                    //console.log("(" + tmpVertices[0].x + "," + tmpVertices[0].y + "); (" + tmpVertices[1].x + ", " + tmpVertices[1].y + "); (" + tmpVertices[2].x + ", " + tmpVertices[2].y + "); (" + tmpVertices[3].x + ", " + tmpVertices[3].y + ")");
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

}
