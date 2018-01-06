import QtQuick 2.9

Rectangle {
    id: figure
    color: "transparent"

    property string type: "uknown"  //тип фигуры
    property bool isClosed: false   //признак замкнутой фигуры
    property variant vertices: [{x:5, y:7}, {x: 20, y: 40}]   //массив вершин {x,y}
    property double offsetLeft: 0
    property double offsetTop: 0
    property double minWidth: 20
    property double minHeight: 20

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
            var ctx = getContext("2d");
            ctx.strokeStyle = Qt.rgba(0, 0, 0, 1);
            ctx.lineWidth = 1;
            ctx.beginPath();
            ctx.moveTo(parent.vertices[0].x, parent.vertices[0].y);

            for (var i = 1; i < parent.vertices.length; i++) {
                ctx.lineTo(parent.vertices[i].x, parent.vertices[i].y);
                ctx.moveTo(parent.vertices[i].x, parent.vertices[i].y);
            }
            ctx.closePath();
            ctx.stroke();
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
